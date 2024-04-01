# Build this VM with nix build  ./#nixosConfigurations.vm.config.system.build.vm
# Then run is with: ./result/bin/run-nixos-vm
# To be able to connect with ssh enable port forwarding with:
# QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-nixos-vm
# Then connect with ssh -p 2222 guest@localhost
{ lib, config, pkgs, ... }:
{
  # Internationalisation options
  i18n.defaultLocale = "en_US.UTF-8";

  # A default user able to use sudo
  users.users.wrycode = {
    isNormalUser = true;
    home = "/home/wrycode";
    extraGroups = [ "wheel" ];
    initialPassword = "password123";
  };

  services.xserver = {
	  enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    layout = "us";
    xkbOptions = "ctrl:swap_ralt_rctl";
  };

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # For copy/paste to work
  services.qemuGuest.enable = true;

  # Included packages here
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    home-manager
    git
    gnome.adwaita-icon-theme
  ];

  system.stateVersion = "23.11";
}
