system_rebuild := "sudo nixos-rebuild switch --flake ."
home_rebuild := "home-manager switch --flake ."

update:
	nix flake update
	{{ system_rebuild }}
	{{ home_rebuild }}

system:
	{{ system_rebuild }}

home:
	{{ home_rebuild }}
