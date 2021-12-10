{
  description = "Example flake for CHICKEN eggs";

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
        eggs = with pkgs; import ./eggs.nix { inherit pkgs stdenv; };
      in rec {
        packages = flake-utils.lib.flattenTree rec {

          hello-chicken = with pkgs;
            eggDerivation rec {
              pname = "hello-chicken";
              version = "1.0.0";
              name = "${pname}-${version}";

              src = self;

              # src = fetchegg {
              #   inherit version;
              #   name = pname;
              #   sha256 = "1l5zkr6b8l5dw9p5mimbva0ncqw1sbvp3d4cywm1hqx2m03a0f1n";
              # };

              buildInputs = with eggs;
                [
                  # Dependencies from eggs.nix
                  this
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
          #   hello-chicken= flake-utils.lib.mkApp {
          #     drv = packages.hello-chicken;
          #     exePath = "/bin/home-assistant-grafana-relay";
          #   };
          # };
        };

        defaultPackage = packages.hello-chicken;
        # defaultApp = apps.hello-chicken;
      });
}
