{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    sherlock.url = "github:Skxxtz/sherlock";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    sherlock,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            just
            nushell
            sherlock.packages.${system}.default
          ];
        };
      }
    );
}
