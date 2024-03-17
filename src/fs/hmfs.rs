use alloc::borrow::ToOwned;
use alloc::string::String;
use alloc::sync::Arc;
use alloc::vec::Vec;
use core::hash::{BuildHasher, Hash, Hasher};
use mr_mime::Mime;
use syscall::{Error, ENOTDIR};
use unix_path::{Path, PathBuf};

use crate::common::hash_map::HashMap;

// going one-further than most other implementations to ensure this never overflows
#[allow(non_camel_case_types)]
pub type time_t = i128;

pub type FileData = Vec<u8>;

#[derive(Debug, Clone, Eq, PartialEq)]
pub enum EntryKind<'a> {
    Directory(Arc<HashMap<Properties<'a>, Arc<Entry<'a>>>>),
    File(FileData),
    Root(Arc<RootEntry<'a>>),
}

impl Hash for EntryKind<'_> {
    fn hash<H: Hasher>(&self, state: &mut H) {
        match self {
            Self::Directory(map) => {
                for (properties, entry) in map.iter() {
                    properties.hash(state);
                    entry.hash(state);
                }
            }
            Self::File(data) => {
                data.hash(state);
            }
            Self::Root(root) => {
                root.hash(state);
            }
        }
    }
}

pub fn new_map_shorthand<'a>() -> HashMap<Properties<'a>, Arc<Entry<'a>>> {
    HashMap::<Properties<'a>, Arc<Entry<'a>>>::default()
}

#[derive(Debug, Clone, Eq, PartialEq, Hash)]
pub struct Entry<'a> {
    kind: EntryKind<'a>,
    checksum: u64,
    parent: Option<EntryKind<'a>>,
}

impl<'a> Entry<'a> {
    pub fn new(kind: EntryKind<'a>, parent: Option<EntryKind<'a>>) -> Self {
        let mut new = Self {
            kind,
            checksum: 0x0,
            parent: parent.clone(),
        };

        if let Some(parent) = parent {
            match parent {
                EntryKind::Directory(dir) => {
                    new.checksum = dir.hasher().hash_one(&new);
                }
                EntryKind::File(_) => panic!("Parent must be a directory"),
                EntryKind::Root(root) => {
                    let root = Arc::clone(&root);
                    let root = root.get_root_dir();

                    if let EntryKind::Directory(dir) = root.kind {
                        new.checksum = dir.hasher().hash_one(&new);
                    } else {
                        unreachable!("always a directory here")
                    }
                }
            }
        };

        new
    }
    pub fn parent(&self) -> Option<EntryKind> {
        self.parent.clone()
    }
    pub fn mkdir(&self, name: String, timestamp: time_t) -> syscall::Result<Self> {
        match self.kind.clone() {
            EntryKind::Directory(mut dir) => {
                let parent = Some(EntryKind::Directory(dir.clone()));

                let new_map_inner = new_map_shorthand();
                let new_map = Arc::new(new_map_inner);

                let props = Properties::new(
                    name,
                    EntryKind::Directory(dir.clone()),
                    None,
                    0o777,
                    String::from("root"), // TODO: users
                    timestamp,
                    timestamp,
                    String::from("root"), // TODO: users
                );

                let kind = EntryKind::Directory(new_map);
                let checksum = dir.hasher().hash_one(&kind);

                let to_insert = Self {
                    kind,
                    checksum,
                    parent,
                };

                let mut_dir = Arc::make_mut(&mut dir);
                mut_dir.insert(props.clone(), Arc::new(to_insert));

                let ret = Arc::make_mut(Arc::make_mut(&mut dir).get_mut(&props).unwrap());
                Ok(ret.clone())
            }
            EntryKind::Root(mut root) => {
                if let EntryKind::Directory(ref mut dir) = Arc::make_mut(&mut root).dir.kind {
                    let parent = Some(EntryKind::Directory(dir.clone()));

                    let new_map_inner = new_map_shorthand();
                    let new_map = Arc::new(new_map_inner);

                    let props = Properties::new(
                        name,
                        EntryKind::Directory(dir.clone()),
                        None,
                        0o777,
                        String::from("root"), // TODO: users
                        timestamp,
                        timestamp,
                        String::from("root"), // TODO: users
                    );

                    let kind = EntryKind::Directory(new_map);
                    let checksum = dir.hasher().hash_one(&kind);

                    let to_insert = Self {
                        kind,
                        checksum,
                        parent,
                    };

                    let mut_dir = Arc::make_mut(dir);
                    mut_dir.insert(props.clone(), Arc::new(to_insert));

                    let ret = dir.get(&props).cloned().unwrap();
                    Ok(ret.clone().as_ref().clone())
                } else {
                    unreachable!("root entry is always a directory")
                }
            }
            EntryKind::File(_) => Err(Error::new(ENOTDIR)),
        }
    }
    pub fn create_file(
        &self,
        mime: Mime<'a>,
        name: String,
        timestamp: time_t,
        data: FileData,
    ) -> syscall::Result<Self> {
        match self.kind.clone() {
            EntryKind::Directory(ref mut dir) => {
                let parent = EntryKind::Directory(dir.clone());

                // borrow checker
                let duplicate = parent.clone();

                let props = Properties::new(
                    name,
                    parent,
                    Some(mime),
                    0o777,                // TODO: users and permissions
                    String::from("root"), // TODO: users and permissions
                    timestamp,
                    timestamp,
                    String::from("root"), // TODO: users and permissions
                );

                let mut props_arc = Arc::new(props);

                // borrow checker
                let parent = duplicate;

                let kind = EntryKind::File(data);
                let checksum = dir.hasher().hash_one(&kind);

                let to_insert = Self {
                    kind,
                    checksum,
                    parent: Some(parent),
                };

                Arc::make_mut(dir)
                    .insert(Arc::make_mut(&mut props_arc).clone(), Arc::new(to_insert));

                let ret = dir.get(Arc::make_mut(&mut props_arc)).cloned().unwrap();
                Ok(ret.as_ref().clone())
            }
            EntryKind::File(_) => Err(Error::new(ENOTDIR)), // Not a directory
            EntryKind::Root(ref mut root) => {
                // TODO: throw EACCES if a non-root user attempts this
                if let EntryKind::Directory(ref mut dir) = Arc::make_mut(root).dir.kind {
                    let parent = EntryKind::Directory(dir.clone());

                    // borrow checker
                    let duplicate = parent.clone();

                    let props = Properties::new(
                        name,
                        parent,
                        Some(mime),
                        0o777,                // TODO: users and permissions
                        String::from("root"), // TODO: users and permissions
                        timestamp,
                        timestamp,
                        String::from("root"), // TODO: users and permissions
                    );

                    let mut props_arc = Arc::new(props);

                    // borrow checker
                    let parent = duplicate;

                    let kind = EntryKind::File(data);
                    let checksum = dir.hasher().hash_one(&kind);

                    let to_insert = Self {
                        kind,
                        checksum,
                        parent: Some(parent),
                    };

                    Arc::make_mut(dir)
                        .insert(Arc::make_mut(&mut props_arc).clone(), Arc::new(to_insert));

                    let ret = dir.get(Arc::make_mut(&mut props_arc)).cloned().unwrap();
                    Ok(ret.as_ref().clone())
                } else {
                    unreachable!("root entry is always a directory")
                }
            } // TODO: give root an exception to this
        }
    }
}

#[derive(Debug, Clone, Eq, PartialEq, Hash)]
#[non_exhaustive]
pub struct Properties<'a> {
    name: String,
    full_path: PathBuf,
    entry_kind: EntryKind<'a>,
    mime_type: Option<Mime<'a>>,
    mode: u32,
    created_by: String,
    date_created: time_t,
    date_modified: time_t,
    owner: String,
}

#[allow(clippy::too_many_arguments)]
impl<'a> Properties<'a> {
    pub fn new(
        name: String,
        entry_kind: EntryKind<'a>,
        mime_type: Option<Mime<'a>>,
        mode: u32,
        created_by: String,
        date_created: time_t,
        date_modified: time_t,
        owner: String,
    ) -> Self {
        // borrow checker
        let cloned = name.clone();

        Self {
            name,
            full_path: Path::new(cloned.as_str()).to_owned(),
            entry_kind,
            mime_type,
            mode,
            created_by,
            date_created,
            date_modified,
            owner,
        }
    }
}

// Pave the way for (partition) formatting
pub fn root_entry_bytes(entry: RootEntry) -> &'static mut [u8] {
    let map_addr = &entry as *const _ as usize as u64;
    unsafe {
        core::slice::from_raw_parts_mut::<'static>(
            map_addr as *mut u8,
            core::mem::size_of::<RootEntry>(),
        )
    }
}

#[derive(Debug, Clone, Eq, PartialEq, Hash)]
#[allow(dead_code)]
pub struct RootEntry<'a> {
    magic: u32,
    system_clock: time_t,
    entry_count: usize,
    checksum: u64,
    dir: Entry<'a>,
}

impl<'a> RootEntry<'a> {
    pub fn new(timestamp: time_t) -> Self {
        let mut root_map_inner = new_map_shorthand();
        let root_map = Arc::new(root_map_inner.clone());

        let root_props = Properties::new(
            String::from("/"),
            EntryKind::Directory(Arc::clone(&root_map)),
            None,
            0o777,
            String::from("root"),
            timestamp,
            timestamp,
            String::from("root"),
        );

        root_map_inner.insert(
            root_props.clone(),
            Arc::new(Entry::new(
                EntryKind::Directory(Arc::clone(&root_map)),
                None,
            )),
        );

        drop(root_map);

        let new_root_map = Arc::new(root_map_inner);
        let old_entry = Entry::new(EntryKind::Directory(new_root_map.clone()), None);

        let mut new_entry_parent = Self {
            magic: 0x90a7cafe,
            system_clock: timestamp,
            entry_count: Arc::strong_count(&new_root_map),
            checksum: new_root_map.hasher().hash_one(&old_entry),
            dir: old_entry,
        };

        let new_entry = Entry::new(
            EntryKind::Directory(new_root_map.clone()),
            Some(EntryKind::Root(Arc::new(new_entry_parent.clone()))),
        );
        new_entry_parent.dir = new_entry.clone();

        // keep these values up-to-date
        new_entry_parent.dir.parent = Some(EntryKind::Root(Arc::new(new_entry_parent.clone())));
        new_entry_parent.dir.kind = EntryKind::Directory(new_root_map.clone());
        new_entry_parent.checksum = new_root_map.hasher().hash_one(&new_entry);

        // shadow this
        let new_entry = new_entry_parent.dir.clone();

        // keep HashMap up-to-date
        if let EntryKind::Directory(ref mut dir) = &mut new_entry_parent.dir.kind {
            Arc::get_mut(dir).unwrap().remove_entry(&root_props);
            Arc::get_mut(dir)
                .unwrap()
                .insert(root_props, Arc::new(new_entry));
        } else {
            unreachable!()
        }

        new_entry_parent
    }
    pub fn get_root_dir(&self) -> Entry {
        assert_eq!(self.magic, 0x90a7cafe); // TODO: find a compiler-level way to do this
        self.dir.clone()
    }
}
