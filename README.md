# Vessel Package Set &middot; [![GitHub license](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![CI](https://github.com/dfinity/vessel-package-set/actions/workflows/ci.yml/badge.svg)](https://github.com/dfinity/vessel-package-set/actions?query=workflow:"build") [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/dfinity/vessel-package-set/pulls)

The official community package-set for Motoko libraries to use with [vessel](https://github.com/dfinity/vessel).

## What is a package set?

A package set is a collection of packages in which there is only one specified version for each package in the set.

This means that when you want to install a package:
- it must be in the package set
- its dependencies and all the transitive dependencies must be in the package set

## How do I use this with `vessel`?

You should point the `package-set.dhall` file in your project at a tagged release of this repository. For example:
```
let upstream =
  https://github.com/dfinity/vessel-package-set/releases/download/mo-0.7.5-20230118/package-set.dhall
in upstream
```

## Attribution

Much of this machinery and documentation is adapted from https://github.com/purescript/package-sets.
