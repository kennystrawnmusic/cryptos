// SPDX-License-Identifier: GPL-3.0-or-later

/// 256-bit unsigned integer
#[allow(non_camel_case_types)]
pub struct u256([u128; 2]);

impl u256 {
    pub const fn new(a: u128, b: u128) -> Self {
        Self([a, b])
    }

    pub fn to_be_bytes(&self) -> [u8;32] {
        let mut out = [0; 32];
        out[..16].copy_from_slice(&self.0[1].to_be_bytes());
        out[16..].copy_from_slice(&self.0[0].to_be_bytes());
        out
    }

    pub fn to_le_bytes(&self) -> [u8; 32] {
        let mut out = [0; 32];
        out[..16].copy_from_slice(&self.0[0].to_le_bytes());
        out[16..].copy_from_slice(&self.0[1].to_le_bytes());
        out
    }

    pub fn from_be_bytes(bytes: [u8; 32]) -> Self {
        let mut out = [0; 2];
        out[1] = u128::from_be_bytes(bytes[..16].try_into().unwrap());
        out[0] = u128::from_be_bytes(bytes[16..].try_into().unwrap());
        Self(out)
    }

    pub fn from_le_bytes(bytes: [u8; 32]) -> Self {
        let mut out = [0; 2];
        out[0] = u128::from_le_bytes(bytes[..16].try_into().unwrap());
        out[1] = u128::from_le_bytes(bytes[16..].try_into().unwrap());
        Self(out)
    }

    pub fn overflowing_add(&self, rhs: Self) -> (Self, bool) {
        let mut out = [0; 2];
        let mut carry = 0;

        for (i, mut _item) in out.iter_mut().enumerate() {
            let (sum, overflow) = self.0[i].overflowing_add(rhs.0[i]);
            let (mut sum, overflow2) = sum.overflowing_add(carry);
            carry = if overflow || overflow2 { 1 } else { 0 };
            _item = &mut sum;
        }

        (Self(out), carry != 0)
    }

    pub fn overflowing_sub(&self, rhs: Self) -> (Self, bool) {
        let mut out = [0; 2];
        let mut carry = 0;

        for (i, mut _item) in out.iter_mut().enumerate() {
            let (sum, overflow) = self.0[i].overflowing_sub(rhs.0[i]);
            let (mut sum, overflow2) = sum.overflowing_sub(carry);
            carry = if overflow || overflow2 { 1 } else { 0 };
            _item = &mut sum;
        }

        (Self(out), carry != 0)
    }

    pub fn overflowing_mul(&self, rhs: Self) -> (Self, bool) {
        let mut out = [0; 2];

        for i in 0..2 {
            let mut carry = 0;
            for j in 0..2 {
                let (sum, overflow) = self.0[i].overflowing_mul(rhs.0[j]);
                let (sum, overflow2) = sum.overflowing_add(out[i + j]);
                let (sum, overflow3) = sum.overflowing_add(carry);
                carry = if overflow || overflow2 || overflow3 {
                    1
                } else {
                    0
                };
                out[i + j] = sum;
            }
        }

        (Self(out), false)
    }

    pub fn overflowing_div(&self, rhs: Self) -> (Self, bool) {
        let mut out = [0; 2];
        let mut remainder = *self;

        for i in (0..2).rev() {
            let mut carry = 0;
            for j in (0..2).rev() {
                let (sum, overflow) =
                    remainder.0[j].overflowing_add(u128::from(Self::from(carry) << 128));
                let (sum, overflow2) = sum.overflowing_mul(rhs.0[i]);
                let (sum, overflow3) = sum.overflowing_add(out[i + j]);
                carry = if overflow || overflow2 || overflow3 {
                    1
                } else {
                    0
                };
                out[i + j] = sum;
            }
            remainder.0[i] = carry;
        }

        (remainder, false)
    }
}

impl core::ops::Index<u256> for u256 {
    type Output = u128;

    fn index(&self, index: u256) -> &Self::Output {
        &self.0[index.0[0] as usize]
    }
}

impl core::ops::IndexMut<u256> for u256 {
    fn index_mut(&mut self, index: u256) -> &mut Self::Output {
        &mut self.0[index.0[0] as usize]
    }
}

impl core::fmt::Display for u256 {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{}{}", self.0[1], self.0[0])
    }
}

impl core::fmt::LowerHex for u256 {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{:x}{:x}", self.0[1], self.0[0])
    }
}

impl core::fmt::UpperHex for u256 {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{:X}{:X}", self.0[1], self.0[0])
    }
}

impl core::fmt::Binary for u256 {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{:b}{:b}", self.0[1], self.0[0])
    }
}

impl core::fmt::Octal for u256 {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        write!(f, "{:o}{:o}", self.0[1], self.0[0])
    }
}

impl core::fmt::Debug for u256 {
    fn fmt(&self, f: &mut core::fmt::Formatter) -> core::fmt::Result {
        let out = alloc::format!("{:?}{:?}", self.0[1], self.0[0]);
        write!(f, "{:#?}", out)
    }
}

impl core::cmp::PartialEq<u256> for u256 {
    fn eq(&self, other: &u256) -> bool {
        self.0[0] == other.0[0] && self.0[1] == other.0[1]
    }
}

impl core::cmp::PartialEq<u128> for u256 {
    fn eq(&self, other: &u128) -> bool {
        self.0[0] == *other && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<u64> for u256 {
    fn eq(&self, other: &u64) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<u32> for u256 {
    fn eq(&self, other: &u32) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<u16> for u256 {
    fn eq(&self, other: &u16) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<u8> for u256 {
    fn eq(&self, other: &u8) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<usize> for u256 {
    fn eq(&self, other: &usize) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<i128> for u256 {
    fn eq(&self, other: &i128) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<i64> for u256 {
    fn eq(&self, other: &i64) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<i32> for u256 {
    fn eq(&self, other: &i32) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<i16> for u256 {
    fn eq(&self, other: &i16) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<i8> for u256 {
    fn eq(&self, other: &i8) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::PartialEq<isize> for u256 {
    fn eq(&self, other: &isize) -> bool {
        self.0[0] == *other as u128 && self.0[1] == 0
    }
}

impl core::cmp::Eq for u256 {}

impl core::cmp::PartialOrd<u256> for u256 {
    fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering> {
        Some(self.cmp(other))
    }
}

impl core::cmp::PartialOrd<u128> for u256 {
    fn partial_cmp(&self, other: &u128) -> Option<core::cmp::Ordering> {
        if self.0[1] > 0 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] == 0 {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > *other {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < *other {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u64> for u256 {
    fn partial_cmp(&self, other: &u64) -> Option<core::cmp::Ordering> {
        if self.0[1] > 0 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] == 0 {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > *other as u128 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < *other as u128 {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u32> for u256 {
    fn partial_cmp(&self, other: &u32) -> Option<core::cmp::Ordering> {
        if self.0[1] > 0 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] == 0 {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > *other as u128 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < *other as u128 {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u16> for u256 {
    fn partial_cmp(&self, other: &u16) -> Option<core::cmp::Ordering> {
        if self.0[1] > 0 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] == 0 {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > *other as u128 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < *other as u128 {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u8> for u256 {
    fn partial_cmp(&self, other: &u8) -> Option<core::cmp::Ordering> {
        if self.0[1] > 0 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] == 0 {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > *other as u128 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < *other as u128 {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<usize> for u256 {
    fn partial_cmp(&self, other: &usize) -> Option<core::cmp::Ordering> {
        if self.0[1] > 0 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] == 0 {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > *other as u128 {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < *other as u128 {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::Ord for u256 {
    fn cmp(&self, other: &Self) -> core::cmp::Ordering {
        if self.0[1] > other.0[1] {
            core::cmp::Ordering::Greater
        } else if self.0[1] < other.0[1] {
            core::cmp::Ordering::Less
        } else if self.0[0] > other.0[0] {
            core::cmp::Ordering::Greater
        } else if self.0[0] < other.0[0] {
            core::cmp::Ordering::Less
        } else {
            core::cmp::Ordering::Equal
        }
    }
}

impl Clone for u256 {
    fn clone(&self) -> Self {
        *self
    }
}

impl Copy for u256 {}

impl From<u128> for u256 {
    fn from(value: u128) -> Self {
        Self([value, 0])
    }
}

impl From<u256> for u128 {
    fn from(value: u256) -> Self {
        value.0[0]
    }
}

impl From<u256> for u64 {
    fn from(value: u256) -> Self {
        value.0[0] as u64
    }
}

impl From<u256> for u32 {
    fn from(value: u256) -> Self {
        value.0[0] as u32
    }
}

impl From<u256> for u16 {
    fn from(value: u256) -> Self {
        value.0[0] as u16
    }
}

impl From<u256> for u8 {
    fn from(value: u256) -> Self {
        value.0[0] as u8
    }
}

impl From<u256> for usize {
    fn from(value: u256) -> Self {
        value.0[0] as usize
    }
}

impl From<u256> for i128 {
    fn from(value: u256) -> Self {
        value.0[0] as i128
    }
}

impl From<u256> for i64 {
    fn from(value: u256) -> Self {
        value.0[0] as i64
    }
}

impl From<u256> for i32 {
    fn from(value: u256) -> Self {
        value.0[0] as i32
    }
}

impl From<u256> for i16 {
    fn from(value: u256) -> Self {
        value.0[0] as i16
    }
}

impl From<u256> for i8 {
    fn from(value: u256) -> Self {
        value.0[0] as i8
    }
}

impl From<u256> for isize {
    fn from(value: u256) -> Self {
        value.0[0] as isize
    }
}

impl From<u256> for f64 {
    fn from(value: u256) -> Self {
        let mut out = [0; 8];
        out[..4].copy_from_slice(&value.0[0].to_be_bytes());
        out[4..].copy_from_slice(&value.0[1].to_be_bytes());
        f64::from_be_bytes(out)
    }
}

impl From<u256> for f32 {
    fn from(value: u256) -> Self {
        let mut out = [0; 4];
        out.copy_from_slice(&value.0[0].to_be_bytes());
        f32::from_be_bytes(out)
    }
}

impl From<u256> for bool {
    fn from(value: u256) -> Self {
        value.0[0] != 0
    }
}

impl From<u256> for char {
    fn from(value: u256) -> Self {
        value.0[0] as u8 as char
    }
}

impl From<u8> for u256 {
    fn from(value: u8) -> Self {
        Self([value as u128, 0])
    }
}

impl From<u16> for u256 {
    fn from(value: u16) -> Self {
        Self([value as u128, 0])
    }
}

impl From<u32> for u256 {
    fn from(value: u32) -> Self {
        Self([value as u128, 0])
    }
}

impl From<u64> for u256 {
    fn from(value: u64) -> Self {
        Self([value as u128, 0])
    }
}

impl From<usize> for u256 {
    fn from(value: usize) -> Self {
        Self([value as u128, 0])
    }
}

impl From<i8> for u256 {
    fn from(value: i8) -> Self {
        Self([value as u128, 0])
    }
}

impl From<i16> for u256 {
    fn from(value: i16) -> Self {
        Self([value as u128, 0])
    }
}

impl From<i32> for u256 {
    fn from(value: i32) -> Self {
        Self([value as u128, 0])
    }
}

impl From<i64> for u256 {
    fn from(value: i64) -> Self {
        Self([value as u128, 0])
    }
}

impl From<i128> for u256 {
    fn from(value: i128) -> Self {
        Self([value as u128, 0])
    }
}

impl From<isize> for u256 {
    fn from(value: isize) -> Self {
        Self([value as u128, 0])
    }
}

impl From<f32> for u256 {
    fn from(value: f32) -> Self {
        Self([value as u128, 0])
    }
}

impl From<f64> for u256 {
    fn from(value: f64) -> Self {
        Self([value as u128, 0])
    }
}

impl From<bool> for u256 {
    fn from(value: bool) -> Self {
        Self([value as u128, 0])
    }
}

impl From<char> for u256 {
    fn from(value: char) -> Self {
        Self([value as u128, 0])
    }
}

impl From<u256> for [u8; 32] {
    fn from(value: u256) -> Self {
        let mut out = [0; 32];
        out[..16].copy_from_slice(&value.0[0].to_le_bytes());
        out[16..].copy_from_slice(&value.0[1].to_le_bytes());
        out
    }
}

impl core::ops::Add<u256> for u256 {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];
        let mut carry = 0;

        for (i, mut _item) in out.iter_mut().enumerate() {
            let (sum, overflow) = self.0[i].overflowing_add(rhs.0[i]);
            let (mut sum, overflow2) = sum.overflowing_add(carry);
            carry = if overflow || overflow2 { 1 } else { 0 };
            _item = &mut sum;
        }

        Self(out)
    }
}

impl core::ops::AddAssign<u256> for u256 {
    fn add_assign(&mut self, rhs: Self) {
        *self = *self + rhs;
    }
}

impl core::ops::Sub<u256> for u256 {
    type Output = Self;

    fn sub(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];
        let mut carry = 0;

        for (i, mut _item) in out.iter_mut().enumerate() {
            let (sum, overflow) = self.0[i].overflowing_sub(rhs.0[i]);
            let (mut sum, overflow2) = sum.overflowing_sub(carry);
            carry = if overflow || overflow2 { 1 } else { 0 };
            _item = &mut sum;
        }

        Self(out)
    }
}

impl core::ops::SubAssign<u256> for u256 {
    fn sub_assign(&mut self, rhs: Self) {
        *self = *self - rhs;
    }
}

impl core::ops::Mul<u256> for u256 {
    type Output = Self;

    fn mul(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];

        for i in 0..2 {
            let mut carry = 0;
            for j in 0..2 {
                let (sum, overflow) = self.0[i].overflowing_mul(rhs.0[j]);
                let (sum, overflow2) = sum.overflowing_add(out[i + j]);
                let (sum, overflow3) = sum.overflowing_add(carry);
                carry = if overflow || overflow2 || overflow3 {
                    1
                } else {
                    0
                };
                out[i + j] = sum;
            }
        }

        Self(out)
    }
}

impl core::ops::MulAssign<u256> for u256 {
    fn mul_assign(&mut self, rhs: Self) {
        *self = *self * rhs;
    }
}

impl core::ops::Div<u256> for u256 {
    type Output = Self;

    fn div(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];
        let mut remainder = self;

        for i in (0..2).rev() {
            let mut carry = 0;
            for j in (0..2).rev() {
                let (sum, overflow) =
                    remainder.0[j].overflowing_add(u128::from(Self::from(carry) << 128));
                let (sum, overflow2) = sum.overflowing_mul(rhs.0[i]);
                let (sum, overflow3) = sum.overflowing_add(out[i + j]);
                carry = if overflow || overflow2 || overflow3 {
                    1
                } else {
                    0
                };
                out[i + j] = sum;
            }
            remainder.0[i] = carry;
        }

        Self(out)
    }
}

impl core::ops::DivAssign<u256> for u256 {
    fn div_assign(&mut self, rhs: Self) {
        *self = *self / rhs;
    }
}

impl core::ops::Rem<u256> for u256 {
    type Output = Self;

    fn rem(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];
        let mut remainder = self;

        for i in (0..2).rev() {
            let mut carry = 0;
            for j in (0..2).rev() {
                let (sum, overflow) =
                    remainder.0[j].overflowing_add(u128::from(Self::from(carry) << 128));
                let (sum, overflow2) = sum.overflowing_mul(rhs.0[i]);
                let (sum, overflow3) = sum.overflowing_add(out[i + j]);
                carry = if overflow || overflow2 || overflow3 {
                    1
                } else {
                    0
                };
                out[i + j] = sum;
            }
            remainder.0[i] = carry;
        }

        remainder
    }
}

impl core::ops::RemAssign<u256> for u256 {
    fn rem_assign(&mut self, rhs: Self) {
        *self = *self % rhs;
    }
}

impl core::ops::BitAnd<u256> for u256 {
    type Output = Self;

    fn bitand(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] & rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::BitAndAssign<u256> for u256 {
    fn bitand_assign(&mut self, rhs: Self) {
        *self = *self & rhs;
    }
}

impl core::ops::BitOr<u256> for u256 {
    type Output = Self;

    fn bitor(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] | rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::BitOrAssign<u256> for u256 {
    fn bitor_assign(&mut self, rhs: Self) {
        *self = *self | rhs;
    }
}

impl core::ops::BitXor<u256> for u256 {
    type Output = Self;

    fn bitxor(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] ^ rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::BitXorAssign<u256> for u256 {
    fn bitxor_assign(&mut self, rhs: Self) {
        *self = *self ^ rhs;
    }
}

impl core::ops::Shl<u256> for u256 {
    type Output = Self;

    fn shl(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] << rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::ShlAssign<u256> for u256 {
    fn shl_assign(&mut self, rhs: Self) {
        *self = *self << rhs;
    }
}

impl core::ops::Shr<u256> for u256 {
    type Output = Self;

    fn shr(self, rhs: Self) -> Self::Output {
        let mut out = [0; 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] >> rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::ShrAssign<u256> for u256 {
    fn shr_assign(&mut self, rhs: Self) {
        *self = *self >> rhs;
    }
}

impl core::ops::Not for u256 {
    type Output = Self;

    fn not(self) -> Self::Output {
        let mut out = [0; 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (!self.0[i]);
        }

        Self(out)
    }
}

impl core::ops::Add<u128> for u256 {
    type Output = Self;

    fn add(self, rhs: u128) -> Self::Output {
        self + Self::from(rhs)
    }
}

impl core::ops::AddAssign<u128> for u256 {
    fn add_assign(&mut self, rhs: u128) {
        *self = *self + rhs;
    }
}

impl core::ops::Sub<u128> for u256 {
    type Output = Self;

    fn sub(self, rhs: u128) -> Self::Output {
        self - Self::from(rhs)
    }
}

impl core::ops::SubAssign<u128> for u256 {
    fn sub_assign(&mut self, rhs: u128) {
        *self = *self - rhs;
    }
}

impl core::ops::Mul<u128> for u256 {
    type Output = Self;

    fn mul(self, rhs: u128) -> Self::Output {
        self * Self::from(rhs)
    }
}

impl core::ops::MulAssign<u128> for u256 {
    fn mul_assign(&mut self, rhs: u128) {
        *self = *self * rhs;
    }
}

impl core::ops::Div<u128> for u256 {
    type Output = Self;

    fn div(self, rhs: u128) -> Self::Output {
        self / Self::from(rhs)
    }
}

impl core::ops::DivAssign<u128> for u256 {
    fn div_assign(&mut self, rhs: u128) {
        *self = *self / rhs;
    }
}

impl core::ops::Rem<u128> for u256 {
    type Output = Self;

    fn rem(self, rhs: u128) -> Self::Output {
        self % Self::from(rhs)
    }
}

impl core::ops::RemAssign<u128> for u256 {
    fn rem_assign(&mut self, rhs: u128) {
        *self = *self % rhs;
    }
}

impl core::ops::BitAnd<u128> for u256 {
    type Output = Self;

    fn bitand(self, rhs: u128) -> Self::Output {
        self & Self::from(rhs)
    }
}

impl core::ops::BitAndAssign<u128> for u256 {
    fn bitand_assign(&mut self, rhs: u128) {
        *self = *self & rhs;
    }
}

impl core::ops::BitOr<u128> for u256 {
    type Output = Self;

    fn bitor(self, rhs: u128) -> Self::Output {
        self | Self::from(rhs)
    }
}

impl core::ops::BitOrAssign<u128> for u256 {
    fn bitor_assign(&mut self, rhs: u128) {
        *self = *self | rhs;
    }
}

impl core::ops::BitXor<u128> for u256 {
    type Output = Self;

    fn bitxor(self, rhs: u128) -> Self::Output {
        self ^ Self::from(rhs)
    }
}

impl core::ops::BitXorAssign<u128> for u256 {
    fn bitxor_assign(&mut self, rhs: u128) {
        *self = *self ^ rhs;
    }
}

impl core::ops::Shl<u128> for u256 {
    type Output = Self;

    fn shl(self, rhs: u128) -> Self::Output {
        self << Self::from(rhs)
    }
}

impl core::ops::ShlAssign<u128> for u256 {
    fn shl_assign(&mut self, rhs: u128) {
        *self = *self << rhs;
    }
}

impl core::ops::Shr<u128> for u256 {
    type Output = Self;

    fn shr(self, rhs: u128) -> Self::Output {
        self >> Self::from(rhs)
    }
}

impl core::ops::ShrAssign<u128> for u256 {
    fn shr_assign(&mut self, rhs: u128) {
        *self = *self >> rhs;
    }
}

/// 512-bit unsigned integer
#[allow(non_camel_case_types)]
pub struct u512([u256; 2]);

impl u512 {
    pub const fn new(a: u256, b: u256) -> Self {
        Self([a, b])
    }

    pub fn to_be_bytes(&self) -> [u8; 64] {
        let mut out = [0; 64];
        out[..32].copy_from_slice(&self.0[0].to_be_bytes());
        out[32..].copy_from_slice(&self.0[1].to_be_bytes());
        out
    }

    pub fn to_le_bytes(&self) -> [u8; 64] {
        let mut out = [0; 64];
        out[..32].copy_from_slice(&self.0[0].to_le_bytes());
        out[32..].copy_from_slice(&self.0[1].to_le_bytes());
        out
    }

    pub fn from_be_bytes(bytes: [u8; 64]) -> Self {
        let mut a = [0; 32];
        let mut b = [0; 32];
        a.copy_from_slice(&bytes[..32]);
        b.copy_from_slice(&bytes[32..]);
        Self([u256::from_be_bytes(a), u256::from_be_bytes(b)])
    }

    pub fn from_le_bytes(bytes: [u8; 64]) -> Self {
        let mut a = [0; 32];
        let mut b = [0; 32];
        a.copy_from_slice(&bytes[..32]);
        b.copy_from_slice(&bytes[32..]);
        Self([u256::from_le_bytes(a), u256::from_le_bytes(b)])
    }

    pub fn overflowing_add(&self, rhs: Self) -> (Self, bool) {
        let mut out = [u256::from(0); 2];
        let mut carry = u256::from(0);

        for (i, mut _item) in out.iter_mut().enumerate() {
            let (sum, overflow) = self.0[i].overflowing_add(rhs.0[i]);
            let (mut sum, overflow2) = sum.overflowing_add(carry);
            carry = if overflow || overflow2 { u256::from(1) } else { u256::from(0) };
            _item = &mut sum;
        }

        (Self(out), carry != 0)
    }

    pub fn overflowing_sub(&self, rhs: Self) -> (Self, bool) {
        let mut out = [u256::from(0); 2];
        let mut carry = u256::from(0);

        for (i, mut _item) in out.iter_mut().enumerate() {
            let (sum, overflow) = self.0[i].overflowing_sub(rhs.0[i]);
            let (mut sum, overflow2) = sum.overflowing_sub(carry);
            carry = if overflow || overflow2 { u256::from(1) } else { u256::from(0) };
            _item = &mut sum;
        }

        (Self(out), carry != 0)
    }

    pub fn overflowing_mul(&self, rhs: Self) -> (Self, bool) {
        let mut out = [u256::from(0); 2];

        for i in 0..2 {
            let mut carry = u256::from(0);
            for j in 0..2 {
                let (sum, overflow) = self.0[i].overflowing_mul(rhs.0[j]);
                let (sum, overflow2) = sum.overflowing_add(out[i + j]);
                let (sum, overflow3) = sum.overflowing_add(carry);
                carry = if overflow || overflow2 || overflow3 {
                    u256::from(1)
                } else {
                    u256::from(0)
                };
                out[i + j] = sum;
            }
        }

        (Self(out), false)
    }

    pub fn overflowing_div(&self, rhs: Self) -> (Self, bool) {
        let mut out = [u256::from(0); 2];
        let mut remainder = *self;

        for i in (0..2).rev() {
            let mut carry = u256::from(0);
            for j in (0..2).rev() {
                let (sum, overflow) =
                    remainder.0[j].overflowing_add(u256::from(Self::from(carry) << 128));
                let (sum, overflow2) = sum.overflowing_mul(rhs.0[i]);
                let (sum, overflow3) = sum.overflowing_add(out[i + j]);
                carry = if overflow || overflow2 || overflow3 {
                    u256::from(1)
                } else {
                    u256::from(0)
                };
                out[i + j] = sum;
            }
            remainder.0[i] = carry;
        }

        (remainder, false)
    }
}

impl Clone for u512 {
    fn clone(&self) -> Self {
        *self
    }
}

impl Copy for u512 {}

impl From<u256> for u512 {
    fn from(value: u256) -> Self {
        Self([value, u256::from(0)])
    }
}

impl From<u512> for u256 {
    fn from(value: u512) -> Self {
        value.0[0]
    }
}

impl From<u512> for u128 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for u64 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for u32 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for u16 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for u8 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for usize {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for i128 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for i64 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for i32 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for i16 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for i8 {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for isize {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for f64 {
    fn from(value: u512) -> Self {
        f64::from(value.0[0])
    }
}

impl From<u512> for f32 {
    fn from(value: u512) -> Self {
        f32::from(value.0[0])
    }
}

impl From<u512> for bool {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u512> for char {
    fn from(value: u512) -> Self {
        value.0[0].into()
    }
}

impl From<u8> for u512 {
    fn from(value: u8) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<u16> for u512 {
    fn from(value: u16) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<u32> for u512 {
    fn from(value: u32) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<u64> for u512 {
    fn from(value: u64) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<u128> for u512 {
    fn from(value: u128) -> Self {
        Self([u256::from(value), u256::from(0)])
    }
}

impl From<usize> for u512 {
    fn from(value: usize) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<i8> for u512 {
    fn from(value: i8) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<i16> for u512 {
    fn from(value: i16) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<i32> for u512 {
    fn from(value: i32) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<i64> for u512 {
    fn from(value: i64) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<isize> for u512 {
    fn from(value: isize) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<f32> for u512 {
    fn from(value: f32) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<f64> for u512 {
    fn from(value: f64) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<bool> for u512 {
    fn from(value: bool) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<char> for u512 {
    fn from(value: char) -> Self {
        Self([value.into(), u256::from(0)])
    }
}

impl From<u512> for [u8; 64] {
    fn from(value: u512) -> Self {
        let mut out = [0; 64];
        out[..32].copy_from_slice(&value.0[0].to_le_bytes());
        out[32..].copy_from_slice(&value.0[1].to_le_bytes());
        out
    }
}

impl core::ops::Add<u512> for u512 {
    type Output = Self;

    fn add(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];
        let mut carry = 0;

        for (i, mut _item) in out.iter_mut().enumerate() {
            let (sum, overflow) = self.0[i].overflowing_add(rhs.0[i]);
            let (mut sum, overflow2) = sum.overflowing_add(u256::from(carry));
            carry = if overflow || overflow2 { 1 } else { 0 };
            _item = &mut sum;
        }

        Self(out)
    }
}

impl core::ops::AddAssign<u512> for u512 {
    fn add_assign(&mut self, rhs: Self) {
        *self = *self + rhs;
    }
}

impl core::ops::Sub<u512> for u512 {
    type Output = Self;

    fn sub(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];
        let mut carry = 0;

        for (i, mut _item) in out.iter_mut().enumerate() {
            let (sum, overflow) = self.0[i].overflowing_sub(rhs.0[i]);
            let (mut sum, overflow2) = sum.overflowing_sub(u256::from(carry));
            carry = if overflow || overflow2 { 1 } else { 0 };
            _item = &mut sum;
        }

        Self(out)
    }
}

impl core::ops::SubAssign<u512> for u512 {
    fn sub_assign(&mut self, rhs: Self) {
        *self = *self - rhs;
    }
}

impl core::ops::Mul<u512> for u512 {
    type Output = Self;

    fn mul(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];

        for i in 0..2 {
            let mut carry = u256::from(0);
            for j in 0..2 {
                let (sum, overflow) = self.0[i].overflowing_mul(rhs.0[j]);
                let (sum, overflow2) = sum.overflowing_add(out[i + j]);
                let (sum, overflow3) = sum.overflowing_add(carry);
                carry = if overflow || overflow2 || overflow3 {
                    u256::from(1)
                } else {
                    u256::from(0)
                };
                out[i + j] = sum;
            }
        }

        Self(out)
    }
}

impl core::ops::MulAssign<u512> for u512 {
    fn mul_assign(&mut self, rhs: Self) {
        *self = *self * rhs;
    }
}

impl core::ops::Div<u512> for u512 {
    type Output = Self;

    fn div(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];
        let mut remainder = self;

        for i in (0..2).rev() {
            let mut carry = u256::from(0);
            for j in (0..2).rev() {
                let (sum, overflow) =
                    remainder.0[j].overflowing_add(u256::from(Self::from(carry) << 256));
                let (sum, overflow2) = sum.overflowing_mul(rhs.0[i]);
                let (sum, overflow3) = sum.overflowing_add(out[i + j]);
                carry = if overflow || overflow2 || overflow3 {
                    u256::from(1)
                } else {
                    u256::from(0)
                };
                out[i + j] = sum;
            }
            remainder.0[i] = carry;
        }

        Self(out)
    }
}

impl core::ops::DivAssign<u512> for u512 {
    fn div_assign(&mut self, rhs: Self) {
        *self = *self / rhs;
    }
}

impl core::ops::Rem<u512> for u512 {
    type Output = Self;

    fn rem(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];
        let mut remainder = self;

        for i in (0..2).rev() {
            let mut carry = u256::from(0);
            for j in (0..2).rev() {
                let (sum, overflow) =
                    remainder.0[j].overflowing_add(u256::from(Self::from(carry) << 256));
                let (sum, overflow2) = sum.overflowing_mul(rhs.0[i]);
                let (sum, overflow3) = sum.overflowing_add(out[i + j]);
                carry = if overflow || overflow2 || overflow3 {
                    u256::from(1)
                } else {
                    u256::from(0)
                };
                out[i + j] = sum;
            }
            remainder.0[i] = carry;
        }

        remainder
    }
}

impl core::ops::RemAssign<u512> for u512 {
    fn rem_assign(&mut self, rhs: Self) {
        *self = *self % rhs;
    }
}

impl core::ops::BitAnd<u512> for u512 {
    type Output = Self;

    fn bitand(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] & rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::BitAndAssign<u512> for u512 {
    fn bitand_assign(&mut self, rhs: Self) {
        *self = *self & rhs;
    }
}

impl core::ops::BitOr<u512> for u512 {
    type Output = Self;

    fn bitor(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] | rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::BitOrAssign<u512> for u512 {
    fn bitor_assign(&mut self, rhs: Self) {
        *self = *self | rhs;
    }
}

impl core::ops::BitXor<u512> for u512 {
    type Output = Self;

    fn bitxor(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] ^ rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::BitXorAssign<u512> for u512 {
    fn bitxor_assign(&mut self, rhs: Self) {
        *self = *self ^ rhs;
    }
}

impl core::ops::Shl<u512> for u512 {
    type Output = Self;

    fn shl(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] << rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::ShlAssign<u512> for u512 {
    fn shl_assign(&mut self, rhs: Self) {
        *self = *self << rhs;
    }
}

impl core::ops::Shr<u512> for u512 {
    type Output = Self;

    fn shr(self, rhs: Self) -> Self::Output {
        let mut out = [u256::from(0); 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (self.0[i] >> rhs.0[i]);
        }

        Self(out)
    }
}

impl core::ops::ShrAssign<u512> for u512 {
    fn shr_assign(&mut self, rhs: Self) {
        *self = *self >> rhs;
    }
}

impl core::ops::Not for u512 {
    type Output = Self;

    fn not(self) -> Self::Output {
        let mut out = [u256::from(0); 2];

        for (i, mut _item) in out.iter_mut().enumerate() {
            _item = &mut (!self.0[i]);
        }

        Self(out)
    }
}

impl core::ops::Add<u256> for u512 {
    type Output = Self;

    fn add(self, rhs: u256) -> Self::Output {
        self + Self::from(rhs)
    }
}

impl core::ops::AddAssign<u256> for u512 {
    fn add_assign(&mut self, rhs: u256) {
        *self = *self + rhs;
    }
}

impl core::ops::Sub<u256> for u512 {
    type Output = Self;

    fn sub(self, rhs: u256) -> Self::Output {
        self - Self::from(rhs)
    }
}

impl core::ops::SubAssign<u256> for u512 {
    fn sub_assign(&mut self, rhs: u256) {
        *self = *self - rhs;
    }
}

impl core::ops::Mul<u256> for u512 {
    type Output = Self;

    fn mul(self, rhs: u256) -> Self::Output {
        self * Self::from(rhs)
    }
}

impl core::ops::MulAssign<u256> for u512 {
    fn mul_assign(&mut self, rhs: u256) {
        *self = *self * rhs;
    }
}

impl core::ops::Div<u256> for u512 {
    type Output = Self;

    fn div(self, rhs: u256) -> Self::Output {
        self / Self::from(rhs)
    }
}

impl core::ops::DivAssign<u256> for u512 {
    fn div_assign(&mut self, rhs: u256) {
        *self = *self / rhs;
    }
}

impl core::ops::Rem<u256> for u512 {
    type Output = Self;

    fn rem(self, rhs: u256) -> Self::Output {
        self % Self::from(rhs)
    }
}

impl core::ops::RemAssign<u256> for u512 {
    fn rem_assign(&mut self, rhs: u256) {
        *self = *self % rhs;
    }
}

impl core::ops::BitAnd<u256> for u512 {
    type Output = Self;

    fn bitand(self, rhs: u256) -> Self::Output {
        self & Self::from(rhs)
    }
}

impl core::ops::BitAndAssign<u256> for u512 {
    fn bitand_assign(&mut self, rhs: u256) {
        *self = *self & rhs;
    }
}

impl core::ops::BitOr<u256> for u512 {
    type Output = Self;

    fn bitor(self, rhs: u256) -> Self::Output {
        self | Self::from(rhs)
    }
}

impl core::ops::BitOrAssign<u256> for u512 {
    fn bitor_assign(&mut self, rhs: u256) {
        *self = *self | rhs;
    }
}

impl core::ops::BitXor<u256> for u512 {
    type Output = Self;

    fn bitxor(self, rhs: u256) -> Self::Output {
        self ^ Self::from(rhs)
    }
}

impl core::ops::BitXorAssign<u256> for u512 {
    fn bitxor_assign(&mut self, rhs: u256) {
        *self = *self ^ rhs;
    }
}

impl core::ops::Shl<u256> for u512 {
    type Output = Self;

    fn shl(self, rhs: u256) -> Self::Output {
        self << Self::from(rhs)
    }
}

impl core::ops::ShlAssign<u256> for u512 {
    fn shl_assign(&mut self, rhs: u256) {
        *self = *self << rhs;
    }
}

impl core::ops::Shr<u256> for u512 {
    type Output = Self;

    fn shr(self, rhs: u256) -> Self::Output {
        self >> Self::from(rhs)
    }
}

impl core::ops::ShrAssign<u256> for u512 {
    fn shr_assign(&mut self, rhs: u256) {
        *self = *self >> rhs;
    }
}

impl core::ops::Add<u128> for u512 {
    type Output = Self;

    fn add(self, rhs: u128) -> Self::Output {
        self + Self::from(rhs)
    }
}

impl core::ops::AddAssign<u128> for u512 {
    fn add_assign(&mut self, rhs: u128) {
        *self = *self + rhs;
    }
}

impl core::ops::Sub<u128> for u512 {
    type Output = Self;

    fn sub(self, rhs: u128) -> Self::Output {
        self - Self::from(rhs)
    }
}

impl core::ops::SubAssign<u128> for u512 {
    fn sub_assign(&mut self, rhs: u128) {
        *self = *self - rhs;
    }
}

impl core::ops::Mul<u128> for u512 {
    type Output = Self;

    fn mul(self, rhs: u128) -> Self::Output {
        self * Self::from(rhs)
    }
}

impl core::ops::MulAssign<u128> for u512 {
    fn mul_assign(&mut self, rhs: u128) {
        *self = *self * rhs;
    }
}

impl core::ops::Div<u128> for u512 {
    type Output = Self;

    fn div(self, rhs: u128) -> Self::Output {
        self / Self::from(rhs)
    }
}

impl core::ops::DivAssign<u128> for u512 {
    fn div_assign(&mut self, rhs: u128) {
        *self = *self / rhs;
    }
}

impl core::ops::Rem<u128> for u512 {
    type Output = Self;

    fn rem(self, rhs: u128) -> Self::Output {
        self % Self::from(rhs)
    }
}

impl core::ops::RemAssign<u128> for u512 {
    fn rem_assign(&mut self, rhs: u128) {
        *self = *self % rhs;
    }
}

impl core::ops::BitAnd<u128> for u512 {
    type Output = Self;

    fn bitand(self, rhs: u128) -> Self::Output {
        self & Self::from(rhs)
    }
}

impl core::ops::BitAndAssign<u128> for u512 {
    fn bitand_assign(&mut self, rhs: u128) {
        *self = *self & rhs;
    }
}

impl core::ops::BitOr<u128> for u512 {
    type Output = Self;

    fn bitor(self, rhs: u128) -> Self::Output {
        self | Self::from(rhs)
    }
}

impl core::ops::BitOrAssign<u128> for u512 {
    fn bitor_assign(&mut self, rhs: u128) {
        *self = *self | rhs;
    }
}

impl core::ops::BitXor<u128> for u512 {
    type Output = Self;

    fn bitxor(self, rhs: u128) -> Self::Output {
        self ^ Self::from(rhs)
    }
}

impl core::ops::BitXorAssign<u128> for u512 {
    fn bitxor_assign(&mut self, rhs: u128) {
        *self = *self ^ rhs;
    }
}

impl core::ops::Shl<u128> for u512 {
    type Output = Self;

    fn shl(self, rhs: u128) -> Self::Output {
        self << Self::from(rhs)
    }
}

impl core::ops::ShlAssign<u128> for u512 {
    fn shl_assign(&mut self, rhs: u128) {
        *self = *self << rhs;
    }
}

impl core::ops::Shr<u128> for u512 {
    type Output = Self;

    fn shr(self, rhs: u128) -> Self::Output {
        self >> Self::from(rhs)
    }
}

impl core::ops::ShrAssign<u128> for u512 {
    fn shr_assign(&mut self, rhs: u128) {
        *self = *self >> rhs;
    }
}

impl core::ops::Mul<f64> for u512 {
    type Output = Self;

    fn mul(self, rhs: f64) -> Self::Output {
        self * Self::from(rhs)
    }
}

impl core::ops::MulAssign<f64> for u512 {
    fn mul_assign(&mut self, rhs: f64) {
        *self = *self * rhs;
    }
}

impl core::cmp::PartialEq<u512> for u512 {
    fn eq(&self, other: &Self) -> bool {
        self.0[0] == other.0[0] && self.0[1] == other.0[1]
    }
}

impl core::cmp::PartialEq<u256> for u512 {
    fn eq(&self, other: &u256) -> bool {
        self.0[0] == *other && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<u128> for u512 {
    fn eq(&self, other: &u128) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<u64> for u512 {
    fn eq(&self, other: &u64) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<u32> for u512 {
    fn eq(&self, other: &u32) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<u16> for u512 {
    fn eq(&self, other: &u16) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<u8> for u512 {
    fn eq(&self, other: &u8) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<usize> for u512 {
    fn eq(&self, other: &usize) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<i128> for u512 {
    fn eq(&self, other: &i128) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<i64> for u512 {
    fn eq(&self, other: &i64) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<i32> for u512 {
    fn eq(&self, other: &i32) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<i16> for u512 {
    fn eq(&self, other: &i16) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<i8> for u512 {
    fn eq(&self, other: &i8) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::PartialEq<isize> for u512 {
    fn eq(&self, other: &isize) -> bool {
        self.0[0] == u256::from(*other) && self.0[1] == u256::from(0)
    }
}

impl core::cmp::Eq for u512 {}

#[allow(clippy::non_canonical_partial_ord_impl)]
impl core::cmp::PartialOrd<u512> for u512 {
    fn partial_cmp(&self, other: &Self) -> Option<core::cmp::Ordering> {
        if self.0[1] > other.0[1] {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] < other.0[1] {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > other.0[0] {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < other.0[0] {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u256> for u512 {
    fn partial_cmp(&self, other: &u256) -> Option<core::cmp::Ordering> {
        if self.0[1] > u256::from(0) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] < u256::from(0) {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > *other {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < *other {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u128> for u512 {
    fn partial_cmp(&self, other: &u128) -> Option<core::cmp::Ordering> {
        if self.0[1] > u256::from(0) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] < u256::from(0) {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > u256::from(*other) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < u256::from(*other) {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u64> for u512 {
    fn partial_cmp(&self, other: &u64) -> Option<core::cmp::Ordering> {
        if self.0[1] > u256::from(0) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] < u256::from(0) {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > u256::from(*other) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < u256::from(*other) {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u32> for u512 {
    fn partial_cmp(&self, other: &u32) -> Option<core::cmp::Ordering> {
        if self.0[1] > u256::from(0) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] < u256::from(0) {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > u256::from(*other) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < u256::from(*other) {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u16> for u512 {
    fn partial_cmp(&self, other: &u16) -> Option<core::cmp::Ordering> {
        if self.0[1] > u256::from(0) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] < u256::from(0) {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > u256::from(*other) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < u256::from(*other) {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<u8> for u512 {
    fn partial_cmp(&self, other: &u8) -> Option<core::cmp::Ordering> {
        if self.0[1] > u256::from(0) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] < u256::from(0) {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > u256::from(*other) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < u256::from(*other) {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::PartialOrd<usize> for u512 {
    fn partial_cmp(&self, other: &usize) -> Option<core::cmp::Ordering> {
        if self.0[1] > u256::from(0) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[1] < u256::from(0) {
            Some(core::cmp::Ordering::Less)
        } else if self.0[0] > u256::from(*other) {
            Some(core::cmp::Ordering::Greater)
        } else if self.0[0] < u256::from(*other) {
            Some(core::cmp::Ordering::Less)
        } else {
            Some(core::cmp::Ordering::Equal)
        }
    }
}

impl core::cmp::Ord for u512 {
    fn cmp(&self, other: &Self) -> core::cmp::Ordering {
        if self.0[1] > other.0[1] {
            core::cmp::Ordering::Greater
        } else if self.0[1] < other.0[1] {
            core::cmp::Ordering::Less
        } else if self.0[0] > other.0[0] {
            core::cmp::Ordering::Greater
        } else if self.0[0] < other.0[0] {
            core::cmp::Ordering::Less
        } else {
            core::cmp::Ordering::Equal
        }
    }
}

impl AsMut<[u8]> for u512 {
    fn as_mut(&mut self) -> &mut [u8] {
        let ptr = self as *const u512 as *mut u8;
        unsafe { core::slice::from_raw_parts_mut(ptr, 64) }
    }
}

impl Default for u512 {
    fn default() -> Self {
        Self([u256::from(0); 2])
    }
}