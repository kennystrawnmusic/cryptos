// SPDX-License-Identifier: GPL-3.0-or-later
use alloc::alloc::Global;
use alloc::boxed::Box;
use alloc::rc::Rc;
use alloc::string::String;
use alloc::vec::Vec;
use core::convert::TryInto;
use core::hash::{BuildHasherDefault, Hash, Hasher};
use sha3::{Digest, Sha3_512};
use unix_path::PathBuf;

// return the first 64 bits of a 512-bit hash
pub fn u64_from_slice(slice: &mut [u8]) -> u64 {
    u64::from_ne_bytes(slice.split_at_mut(8).0.try_into().unwrap())
}

// need something far more secure than AHash here to pave the way for things like per-directory encryption
#[derive(Default)]
pub struct HMFSHasher(Sha3_512);

impl Hasher for HMFSHasher {
    fn finish(&self) -> u64 {
        u64_from_slice(self.0.clone().finalize().as_mut_slice())
    }

    fn write(&mut self, bytes: &[u8]) {
        self.0.update(bytes)
    }
}

pub type HMFSHashBuilder = BuildHasherDefault<HMFSHasher>;
pub type HashMap<K, V> = hashbrown::HashMap<K, V, HMFSHashBuilder>;

// going one-further than most other implementations to ensure this never overflows
#[allow(non_camel_case_types)]
pub type time_t = i128;

pub type FileData = Vec<u8>;

// work around Box not implementing Hash

#[derive(Debug, Clone, Eq, PartialEq)]
pub enum EntryKind {
    Directory(Rc<HashMap<Properties, Rc<Entry>>>),
    File(FileData),
}

impl Hash for EntryKind {
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
        }
    }
}

pub fn new_map_shorthand() -> HashMap<Properties, Rc<Entry>> {
    HashMap::<Properties, Rc<Entry>>::default()
}

#[derive(Debug, Clone, Eq, PartialEq, Hash)]
pub struct Entry {
    kind: EntryKind,
    parent: Option<EntryKind>,
}

impl Entry {
    pub fn new(kind: EntryKind, parent: Option<EntryKind>) -> Self {
        Self {
            kind,
            parent,
        }
    }
    pub fn parent(&self) -> Option<EntryKind> {
        self.parent.clone()
    }
    pub fn mkdir(&self, name: String, timestamp: time_t) -> Self {
        match self.kind.clone() {
            EntryKind::Directory(mut dir) => {
                let parent = Some(EntryKind::Directory(dir.clone()));

                let new_map_inner = new_map_shorthand();
                let new_map = Rc::new(new_map_inner);

                let props = Properties::new(
                    name,
                    EntryKind::Directory(dir.clone()),
                    None,
                    0777,
                    String::from("root"), // TODO: users
                    timestamp,
                    timestamp,
                    String::from("root"), // TODO: users
                );

                let kind = EntryKind::Directory(new_map);

                let to_insert = Self {
                    kind,
                    parent
                };

                let mut_dir = Rc::get_mut(&mut dir).unwrap();
                mut_dir.insert(props.clone(), Rc::new(to_insert));

                let ret =  dir.get(&props).clone().unwrap();
                ret.clone().as_ref().clone()
            }
            EntryKind::File(_) => panic!("Not a directory"),
        }
    }
}

#[derive(Debug, Clone, Eq, PartialEq, Hash)]
pub struct Properties {
    name: String,
    entry_kind: EntryKind,
    mime_type: Option<String>,
    mode: u32,
    created_by: String,
    date_created: time_t,
    date_modified: time_t,
    owner: String,
}

impl Properties {
    pub fn new(
        name: String,
        entry_kind: EntryKind,
        mime_type: Option<String>,
        mode: u32,
        created_by: String,
        date_created: time_t,
        date_modified: time_t,
        owner: String,
    ) -> Self {
        Self {
            name,
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
        core::slice::from_raw_parts_mut(map_addr as *mut u8, core::mem::size_of::<RootEntry>())
    }
}

#[allow(dead_code)]
pub struct RootEntry {
    magic: u32,
    system_clock: time_t,
    entry_count: usize,
    dir: Entry,
}

impl RootEntry {
    pub fn new(timestamp: time_t) -> Self {
        let mut root_map_inner = new_map_shorthand();
        let root_map = Rc::new(root_map_inner.clone());

        let root_props = Properties::new(
            String::from("/"),
            EntryKind::Directory(Rc::clone(&root_map)),
            None,
            0777,
            String::from("root"),
            timestamp,
            timestamp,
            String::from("root"),
        );

        root_map_inner.insert(
            root_props,
            Rc::new(Entry::new(EntryKind::Directory(Rc::clone(&root_map)), None)),
        );

        drop(root_map);

        let new_root_map = Rc::new(root_map_inner);

        Self {
            magic: 0x90a7cafe,
            system_clock: timestamp,
            entry_count: Rc::strong_count(&new_root_map),
            dir: Entry::new(EntryKind::Directory(new_root_map), None),
        }
    }
}
