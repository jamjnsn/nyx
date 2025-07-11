{ pkgs, ... }:
{
  # Add user to libvirtd group
  users.users.jamie.extraGroups = [ "libvirtd" ];

  # Install necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];

  # Manage the virtualisation services
  virtualisation = {
    waydroid.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}
