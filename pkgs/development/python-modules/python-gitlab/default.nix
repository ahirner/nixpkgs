{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchPypi,

  # build-system
  setuptools,

  # dependencies
  argcomplete,
  requests,
  requests-toolbelt,
  pyyaml,
}:

buildPythonPackage rec {
  pname = "python-gitlab";
  version = "4.10.0";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    pname = "python_gitlab";
    inherit version;
    hash = "sha256-hvmcGRUIji0lc4F6yov2urXk8S1CsE72st8qu1KNV/0=";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = [
    requests
    requests-toolbelt
  ];

  passthru.optional-dependencies = {
    autocompletion = [ argcomplete ];
    yaml = [ pyyaml ];
  };

  # Tests rely on a gitlab instance on a local docker setup
  doCheck = false;

  pythonImportsCheck = [ "gitlab" ];

  meta = with lib; {
    description = "Interact with GitLab API";
    mainProgram = "gitlab";
    homepage = "https://github.com/python-gitlab/python-gitlab";
    changelog = "https://github.com/python-gitlab/python-gitlab/blob/v${version}/CHANGELOG.md";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
