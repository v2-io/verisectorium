//! Placeholder crate for the kernel spike (see ../KERNEL-SPEC.md).
//! `saturating_add` exists only to show the build, a unit test and a
//! property test working; replace it freely.

/// `x + y`, or `u32::MAX` when that sum would overflow.
pub fn saturating_add(x: u32, y: u32) -> u32 {
    x.saturating_add(y)
}

#[cfg(test)]
mod tests {
    use super::*;
    use proptest::prelude::*;

    #[test]
    fn adds_and_saturates() {
        assert_eq!(saturating_add(2, 3), 5);
        assert_eq!(saturating_add(u32::MAX, 1), u32::MAX);
    }

    proptest! {
        #[test]
        fn matches_widened_sum(x: u32, y: u32) {
            let wide = u64::from(x) + u64::from(y);
            prop_assert_eq!(u64::from(saturating_add(x, y)), wide.min(u64::from(u32::MAX)));
        }
    }
}
