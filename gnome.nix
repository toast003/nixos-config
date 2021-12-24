# GNOME Desktop Environment settings.
{ config, pkgs, ... }:

{
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.nvidiaWayland = false;
  services.xserver.desktopManager.gnome = {
  	enable = true;
  	extraGSettingsOverrides = ''
  		# Change default background
  		[org.gnome.desktop.background]
  		picture-uri='file://${pkgs.nixos-artwork.wallpapers.mosaic-blue.gnomeFilePath}'

  		# Enable Gnome extentions
		[org.gnome.shell]
  		enabled-extensions=['appindicatorsupport@rgcjonas.gmail.com', 'better-osd@hllvc', 'blur-my-shell@aunetx', 'display-brightness-ddcutil@themightydeity.github.com', 'caffeine@patapon.info', 'ddterm@amezin.github.com', 'fullscreen-notifications@sorrow.about.alice.pm.me', 'gnome-ui-tune@itstime.tech', 'gsconnect@andyholmes.github.io', 'drive-menu@gnome-shell-extensions.gcampax.github.com', 'sound-output-device-chooser@kgshank.net', 'syncthing@gnome.2nv2u.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']
		
		# Set "Menu" key to toggle ddterm
		[com.github.amezin.ddterm]
		ddterm-toogle-hotkey=['Menu']
  	'';
  	 extraGSettingsOverridePackages = [
  	 	pkgs.gsettings-desktop-schemas
  	 	pkgs.gnome.gnome-shell
  	 ];
  };
    
  services.gnome.core-utilities.enable = false; # Only install the GNOME desktop and not the core apps.
  services.gnome.gnome-keyring.enable = pkgs.lib.mkForce false; # For some reason if you just set it to false it errors out.
  environment.systemPackages = with pkgs; [
	# Gnome extensions.
	gnomeExtensions.ddterm
	gjs # For some reason gjs in not installed by default, and ddterm needs it
	gnomeExtensions.jiggle
	gnomeExtensions.appindicator
	gnomeExtensions.better-osd-gnome-40
	gnomeExtensions.blur-my-shell
	gnomeExtensions.brightness-control-using-ddcutil
	gnomeExtensions.caffeine
	gnomeExtensions.fullscreen-notifications
	gnomeExtensions.gnome-40-ui-improvements
	gnomeExtensions.gsconnect
	gnomeExtensions.removable-drive-menu
	gnomeExtensions.sound-output-device-chooser
	gnomeExtensions.syncthing-indicator
	gnomeExtensions.workspace-indicator
	
  	gnome.gnome-terminal
  	gnome.gnome-disk-utility
  	gnome.gedit
	gnome.nautilus
	gnome.baobab
	gnome.dconf-editor
  	gnome.file-roller
  	evince
  ];
  
}
