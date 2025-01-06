{ root, ... }:

{
  imports = [
    "${root}/modules/android.nix"
    "${root}/modules/audio.nix"
    "${root}/modules/bootloader.nix"
    "${root}/modules/browsers.nix"
    "${root}/modules/build_tools.nix"
    "${root}/modules/compression.nix"
    "${root}/modules/debugging.nix"
    "${root}/modules/desktop.nix"
    "${root}/modules/documents.nix"
    "${root}/modules/editors.nix"
    "${root}/modules/game_development.nix"
    "${root}/modules/images.nix"
    "${root}/modules/languages.nix"
    "${root}/modules/network.nix"
    "${root}/modules/nix_tools.nix"
    "${root}/modules/printing.nix"
    "${root}/modules/reverse_engineering.nix"
    "${root}/modules/server.nix"
    "${root}/modules/system_information.nix"
    "${root}/modules/system_tools.nix"
    "${root}/modules/videos.nix"
    "${root}/modules/virtualization.nix"
  ];

  nix.settings.experimental-features = "nix-command flakes";

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
