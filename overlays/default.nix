{inputs, ...}: {
  # Bring in our custom packages from the 'pkgs' directory
  additions = final: _prev:
    import ../pkgs {
      pkgs = final;
      inputs = inputs;
    };

  modifications = final: prev: {
    mutter = prev.mutter.overrideAttrs (oldAttrs: {
      # GNOME dynamic triple buffering (huge performance improvement)
      # See https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441
      src = final.fetchFromGitLab {
        domain = "gitlab.gnome.org";
        owner = "vanvugt";
        repo = "mutter";
        rev = "triple-buffering-v4-47";
        hash = "sha256-Jlhzt2Cc44epkBcz3PA6I5aTnVEqMsHBOE8aEmvANWw=";
      };

      preConfigure = let
        gvdb = final.fetchFromGitLab {
          domain = "gitlab.gnome.org";
          owner = "GNOME";
          repo = "gvdb";
          rev = "2b42fc75f09dbe1cd1057580b5782b08f2dcb400";
          hash = "sha256-CIdEwRbtxWCwgTb5HYHrixXi+G+qeE1APRaUeka3NWk=";
        };
      in ''
        cp -a "${gvdb}" ./subprojects/gvdb
      '';
    });
  };
}
