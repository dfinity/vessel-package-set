[![Build Status](https://travis-ci.org/kritzcreek/vessel-package-set.svg?branch=master)](https://travis-ci.org/kritzcreek/vessel-package-set)

# Vessel Package Set

I'm using this repository to figure out how to best host a package set for the
[vessel](https://github.com/kritzcreek/vessel) package manager.

## Usage in your project

For now point directly at a raw GitHub link:

In your projects `package-set.dhall`
```
let upstream =
    https://raw.githubusercontent.com/kritzcreek/vessel-package-set/b8a50b772af45877ed1d7fae929c415820790b01/src/packages.dhall
...
```
