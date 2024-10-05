all:
	nixos-rebuild build

install:
	nixos-rebuild switch
