use core::hash::{BuildHasherDefault, Hasher};
use hashbrown::HashMap as RawHashMap;
use sha3::{Digest, Sha3_512};

/// Returns the first 64 bits of a 512-bit hash
pub fn u64_from_slice(slice: &mut [u8]) -> u64 {
    u64::from_be_bytes(slice.split_at_mut(8).0.try_into().unwrap())
}

/// Default HashMap hasher that uses SHA3-512 instead of AHash for improved security and better integrity checking
#[derive(Default)]
pub struct KernelHasher(Sha3_512);

impl Hasher for KernelHasher {
    fn finish(&self) -> u64 {
        u64_from_slice(self.0.clone().finalize().as_mut_slice())
    }

    fn write(&mut self, bytes: &[u8]) {
        self.0.update(bytes)
    }
}

pub type KernelHashBuilder = BuildHasherDefault<KernelHasher>;
pub type HashMap<K, V> = RawHashMap<K, V, KernelHashBuilder>;
pub type Result<T> = syscall::Result<T, syscall::Error>;
