{
  description = "monologique's personal packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      forAllSystems =
        fn:
        nixpkgs.lib.genAttrs systems (
          system:
          fn (
            import nixpkgs {
              inherit system;
            }
          )
        );
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.buildEnv {
          name = "nix-packages";
          paths = with pkgs; [
            self.packages.${pkgs.system}.typewritten
            self.packages.${pkgs.system}.emacs
            zsh-fast-syntax-highlighting
            direnv
            nix-direnv
            helix
            tmux
            p7zip
            zsh-history-substring-search
            git
            fontconfig
            ffmpeg
            wireguard-tools
            mas
          ];
        };
        emacs = pkgs.callPackage ./packages/emacs.nix { };
        typewritten = pkgs.callPackage ./packages/typewritten.nix { };
      });

      apps = forAllSystems (pkgs: { });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            bash-language-server
            nil
            nixfmt-rfc-style
            taplo
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);
    };
}
