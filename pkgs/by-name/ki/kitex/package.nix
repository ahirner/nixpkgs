{ buildGoModule
, fetchFromGitHub
, lib
, testers
, kitex
}:

buildGoModule rec {
  pname = "kitex";
  version = "0.10.3";

  src = fetchFromGitHub {
    owner = "cloudwego";
    repo = "kitex";
    rev = "v${version}";
    hash = "sha256-aSvN8yjCHxhzLHwQovWFMaoD6ljy8aikxI7jUoeRvDs=";
  };

  vendorHash = "sha256-nscMcJGFZ1YPPynTV+Mp8tXndtlIcszDZm36zMbNBYs=";

  subPackages = [ "tool/cmd/kitex" ];

  ldflags = [ "-s" "-w" ];

  postInstall = ''
    ln -s $out/bin/kitex $out/bin/protoc-gen-kitex
    ln -s $out/bin/kitex $out/bin/thrift-gen-kitex
  '';

  passthru.tests.version = testers.testVersion {
    package = kitex;
    version = "v${version}";
  };

  meta = with lib;  {
    description = "A high-performance and strong-extensibility Golang RPC framework";
    homepage = "https://github.com/cloudwego/kitex";
    license = licenses.asl20;
    maintainers = with maintainers; [ aaronjheng ];
    mainProgram = "kitex";
  };
}
