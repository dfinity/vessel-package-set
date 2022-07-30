let map =
      https://prelude.dhall-lang.org/v20.1.0/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let PackageInfo = ./src/PackageInfo.dhall

let Package = ./src/Package.dhall

let makePackage =
      \(info : PackageInfo) -> info.{ name, version, dependencies, repo }

in  map PackageInfo Package makePackage ./src/packages.dhall
