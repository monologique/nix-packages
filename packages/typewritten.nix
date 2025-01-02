{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "typewritten";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "reobin";
    repo = "typewritten";
    rev = "6f78ec20f1a3a5b996716d904ed8c7daf9b76a2a";
      sha256 = "qiC4IbmvpIseSnldt3dhEMsYSILpp7epBTZ53jY18x8=";
  };

  installPhase = ''
    mkdir -p $out/share/zsh/themes/typewritten
    cp -r * $out/share/zsh/themes/typewritten/

    # Créer un fichier .zsh-theme qui source le thème
    cat > $out/share/zsh/themes/typewritten.zsh-theme <<EOF
    source $out/share/zsh/themes/typewritten/typewritten.zsh
    EOF
  '';

  meta = with lib; {
    description = "A minimal, informative zsh prompt theme";
    homepage = "https://github.com/reobin/typewritten";
    license = licenses.mit;
    platforms = platforms.all;
    maintainers = [ ];
  };
}
