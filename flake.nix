{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          librsvg
          ghostscript
          # openscad
          (python3.withPackages (ps: with ps; [
            pip
            virtualenv
          ]))
        ];
        shellHook = ''
          virtualenv .venv
          source .venv/bin/activate
          pip install papersize
        '';
      };
    };
}
