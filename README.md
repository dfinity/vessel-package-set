[![Build Status](https://travis-ci.org/kritzcreek/vessel-package-set.svg?branch=master)](https://travis-ci.org/kritzcreek/vessel-package-set)

# Vessel Package Set

I'm using this repository to figure out how to best host a package set for the
[vessel](https://github.com/kritzcreek/vessel) package manager.

## Usage in your project

You can point your projects `package-set.dhall` at the latest release.
```
let upstream =
  https://github.com/kritzcreek/vessel-package-set/releases/download/mo-0.4.2-20200904/package-set.dhall
```
