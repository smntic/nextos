{ pkgs, lib, config, ... }:

{
  options = {
    modules.rust.enable = lib.mkEnableOption "rust";
  };

  config = lib.mkIf config.modules.rust.enable {
    environment.systemPackages = [
      pkgs.cargo
      pkgs.rustc
    ];

    # https://discourse.nixos.org/t/rust-src-not-found-and-other-misadventures-of-developing-rust-on-nixos/11570/5
    environment.variables = {
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
  };
}
