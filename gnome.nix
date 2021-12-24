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

		[apps.guake.general]
		gtk-prefer-dark-theme=true
		start-at-login=true
		use-audible-bell=true
		
		[apps.guake.keybindings.global]
		show-hide='Menu'

		[apps.guake.style.font]
		palette='#000027273131:#D0D01B1B2424:#6B6BBEBE6C6C:#A5A577770505:#20207575C7C7:#C6C61B1B6E6E:#252591918585:#E9E9E2E2CBCB:#000063638888:#F4F415153B3B:#5050EEEE8484:#B1B17E7E2828:#17178D8DC7C7:#E1E14D4D8E8E:#0000B2B29E9E:#FCFCF4F4DCDC:#9B9BC1C1C2C2:#00001E1E2626'
		pallete-name='Solarized Dark Higher Contrast'
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
	#gnomeExtensions.ddterm # The package for ddterm is broken at the time of writing (24/12/2021)
	gjs # Ddterm requires gjs, but since the package seems to be broken it's not actually needed. I'll keep it here just in case ;)
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
  	meld
  ];
  
}
