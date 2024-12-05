all:
	nixos-rebuild build

install:
	nixos-rebuild switch

boot:
	nixos-rebuild boot
