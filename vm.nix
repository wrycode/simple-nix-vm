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

 swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8*1024;
  } ];

  # # Options for the screen
  # virtualisation.vmVariant = {
  #   virtualisation.resolution = {
  #     x = 1280;
  #     y = 1024;
  #   };
  #   virtualisation.qemu.options = [
  #     # Better display option
  #     "-vga virtio"
  #     "-display gtk,zoom-to-fit=false"
  #     # Enable copy/paste
  #     # https://www.kraxel.org/blog/2021/05/qemu-cut-paste/
  #     "-chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on"
  #     "-device virtio-serial-pci"
  #     "-device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0"
  #   ];
  # };
  services.xserver = {
	  enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
    layout = "us";
    xkbOptions = "ctrl:swap_ralt_rctl";
  };

  nix.settings.experimental-features = [ "flakes" "nix-command" ];

  # For copy/paste to work
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

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
