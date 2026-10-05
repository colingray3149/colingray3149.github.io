{
  description = "colingray3149.github.io — Astro personal site";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      src = pkgs.lib.cleanSource ./.;
    in
    {
      packages.${system}.default = pkgs.buildNpmPackage {
        pname = "colingray3149.github.io";
        version = "0.1.0";
        inherit src;
        npmDepsHash = "sha256-/lOt1cYFulMtYaA7KqcnSI4aacopNueVQcrhl/tXC3Q=";
        env.ASTRO_TELEMETRY_DISABLED = "1";
        installPhase = ''
          runHook preInstall
          mkdir -p "$out"
          cp -r dist/. "$out"/
          runHook postInstall
        '';
      };

      checks.${system}.site = self.packages.${system}.default;

      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.nodejs_22 ];
      };
    };
}
