# This allows you to run csi and (import matchable)
# However, chickenEggs is a pretty limited set of eggs.
# You can use egg2nix to generate an eggs.nix with whichever other eggs you desire (see e.g. nixpkgs/pkgs/tools/backup/ugarit)

{
  pkgs ? import <nixpkgs> { }
}:
pkgs.mkShell {
  buildInputs = with pkgs.chickenPackages; [
    chicken
    chickenEggs.matchable
    chickenEggs.matchable
  ];
}
