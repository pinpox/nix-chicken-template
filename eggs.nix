{ pkgs, stdenv }:
let
  inherit (pkgs) eggDerivation fetchegg;
in
rec {

  this = eggDerivation {
    name = "this-0.1";

    src = fetchegg {
      name = "this";
      version = "0.1";
      sha256 = "1dz5lqfkyxbxr3s9806rc5n4kcg34wr1v83jjqq2p233w03j6j0f";
    };

    buildInputs = [
      
    ];
  };
}

