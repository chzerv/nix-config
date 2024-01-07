{inputs, ...}: {
  # The system is running on nixpkgs-unstable, but we might want to install
  # packages from nixpkgs-stable. This overlays makes it so stable packages
  # are accessible via `pkgs.stable`.
  nixpkgs-stable = final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };

  gnome-triple-buffering = final: prev: {
    gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
      mutter = gnomePrev.mutter.overrideAttrs (old: {
        src = prev.fetchgit {
          url = "https://gitlab.gnome.org/vanvugt/mutter.git";
          # GNOME 45: triple-buffering-v4-45
          rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
          sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
        };
      });
    });
  };

  # Alacritty v.0.13.0
  alacritty = final: prev: let
    rpathLibs = with final;
      [
        expat
        fontconfig
        freetype
      ]
      ++ lib.optionals stdenv.isLinux [
        libGL
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXrandr
        xorg.libXxf86vm
        xorg.libxcb
        libxkbcommon
        wayland
      ];
  in {
    alacritty = prev.alacritty.overrideAttrs (old: rec {
      version = "0.13.1";
      pname = "alacritty-v0.13.1";

      src = prev.fetchFromGitHub {
        owner = "alacritty";
        repo = "alacritty";
        rev = "57da0bf903b0d809b2f76aac2e0080bc80e11e83";
        hash = "sha256-6KM3OAZNMHM5W3kWNuYizMk5DY1uJ5WqI0NMmjKA52I=";
      };

      # We can't directly override `cargoHash`. Instead, we have to do it through `cargoDeps`
      # We also provide a new name for the overlay
      cargoDeps = old.cargoDeps.overrideAttrs (_: {
        name = "alacritty-0.13.1-vendor.tar.gz";
        inherit src;

        outputHash = "sha256-N1Pv+lRa90BAtKF1ozW1choixinfqfRfV+AQi1vlvcQ=";
      });

      nativeBuildInputs = old.nativeBuildInputs ++ [final.scdoc];

      # In Alacritty v0.13.0, man pages are generated using `scdoc`. Also, alacritty.yml no longer exists.
      # We have to modify `postInstall` to reflect these changes.
      postInstall =
        ''
          install -D extra/linux/Alacritty.desktop -t $out/share/applications/
          install -D extra/linux/org.alacritty.Alacritty.appdata.xml -t $out/share/appdata/
          install -D extra/logo/compat/alacritty-term.svg $out/share/icons/hicolor/scalable/apps/Alacritty.svg

          # patchelf generates an ELF that binutils' "strip" doesn't like:
          #    strip: not enough room for program headers, try linking with -N
          # As a workaround, strip manually before running patchelf.
          $STRIP -S $out/bin/alacritty

          patchelf --add-rpath "${final.lib.makeLibraryPath rpathLibs}" $out/bin/alacritty
        ''
        + ''

          installShellCompletion --zsh extra/completions/_alacritty
          installShellCompletion --bash extra/completions/alacritty.bash
          installShellCompletion --fish extra/completions/alacritty.fish

          mkdir -p $out/share/man/man1
          mkdir -p $out/share/man/man5

          scdoc < extra/man/alacritty.1.scd | gzip -c > $out/share/man/man1/alacritty.1.gz
          scdoc < extra/man/alacritty-msg.1.scd | gzip -c > $out/share/man/man1/alacritty-msg.1.gz
          scdoc < extra/man/alacritty.5.scd | gzip -c > $out/share/man/man5/alacritty.5.gz
          scdoc < extra/man/alacritty-bindings.5.scd | gzip -c > $out/share/man/man5/alacritty-bindings.5.gz

          install -dm 755 "$terminfo/share/terminfo/a/"
          tic -xe alacritty,alacritty-direct -o "$terminfo/share/terminfo" extra/alacritty.info
          mkdir -p $out/nix-support
          echo "$terminfo" >> $out/nix-support/propagated-user-env-packages
        '';
    });
  };
}
