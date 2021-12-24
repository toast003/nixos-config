# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./gnome.nix
    ];

  # Boot loader settings.
  boot.loader = {
  	timeout = 2;
  	systemd-boot = {
  		enable = true;
  		consoleMode = "max";
  		editor = false;
  		memtest86.enable = true;
  	};
  	efi.canTouchEfiVariables = true;
  };
  
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # networking.hostName = "nixos"; # Define your hostname.
  networking.hostName = "nix";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  time.timeZone = "Europe/Madrid";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp38s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # X11 windowing system settings.
  services.xserver = {
  	enable = true;
  	videoDrivers = [ "nvidia" ];
  	displayManager.setupCommands = "nvidia-settings -l";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "es_ES.UTF-8";
  services.xserver.layout = "es";
  console.keyMap = "es";
 
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };
  users.users.temp = {
  	isNormalUser = true;
  	extraGroups = [ "wheel" "networkmanager" ];
  	hashedPassword = "$6$9o0gAL5PAtuclNlu$akCYrwpcxwEBucie1KG43Qjb3wTWJhFk9yW1PNNjRwMFuJfLL8u2p4S7bpRKFBCNsGDHTbt3AsZKhnxfwXEFN/";
  };
  # Use declarative user management
  users.mutableUsers = false;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  #   firefox
  # ];
  
  # Allow packages with unfree licenses.
  nixpkgs.config.allowUnfree = true;
  environment = {
 	variables = {
 		MOZ_USE_XINPUT2 = "1"; # Enable smooth scrolling on firefox.
 		EIDTOR = "micro";
 	};
  	systemPackages = with pkgs; [
		# CLI programs
		git
		micro
		neofetch
		
		# GUI Apps.
		discord-canary
		firefox
		# Steam needs to be enabled with programs.steam.enable
		# Noisetorch needs to be enabled with programs.noisetorch.enable
		keepassxc
		
		# Optional dependencies.
		xclip # Use system clipboard on micro.
    ];  	
  };
  programs.steam.enable = true;
  programs.noisetorch.enable = true;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "21.11"; # Did you read the comment?

}

