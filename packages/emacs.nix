{
  emacs29-pgtk,
  fetchpatch,
  stdenv,
  ...
}:
let
  emacs-darwin = emacs29-pgtk.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [
      # Fix OS window role (needed for window managers like yabai)
      (fetchpatch {
        url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/fix-window-role.patch";
        sha256 = "+z/KfsBm1lvZTZNiMbxzXQGRTjkCFO4QPlEK35upjsE=";
      })
      # Make Emacs aware of OS-level light/dark mode
      (fetchpatch {
        url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/system-appearance.patch";
        sha256 = "oM6fXdXCWVcBnNrzXmF0ZMdp8j0pzkLE66WteeCutv8=";
      })
    ];
  });

  useEmacs =
    e:
    e.pkgs.withPackages (
      epkgs: with epkgs; [
        meow
        corfu
        marginalia
        eglot
        direnv

        (treesit-grammars.with-grammars (grammars: [
          tree-sitter-langs
          grammars.tree-sitter-nix
          grammars.tree-sitter-ocaml
          grammars.tree-sitter-bash
          grammars.tree-sitter-c
          grammars.tree-sitter-cpp
          grammars.tree-sitter-css
          grammars.tree-sitter-dockerfile
          grammars.tree-sitter-go
          grammars.tree-sitter-gomod
          grammars.tree-sitter-html
          grammars.tree-sitter-java
          grammars.tree-sitter-javascript
          grammars.tree-sitter-json
          grammars.tree-sitter-lua
          grammars.tree-sitter-make
          grammars.tree-sitter-markdown
          grammars.tree-sitter-python
          grammars.tree-sitter-regex
          grammars.tree-sitter-ruby
          grammars.tree-sitter-rust
          grammars.tree-sitter-scala
          grammars.tree-sitter-sql
          grammars.tree-sitter-toml
          grammars.tree-sitter-tsx
          grammars.tree-sitter-typescript
          grammars.tree-sitter-yaml
          grammars.tree-sitter-cmake
          grammars.tree-sitter-elixir
          grammars.tree-sitter-haskell
          grammars.tree-sitter-julia
          grammars.tree-sitter-latex
          grammars.tree-sitter-r
          grammars.tree-sitter-vue
        ]))
      ]
    );
in
if stdenv.isDarwin then (useEmacs emacs-darwin) else (useEmacs emacs29-pgtk)
