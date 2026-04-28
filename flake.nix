{
  description = "use-state-observation flake";

  inputs.mc-rtc-nix.url = "github:mc-rtc/nixpkgs";
  inputs.state-observation.url = "github:jrl-umi3218/state-observation/pull/24/head";
  # inputs.state-observation.url = "path:/home/arnaud/devel/mc-rtc-nix/workspace/state-observation";
  inputs.jrl-cmakemodulesv2.url = "github:jrl-umi3218/jrl-cmakemodules/pull/798/head";
  # inputs.jrl-cmakemodulesv2.url = "path:/home/arnaud/devel/mc-rtc-nix/workspace/jrl-cmakemodulesv2";

  outputs =
    inputs:
    inputs.mc-rtc-nix.lib.mkFlakoboros inputs (
      { ... }:
      {
        packages = {
          use-state-observation =
            {
              stdenv,
              cmake,
              state-observation,
              jrl-cmakemodules,
              lib,
              ...
            }:
            stdenv.mkDerivation {
              name = "use-state-observation";
              src = lib.cleanSource ./.;
              nativeBuildInputs = [
                cmake
                jrl-cmakemodules
              ];
              propagatedBuildInputs = [
                state-observation
              ];

              meta = with lib; {
                description = "test using state observation";
                homepage = "";
                license = licenses.bsd2;
                platforms = platforms.all;
              };
            };
        };
        overrideAttrs.state-observation =
          { drv-prev, pkgs-final, ... }:
          {
            src = inputs.state-observation;
            nativeBuildInputs = [
              pkgs-final.jrl-cmakemodulesv2
              pkgs-final.gbenchmark
            ]
            ++ drv-prev.nativeBuildInputs;
          };
        overrideAttrs.jrl-cmakemodulesv2 =
          { ... }:
          {
            src = inputs.jrl-cmakemodulesv2;
          };
      }
    );
}
