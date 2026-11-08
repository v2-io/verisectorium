//! A sorted-`Vec` map and set with the slice of `BTreeMap`/`BTreeSet`'s API
//! the kernel uses. They exist for one reason: under `cargo kani`, `model::Map`
//! and `model::Set` are these instead of std's B-trees, whose node-splitting
//! internals the bounded model checker spends its whole budget symbolically
//! executing (see account.md). Normal builds use std's `BTreeMap`/`BTreeSet`.
//!
//! These are a *trusted component* of the Kani proofs, as std's B-trees are of
//! every other run. Their agreement with std, operation by operation, is
//! property-tested in this file's tests (normal build). Iteration is in
//! ascending key order, as with std, so the kernel behaves identically.
//! Lookups are linear on purpose: simplest for symbolic execution.

use std::borrow::Borrow;
use std::fmt;
use std::ops::Index;

#[derive(Clone, PartialEq, Eq)]
pub struct VecMap<K, V> {
    // invariant: strictly ascending by key
    entries: Vec<(K, V)>,
}

impl<K, V> Default for VecMap<K, V> {
    fn default() -> Self {
        VecMap { entries: Vec::new() }
    }
}

impl<K: fmt::Debug, V: fmt::Debug> fmt::Debug for VecMap<K, V> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_map().entries(self.entries.iter().map(|(k, v)| (k, v))).finish()
    }
}

impl<K: Ord, V> VecMap<K, V> {
    pub fn new() -> Self {
        VecMap { entries: Vec::new() }
    }
    /// Ok(i): key at i. Err(i): absent, would be inserted at i.
    fn find<Q: Ord + ?Sized>(&self, k: &Q) -> Result<usize, usize>
    where
        K: Borrow<Q>,
    {
        for (i, (key, _)) in self.entries.iter().enumerate() {
            match key.borrow().cmp(k) {
                std::cmp::Ordering::Less => {}
                std::cmp::Ordering::Equal => return Ok(i),
                std::cmp::Ordering::Greater => return Err(i),
            }
        }
        Err(self.entries.len())
    }
    pub fn get<Q: Ord + ?Sized>(&self, k: &Q) -> Option<&V>
    where
        K: Borrow<Q>,
    {
        self.find(k).ok().map(|i| &self.entries[i].1)
    }
    pub fn get_mut<Q: Ord + ?Sized>(&mut self, k: &Q) -> Option<&mut V>
    where
        K: Borrow<Q>,
    {
        match self.find(k) {
            Ok(i) => Some(&mut self.entries[i].1),
            Err(_) => None,
        }
    }
    pub fn contains_key<Q: Ord + ?Sized>(&self, k: &Q) -> bool
    where
        K: Borrow<Q>,
    {
        self.find(k).is_ok()
    }
    pub fn insert(&mut self, k: K, v: V) -> Option<V> {
        match self.find(&k) {
            Ok(i) => Some(std::mem::replace(&mut self.entries[i].1, v)),
            Err(i) => {
                self.entries.insert(i, (k, v));
                None
            }
        }
    }
    pub fn remove<Q: Ord + ?Sized>(&mut self, k: &Q) -> Option<V>
    where
        K: Borrow<Q>,
    {
        self.find(k).ok().map(|i| self.entries.remove(i).1)
    }
    pub fn retain(&mut self, mut f: impl FnMut(&K, &mut V) -> bool) {
        self.entries.retain_mut(|(k, v)| f(k, v));
    }
    pub fn entry(&mut self, k: K) -> Entry<'_, K, V> {
        Entry { map: self, key: k }
    }
    pub fn iter(&self) -> impl Iterator<Item = (&K, &V)> {
        self.entries.iter().map(|(k, v)| (k, v))
    }
    pub fn keys(&self) -> impl Iterator<Item = &K> {
        self.entries.iter().map(|(k, _)| k)
    }
    pub fn values(&self) -> impl Iterator<Item = &V> {
        self.entries.iter().map(|(_, v)| v)
    }
    pub fn len(&self) -> usize {
        self.entries.len()
    }
    pub fn is_empty(&self) -> bool {
        self.entries.is_empty()
    }
}

pub struct Entry<'a, K, V> {
    map: &'a mut VecMap<K, V>,
    key: K,
}

impl<'a, K: Ord, V> Entry<'a, K, V> {
    pub fn or_insert_with(self, f: impl FnOnce() -> V) -> &'a mut V {
        let i = match self.map.find(&self.key) {
            Ok(i) => i,
            Err(i) => {
                self.map.entries.insert(i, (self.key, f()));
                i
            }
        };
        &mut self.map.entries[i].1
    }
    pub fn or_insert(self, v: V) -> &'a mut V {
        self.or_insert_with(|| v)
    }
}

impl<K: Ord + Borrow<Q>, Q: Ord + ?Sized, V> Index<&Q> for VecMap<K, V> {
    type Output = V;
    fn index(&self, k: &Q) -> &V {
        self.get(k).expect("key not in VecMap")
    }
}

impl<K: Ord, V> FromIterator<(K, V)> for VecMap<K, V> {
    fn from_iter<I: IntoIterator<Item = (K, V)>>(it: I) -> Self {
        let mut m = VecMap::new();
        for (k, v) in it {
            m.insert(k, v);
        }
        m
    }
}

impl<'a, K, V> IntoIterator for &'a VecMap<K, V> {
    type Item = (&'a K, &'a V);
    type IntoIter = std::iter::Map<std::slice::Iter<'a, (K, V)>, fn(&'a (K, V)) -> (&'a K, &'a V)>;
    fn into_iter(self) -> Self::IntoIter {
        self.entries.iter().map(|(k, v)| (k, v))
    }
}

/// A set as a `VecMap<K, ()>`.
#[derive(Clone, PartialEq, Eq, Default)]
pub struct VecSet<K> {
    map: VecMap<K, ()>,
}

impl<K: fmt::Debug> fmt::Debug for VecSet<K> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_set().entries(self.map.entries.iter().map(|(k, _)| k)).finish()
    }
}

impl<K: Ord> VecSet<K> {
    pub fn new() -> Self {
        VecSet { map: VecMap::new() }
    }
    pub fn insert(&mut self, k: K) -> bool {
        self.map.insert(k, ()).is_none()
    }
    pub fn contains<Q: Ord + ?Sized>(&self, k: &Q) -> bool
    where
        K: Borrow<Q>,
    {
        self.map.contains_key(k)
    }
    pub fn iter(&self) -> impl Iterator<Item = &K> {
        self.map.keys()
    }
    pub fn len(&self) -> usize {
        self.map.len()
    }
    pub fn is_empty(&self) -> bool {
        self.map.is_empty()
    }
    pub fn is_subset(&self, other: &VecSet<K>) -> bool {
        self.iter().all(|k| other.contains(k))
    }
}

impl<K: Ord> FromIterator<K> for VecSet<K> {
    fn from_iter<I: IntoIterator<Item = K>>(it: I) -> Self {
        let mut s = VecSet::new();
        for k in it {
            s.insert(k);
        }
        s
    }
}

impl<'a, K> IntoIterator for &'a VecSet<K> {
    type Item = &'a K;
    type IntoIter = std::iter::Map<std::slice::Iter<'a, (K, ())>, fn(&'a (K, ())) -> &'a K>;
    fn into_iter(self) -> Self::IntoIter {
        self.map.entries.iter().map(|(k, _)| k)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use proptest::prelude::*;
    use std::collections::{BTreeMap, BTreeSet};

    #[derive(Debug, Clone)]
    enum Op {
        Insert(u8, u8),
        Remove(u8),
        Retain(u8),
        Entry(u8, u8),
        GetMut(u8, u8),
    }

    fn op() -> impl Strategy<Value = Op> {
        prop_oneof![
            (0u8..8, any::<u8>()).prop_map(|(k, v)| Op::Insert(k, v)),
            (0u8..8).prop_map(Op::Remove),
            any::<u8>().prop_map(Op::Retain),
            (0u8..8, any::<u8>()).prop_map(|(k, v)| Op::Entry(k, v)),
            (0u8..8, any::<u8>()).prop_map(|(k, v)| Op::GetMut(k, v)),
        ]
    }

    proptest! {
        #![proptest_config(ProptestConfig { cases: 2048, ..ProptestConfig::default() })]

        /// VecMap agrees with BTreeMap on every operation the kernel uses,
        /// return values and observable contents both.
        #[test]
        fn vecmap_agrees_with_btreemap(ops in prop::collection::vec(op(), 0..40), probe in 0u8..8) {
            let (mut a, mut b) = (VecMap::new(), BTreeMap::new());
            for o in ops {
                match o {
                    Op::Insert(k, v) => prop_assert_eq!(a.insert(k, v), b.insert(k, v)),
                    Op::Remove(k) => prop_assert_eq!(a.remove(&k), b.remove(&k)),
                    Op::Retain(m) => {
                        a.retain(|k, v| (k ^ *v ^ m) % 3 != 0);
                        b.retain(|k, v| (k ^ *v ^ m) % 3 != 0);
                    }
                    Op::Entry(k, v) => prop_assert_eq!(*a.entry(k).or_insert_with(|| v), *b.entry(k).or_insert_with(|| v)),
                    Op::GetMut(k, v) => {
                        if let Some(x) = a.get_mut(&k) { *x = v; }
                        if let Some(x) = b.get_mut(&k) { *x = v; }
                    }
                }
                prop_assert_eq!(a.iter().map(|(k, v)| (*k, *v)).collect::<Vec<_>>(), b.iter().map(|(k, v)| (*k, *v)).collect::<Vec<_>>());
                prop_assert_eq!(a.len(), b.len());
                prop_assert_eq!(a.is_empty(), b.is_empty());
                prop_assert_eq!(a.get(&probe), b.get(&probe));
                prop_assert_eq!(a.contains_key(&probe), b.contains_key(&probe));
                prop_assert_eq!(a.keys().collect::<Vec<_>>(), b.keys().collect::<Vec<_>>());
                prop_assert_eq!(a.values().collect::<Vec<_>>(), b.values().collect::<Vec<_>>());
                prop_assert_eq!((&a).into_iter().count(), b.len());
            }
            let c: VecMap<u8, u8> = b.iter().map(|(k, v)| (*k, *v)).collect();
            prop_assert!(c == a, "collect agrees");
        }

        #[test]
        fn vecset_agrees_with_btreeset(xs in prop::collection::vec(0u8..8, 0..20), ys in prop::collection::vec(0u8..8, 0..20)) {
            let (mut a, mut b) = (VecSet::new(), BTreeSet::new());
            for x in &xs { prop_assert_eq!(a.insert(*x), b.insert(*x)); }
            let a2: VecSet<u8> = ys.iter().copied().collect();
            let b2: BTreeSet<u8> = ys.iter().copied().collect();
            prop_assert_eq!(a.iter().collect::<Vec<_>>(), b.iter().collect::<Vec<_>>());
            prop_assert_eq!(a.is_subset(&a2), b.is_subset(&b2));
            prop_assert_eq!(a.len(), b.len());
            for p in 0u8..8 { prop_assert_eq!(a.contains(&p), b.contains(&p)); }
            prop_assert_eq!((a == a2), (b == b2));
        }
    }
}
