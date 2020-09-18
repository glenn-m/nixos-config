{ pkgs ? import <nixpkgs> {} }:
{
  sdorfehs = pkgs.callPackage ./sdorfehs/default.nix { };
  tex = pkgs.texlive.combine {
    inherit (pkgs.texlive)
      scheme-basic wrapfig ulem capt-of collection-fontsrecommended;
  };
}
