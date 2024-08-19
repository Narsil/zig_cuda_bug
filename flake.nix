{
  inputs = {
    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "tgi-nix/nixpkgs";
    };
    tgi-nix.url = "github:danieldk/tgi-nix";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.follows = "tgi-nix/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, tgi-nix, nixpkgs, flake-utils, zig-overlay }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          config = {
            allowUnfree = true;
            cudaSupport = true;
          };
          pkgs = import nixpkgs {
            inherit config system;
            overlays = [
              tgi-nix.overlay
              zig-overlay.overlays.default
            ];
          };
        in
        with pkgs;
        {
          devShells.default = mkShell.override { stdenv = gcc12Stdenv; } {
            buildInputs = with cudaPackages;[ 
              zig 
              cuda_cudart
              cuda_nvrtc
              cuda_cccl
              cuda_nvcc
              pkg-config 
            ];
          };
        }
      );
}

