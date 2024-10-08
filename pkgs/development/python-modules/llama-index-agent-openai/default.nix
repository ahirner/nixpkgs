{
  lib,
  buildPythonPackage,
  fetchPypi,
  llama-index-core,
  llama-index-llms-openai,
  poetry-core,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "llama-index-agent-openai";
  version = "0.3.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchPypi {
    pname = "llama_index_agent_openai";
    inherit version;
    hash = "sha256-2t5w6LmHGU16+2kl9yMGDp9JU+sTRADaL81M7t8sPf8=";
  };

  pythonRelaxDeps = [ "llama-index-llms-openai" ];

  build-system = [
    poetry-core
  ];

  dependencies = [
    llama-index-core
    llama-index-llms-openai
  ];

  pythonImportsCheck = [ "llama_index.agent.openai" ];

  meta = with lib; {
    description = "LlamaIndex Agent Integration for OpenAI";
    homepage = "https://github.com/run-llama/llama_index/tree/main/llama-index-integrations/agent/llama-index-agent-openai";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
