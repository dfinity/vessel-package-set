# Contributing to `vessel-package-sets`

Thank you for your interest in contributing to the vessel-package-set. By participating in this project, you agree to abide by our Code of Conduct.

This document is meant to be a general guide and FAQ for contributors to this repo.

It defines some policies that are applied, and details how to add new packages and the criteria packages should match to stay in the set.


- [General](#general)
- [Releases](#releases)
- [Will any package be dropped at any point?](#will-any-package-be-dropped-at-any-point)
- [How to add a package to the set](#how-to-add-a-package-to-the-set)
  - [Prerequisites](#prerequisites)
  - [Adding a new package](#adding-a-new-package)
  - [Verifying a package](#verifying-a-package)
  - [Updating a package](#updating-a-package)


## General

All changes go through pull requests.
Packages must comply with the following criteria.
- They build against their dependencies at the versions specified in the current package-set
- Your package must be versioned using SemVer and begin with a `v` like so: `v1.2.3`
  (`base` is the outlier to this rule, using a hash instead, because we lack versioning for it now).

## Releases

A "release" of the package set consists in a *git tag* (i.e. what GitHub calls a release).

Releases happen quite often (look at the [release history][releases]), and anyone can request a new release at any time, by just [opening an issue][issues].
This implies that the `master` branch should always be "release ready".

Releases have the following naming convention:
```
mo-${compiler-version}-${date}
```

Where:
- `compiler-version` is the version of the compiler supported by the package-set.
  Support for different versions of the compiler is implied by SemVer, e.g. if a package-set is compatible with `0.12.2`, then it will be compatible with `0.12.3`, but not `0.12.1` or `0.13.0`.
- `date` is the release date, in `yyyyMMdd` format.

## Will any package be dropped at any point?

For package-sets to be able to keep up with the new releases in the ecosystem, package maintainers should strive for having their packages work with the latest versions of dependencies.

This is because if packages `X@v1` and `Y@v1` depend on package `Z@v1` then if package X releases `v2` that depends on `Z@v2`, then also package Y should be updated to depend on it. (this is because a package-set contains only *one* version of every package)

However, things happen and packages go unmaintained, so there's the need to drop packages from the package-set every once in a while, in order to allow for the majority of the packages to keep up with the latest versions.

Once a package version introduces breakage, the upstream will be notified (via issue or pull request) and a package might be removed from the set if there is no activity after 1 week.
You can of course fix your package later and re-add it.

## How to add a package to the set

### Prerequisites

To hack on this project, you'll need to have both `vessel` and `dhall` binaries on your PATH. You can check the [CI configuration][ci] for the used versions and how to get the binaries.

If you can't get these to work for some reason you can also make the change to the `.dhall` files, open a pull request, and let CI run the checks for you at the price of long feedback cycles.

### Adding a Package

The following section will detail how to add a package to the package-set.

The *TL;DR* about it is:
- add the Dhall package definition in some `index/${package-name}.dhall`
- also add an entry containing `, ../index/${package-name}.dhall` to `src/packages.dhall`
- run `make` and `vessel verify --version ${current-compiler-version} ${your-new-package-name}`


### Verifying a package

After adding your package to the Dhall files, you should check that the package-set is still consistent.

In order to verify the addition (or change), you should follow these steps:
- `make`: this will format the files with `dhall`
- `vessel verify --version ${current-compiler-version} ${your-new-package-name}`

Once it verifies correctly check in both the Dhall files.

You're now ready to commit! 🙂

### Updating a package

In order to update the version of a package, change `version` field in `index/{package-name}.dhall`, and run the "Verifying a package" steps as outlined above. The next package set release will then include the updated package.

[dhall]: https://github.com/dhall-lang/dhall-haskell
[releases]: https://github.com/dfinity/vessel-package-set/releases
[issues]: https://github.com/dfinity/vessel-package-set/issues
[vessel]: https://github.com/dfinity/vessel
[ci]: https://github.com/dfinity/vessel-package-set/blob/master/.github/workflows/ci.yml
