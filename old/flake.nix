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

    # {
    #   nixosModules = { blog-parser= import ./module.nix; };
    # } //

    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages = flake-utils.lib.flattenTree rec {

          blog-parser = pkgs.buildGoModule rec {
            pname = "blog-parser";
            version = "1.0.0";
            src = self;
            vendorSha256 = null;

            meta = with pkgs.lib; {
              maintainers = with maintainers; [ pinpox ];
              license = licenses.gpl3;
              description = "TODO";
              homepage = "TODO";
            };
          };
        };

        apps = {
          blog-parser= flake-utils.lib.mkApp {
            drv = packages.blog-parser;
            exePath = "/bin/home-assistant-grafana-relay";
          };
        };

        defaultPackage = packages.blog-parser;
        defaultApp = apps.blog-parser;
      });
}

