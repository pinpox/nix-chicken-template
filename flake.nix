{
  description = "Parse blog rss to markdown";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        eggs = with pkgs; import ./eggs.nix { inherit eggDerivation fetchegg; };
      in rec {
        packages = flake-utils.lib.flattenTree rec {

          blog-parser = with pkgs;
            eggDerivation rec {
              pname = "blog-parser";
              version = "1.0.0";
              name = "${pname}-${version}";

              src = self;

              # src = fetchegg {
              #   inherit version;
              #   name = pname;
              #   sha256 = "1l5zkr6b8l5dw9p5mimbva0ncqw1sbvp3d4cywm1hqx2m03a0f1n";
              # };

              # installPhase = ''
              #   # mkdir -p $out
              #    runHook preInstall
              #    export CHICKEN_INSTALL_PREFIX=$out
              #    export CHICKEN_INSTALL_REPOSITORY=$out/lib/chicken/${
              #      toString chicken.binaryVersion
              #    }

              #    echo $CHICKEN_INSTALL_PREFIX
              #    echo $CHICKEN_INSTALL_REPOSITORY
              #   echo THIS1
              #    chicken-install -v ${lib.concatStringsSep " " [ ]}
              #   echo THIS
              #    ls
              #    for f in $out/bin/*
              #    do
              #      wrapProgram $f \
              #        --prefix CHICKEN_REPOSITORY_PATH : "$out/lib/chicken/${
              #          toString chicken.binaryVersion
              #        }:$CHICKEN_REPOSITORY_PATH" \
              #        --prefix CHICKEN_INCLUDE_PATH : "$CHICKEN_INCLUDE_PATH:$out/share" \
              #        --prefix PATH : "$out/bin:${chicken}/bin:$CHICKEN_REPOSITORY_PATH"
              #    done
              #    runHook postInstall
              # '';

              buildInputs = with eggs;
                [
                  # aes
                  # crypto-tools
                  # matchable
                  # message-digest
                  # miscmacros
                  # parley
                  # pathname-expand
                  # posix-extras
                  # regex
                  # sha2
                  # sql-de-lite
                  # srfi-37
                  # ssql
                  # stty
                  # tiger-hash
                  # z3
                ];

              meta = with lib; {
                homepage = "TODO";
                description = "TODO";
                license = licenses.gpl3;
                maintainers = [ maintainers.pinpox ];
                platforms = platforms.unix;
              };
            };

          # apps = {
          #   blog-parser= flake-utils.lib.mkApp {
          #     drv = packages.blog-parser;
          #     exePath = "/bin/home-assistant-grafana-relay";
          #   };
          # };
        };

        defaultPackage = packages.blog-parser;
        # defaultApp = apps.blog-parser;
      });
}

# { pkgs, lib, eggDerivation, fetchegg }:
# let
#   eggs = import ./eggs.nix { inherit eggDerivation fetchegg; };
# in
