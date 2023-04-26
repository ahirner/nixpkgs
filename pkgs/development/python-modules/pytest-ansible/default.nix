{ lib
, buildPythonPackage
, fetchFromGitHub
, ansible-core
, coreutils
, coverage
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pytest-ansible";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "ansible";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-kxOp7ScpIIzEbM4VQa+3ByHzkPS8pzdYq82rggF9Fpk=";
  };

  postPatch = ''
    substituteInPlace tests/conftest.py inventory --replace '/usr/bin/env' '${coreutils}/bin/env'
  '';

  nativeCheckInputs =  [ pytestCheckHook coverage ];
  propagatedBuildInputs = [ ansible-core ];

  format = "pyproject";

  preCheck = "export HOME=$TMPDIR";
  pytestFlagsArray = [ "tests/" ];
  disabledTests = [
    # Host unreachable in the inventory
    "test_become"
    # [Errno -3] Temporary failure in name resolution
    "test_connection_failure_v2"
    "test_connection_failure_extra_inventory_v2"
  ];

  meta = with lib; {
    homepage = "https://github.com/jlaska/pytest-ansible";
    description = "Plugin for py.test to simplify calling ansible modules from tests or fixtures";
    license = licenses.mit;
    maintainers = [ maintainers.costrouc ];
  };
}
