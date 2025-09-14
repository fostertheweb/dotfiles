#!/usr/bin/env zsh
set -euo pipefail

eval "$(op signin)"

typeset -A OP_CREDENTIALS=(
  ANTHROPTIC_API_KEY "Private/API Credentials/Anthropic"
  CONTEXT7_API_KEY "Private/API Credentials/Context7"
  DEEPSEEK_API_KEY "Private/API Credentials/DeepSeek"
  GEMINI_API_KEY "Private/API Credentials/Gemini"
  OPENAI_API_KEY "Private/API Credentials/OpenAI"
  OPENROUTER_API_KEY "Private/API Credentials/OpenRouter"
  GITHUB_PERSONAL_ACCESS_TOKEN "Private/API Credentials/GitHub MCP"
)

ENV_FILE="${HOME}/.api-credentials"
: >| "$ENV_FILE"

for VAR in "${(@k)OP_CREDENTIALS}"; do
  FIELD_PATH="${OP_CREDENTIALS[$VAR]}"
  VALUE=$(op read "op://${FIELD_PATH}")
  echo "export ${VAR}=${VALUE:q}" >>| "$ENV_FILE"
done

chmod 600 "$ENV_FILE"

