# Contributing to `vessel-package-sets`

Thank you for your interest in contributing to the vessel-package-set. By participating in this project, you agree to abide by our Code of Conduct.

This document is meant to be a general guide and FAQ for contributors to this repo.

It defines some policies that are applied, and details how to add new packages and the criteria packages should match to stay in the set.


- [General](#general)
- [Releases](#releases)
- [Will any package be dropped at any point?](#will-any-package-be-dropped-at-any-point)
- [How to add a package to the set](#how-to-add-a-package-to-the-set)
  - [0. Background knowledge](#0-background-knowledge)
    - [Why/how Dhall?](#whyhow-dhall)
    - [Brief detour of how the package-set is structured](#brief-detour-of-how-the-package-set-is-structured)
    - [Prerequisites](#prerequisites)
  - [1. Adding a new package](#1-adding-a-new-package)
  - [2. Verifying a package](#2-verifying-a-package)


## General

All changes go through pull requests.
Packages must comply with the following criteria.
- They build against their dependencies at the versions specified in the current package-set
- Your package must be versioned using SemVer and begin with a `v` like so: `v1.2.3`

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

To hack on this project, it should be enough to have [nix](https://nixos.org/nix/download.html) installed. You can verify your changes with

    nix-shell --command make


If you're unable to run Nix but able to run `docker`, then you can achieve the same result with the following:

    docker run -t --mount type=bind,source="$(pwd)",target=/vessel-package-set nixos/nix /bin/sh -c 'cd /vessel-package-set; nix-shell --run "make"'

If none of these are available you can also make the change to the `.dhall` files, open a pull request, and let CI run the checks for you at the price of long feedback cycles.

### TL;DR

The following section will detail how to add a package to the package-set.

The *TL;DR* about it is:
- add the Dhall package definition in some `src/groups/${username}.dhall` (where `username` is one of the authors of the package)
- if adding a new group file, also add a new line containing `# ./groups/${username}.dhall` to `src/packages.dhall`
- run `make` and `vessel verify --version ${current-compiler-version} ${your-new-package-name}`

### 0. Background knowledge

#### Why/how Dhall?

[Dhall](https://github.com/dhall-lang/dhall-lang) is a programming language that guarantees
termination. Its most useful characteristics for uses in this project are:
* Static typing with correct inference
* Functions: we can use functions to create simple functions for defining packages
* Local and remote path importing: we can use this to mix and match local and remote sources as necessary to build package sets
* Typed records with directed merging: we can use this to split definitions into multiple groupings and apply patching of existing packages as needed

Let's look at the individual parts for how this helps us make a package-set.

#### Brief detour of how the package-set is structured

The files in this package-set are structured as such:

```
-- Package type definition
src/Package.dhall

-- packages to be included when building package set
src/packages.dhall

-- package "groups" where packages are defined in records
src/groups/[...].dhall

-- The entry point to the package-set. Just points at `src/packages.dhall`
./package-set.dhall
```

The `Package.dhall` contains the simple type that is the definition of a package:

```hs
{ name : Text, dependencies : List Text, repo : Text, version : Text }
```

So a given package is nothing more than:
- a name
- a list of dependencies
- the git url for the repository
- and the tag or branch that it can be pulled from.

The `packages.dhall` is the actual "package-set": a list of package definitions.
It is defined by taking package definitions from the groups and concatenating them.

```
  ./groups/dfinity.dhall
# ./groups/kritzcreek.dhall
# ./groups/matthewhammer.dhall
# ./groups/enzoh.dhall
# ...
```

### 1. Adding a new package

To add a new package to the package set, you should create a package definition matching the Package type, and put it in the group file corresponding to the author's username.

For example, if I wish to add to the package-set the version `v4.2.0` of the package `some-food` from `someauthor`, I will create the file `src/groups/someauthor.dhall`.

Its content would look something like this:

```hs
[ { name =  "some-food"
  , dependencies =
      [ "base" ]
  , repo =
      "https://github.com/someauthor/motoko-some-food.git"
  , version =
      "v4.2.0"
  }
]
```

Then add a new line containing a reference to the new group to the `src/packages.dhall` file.

For our example:

```hs
…
      # ./groups/someauthor.dhall
…
```


### 2. Verifying a package

After adding your package to the Dhall files, you should check that the package-set is still consistent.

In order to verify the addition (or change), you should follow these steps:
- `make`: this will format the files with `dhall`
- `vessel verify --version ${current-compiler-version} ${your-new-package-name}`

Note: if you have `nix` installed, then you should run `nix-shell` and then run these commands inside, for better reproducibility.

Once it verifies correctly check in both the Dhall files.

You're now ready to commit! 🙂

[dhall]: https://github.com/dhall-lang/dhall-haskell
[releases]: https://github.com/dfinity/vessel-package-sets/releases
[issues]: https://github.com/dfinity/vessel-package-sets/issues
[vessel]: https://github.com/dfinity/vessel
