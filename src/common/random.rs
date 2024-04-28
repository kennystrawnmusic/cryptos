use rand_core::{RngCore, SeedableRng};
use super::large_numbers::{u256, u512};
use core::intrinsics::{cosf64, sinf64};
use num_traits::float::FloatCore;

struct TrigRng {
    seed: u512,
}

impl RngCore for TrigRng {
    fn next_u32(&mut self) -> u32 {
        let mut seed_base_a = 0u128;
        let mut seed_base_b = 0u128;
        let mut seed_base_c = 0u128;
        let mut seed_base_d = 0u128;

        let seed_base_ptr_a = &mut seed_base_a as *mut u128;
        let seed_base_ptr_b = &mut seed_base_b as *mut u128;
        let seed_base_ptr_c = &mut seed_base_c as *mut u128;
        let seed_base_ptr_d = &mut seed_base_d as *mut u128;

        // update seed values using memory addresses that the pointers point to
        seed_base_a = seed_base_ptr_a as usize as u128;
        seed_base_b = seed_base_ptr_b as usize as u128;
        seed_base_c = seed_base_ptr_c as usize as u128;
        seed_base_d = seed_base_ptr_d as usize as u128;
    
        let seed_256_a = u256::new(seed_base_a, seed_base_b);
        let seed_256_b = u256::new(seed_base_c, seed_base_d);
        
        let mut full_seed = u512::new(seed_256_a, seed_256_b);

        let a = unsafe { cosf64(f64::from(full_seed))};
        let b = unsafe { sinf64(f64::from(full_seed))};

        full_seed *= (a + b).abs();
        
        for _ in 0..(((a + b).abs() * 4096f64) as u64) {
            let mut seed_base_a = 0u128;
            let mut seed_base_b = 0u128;
            let mut seed_base_c = 0u128;
            let mut seed_base_d = 0u128;

            let seed_base_ptr_a = &mut seed_base_a as *mut u128;
            let seed_base_ptr_b = &mut seed_base_b as *mut u128;
            let seed_base_ptr_c = &mut seed_base_c as *mut u128;
            let seed_base_ptr_d = &mut seed_base_d as *mut u128;

            // update seed values using memory addresses that the pointers point to
            seed_base_a = seed_base_ptr_a as usize as u128;
            seed_base_b = seed_base_ptr_b as usize as u128;
            seed_base_c = seed_base_ptr_c as usize as u128;
            seed_base_d = seed_base_ptr_d as usize as u128;
        
            let seed_256_a = u256::new(seed_base_a, seed_base_b);
            let seed_256_b = u256::new(seed_base_c, seed_base_d);
            
            let mut full_seed = u512::new(seed_256_a, seed_256_b);

            let a = unsafe { cosf64(f64::from(full_seed))};
            let b = unsafe { sinf64(f64::from(full_seed))};

            full_seed *= (a + b).abs();
        }

        self.seed = full_seed;
        u32::from(full_seed)
    }
    
    fn next_u64(&mut self) -> u64 {
        let mut seed_base_a = 0u128;
        let mut seed_base_b = 0u128;
        let mut seed_base_c = 0u128;
        let mut seed_base_d = 0u128;

        let seed_base_ptr_a = &mut seed_base_a as *mut u128;
        let seed_base_ptr_b = &mut seed_base_b as *mut u128;
        let seed_base_ptr_c = &mut seed_base_c as *mut u128;
        let seed_base_ptr_d = &mut seed_base_d as *mut u128;

        // update seed values using memory addresses that the pointers point to
        seed_base_a = seed_base_ptr_a as usize as u128;
        seed_base_b = seed_base_ptr_b as usize as u128;
        seed_base_c = seed_base_ptr_c as usize as u128;
        seed_base_d = seed_base_ptr_d as usize as u128;
    
        let seed_256_a = u256::new(seed_base_a, seed_base_b);
        let seed_256_b = u256::new(seed_base_c, seed_base_d);
        
        let mut full_seed = u512::new(seed_256_a, seed_256_b);

        let a = unsafe { cosf64(f64::from(full_seed))};
        let b = unsafe { sinf64(f64::from(full_seed))};

        full_seed *= (a + b).abs();
        
        for _ in 0..(((a + b).abs() * 4096f64) as u64) {
            let mut seed_base_a = 0u128;
            let mut seed_base_b = 0u128;
            let mut seed_base_c = 0u128;
            let mut seed_base_d = 0u128;

            let seed_base_ptr_a = &mut seed_base_a as *mut u128;
            let seed_base_ptr_b = &mut seed_base_b as *mut u128;
            let seed_base_ptr_c = &mut seed_base_c as *mut u128;
            let seed_base_ptr_d = &mut seed_base_d as *mut u128;

            // update seed values using memory addresses that the pointers point to
            seed_base_a = seed_base_ptr_a as usize as u128;
            seed_base_b = seed_base_ptr_b as usize as u128;
            seed_base_c = seed_base_ptr_c as usize as u128;
            seed_base_d = seed_base_ptr_d as usize as u128;
        
            let seed_256_a = u256::new(seed_base_a, seed_base_b);
            let seed_256_b = u256::new(seed_base_c, seed_base_d);
            
            let mut full_seed = u512::new(seed_256_a, seed_256_b);

            let a = unsafe { cosf64(f64::from(full_seed))};
            let b = unsafe { sinf64(f64::from(full_seed))};

            full_seed *= (a + b).abs();
        }

        self.seed = full_seed;
        u64::from(full_seed)
    }
    
    fn fill_bytes(&mut self, dest: &mut [u8]) {
        rand_core::impls::fill_bytes_via_next(self, dest);
    }
    
    fn try_fill_bytes(&mut self, dest: &mut [u8]) -> Result<(), rand_core::Error> {
        Ok(self.fill_bytes(dest))
    }
}

impl SeedableRng for TrigRng {
    type Seed = u512;

    fn from_seed(seed: Self::Seed) -> Self {
        TrigRng { seed }
    }
}

impl Default for TrigRng {
    fn default() -> Self {
        TrigRng {
            seed: u512::new(u256::new(0, 0), u256::new(0, 0)),
        }
    }
}