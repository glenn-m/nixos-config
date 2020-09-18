{ stdenv, buildGoPackage, fetchFromGitHub }:

buildGoPackage rec {
  name = "grafana-loki-${version}";
  version = "20190405";

  goPackagePath = "github.com/grafana/loki";

  src = fetchFromGitHub {
    owner = "grafana";
    repo = "loki";
    sha256 = "1yic20lkq9wf0lanj96m02szd19hxwzs4f0mvai1rwvn82hbxd6i";
  };

  meta = with stdenv.lib; {
    description = "Loki Logging for Grafana";
    homepage = https://github.com/grafana/loki;
    license = licenses.mit;
    maintainers = with maintainers; [ glenn-m ];
    platforms = platforms.unix;
  };
}
