{ pkgs ? import <nixpkgs> {} }:

let
  easy-dhall = import (
    pkgs.fetchFromGitHub {
      owner = "justinwoo";
      repo = "easy-dhall-nix";
      rev = "3e9101c5dfd69a9fc28fe4998aff378f91bfcb64";
      sha256 = "1nsn1n4sx4za6jipcid1293rdw8lqgj9097s0khiij3fz0bzhrg9";
    }
  ) {
    inherit pkgs;
  };

in
pkgs.runCommand "easy-ps-test" {
  buildInputs =
    builtins.attrValues {
      inherit (easy-dhall) dhall-simple;
    } ++
    [ pkgs.git pkgs.wget ];
} ""
