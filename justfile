nh_system_rebuild := "nh os switch ."
nh_home_rebuild := "nh home switch ."

up:
	nix flake update
	{{ nh_system_rebuild }}
	{{ nh_home_rebuild }}

sys:
	{{ nh_system_rebuild }}

hm:
	{{ nh_home_rebuild }}
