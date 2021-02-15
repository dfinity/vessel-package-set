![Package CI](https://github.com/dfinity/vessel-package-set/workflows/build/badge.svg)

# Vessel Package Set

The official community package-set for Motoko libraries to use with [vessel](https://github.com/dfinity/vessel).

## What is a package set?

A package set is a **collection** of packages, such that there is only **one** entry (i.e. version) for a given package in the set.

This means that when you want to install a package:
- it must be in the package set
- its dependencies and all the transitive dependencies must be in the package set

## Add your package

This repository aims to be a good collection of packages you can depend on.
In general we welcome all packages, provided that they follow some guidelines defined in the [contributing guide](CONTRIBUTING.md).

The linked document also contains instructions on how to add new packages to the set, and information on versioning and related policies.


## How do I use this with `vessel`?

You should point the `package-set.dhall` file in your project at a tagged release of this repository like so:
```
let upstream =
  https://github.com/dfinity/vessel-package-set/releases/download/mo-0.4.2-20200904/package-set.dhall
in upstream
```

## Attribution

Much of this machinery and documentation is adapted from the lovely https://github.com/purescript/package-sets
