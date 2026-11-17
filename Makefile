HOST ?= notebook
FLAKE := ./devices/$(HOST)/nix

.PHONY: check build switch update
check:
	nix flake check $(FLAKE) --no-build
build:
	nixos-rebuild build --flake $(FLAKE)#$(HOST)
switch:
	sudo nixos-rebuild switch --flake $(FLAKE)#$(HOST)
update:
	nix flake update --flake $(FLAKE)
