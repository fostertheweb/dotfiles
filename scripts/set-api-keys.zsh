#!/usr/bin/env zsh
set -euo pipefail

eval "$(op signin)"

typeset -A OP_CREDENTIALS=(
  ANTHROPTIC_API_KEY "Private/API Credentials/Anthropic"
  OPENAI_API_KEY "Private/API Credentials/OpenAI"
  DEEPSEEK_API_KEY "Private/API Credentials/DeepSeek"
  OPENROUTER_API_KEY "Private/API Credentials/OpenRouter"
)

ENV_FILE="${HOME}/.api-credentials"
: >| "$ENV_FILE"

for VAR in "${(@k)OP_CREDENTIALS}"; do
  FIELD_PATH="${OP_CREDENTIALS[$VAR]}"
  VALUE=$(op read "op://${FIELD_PATH}")
  echo "export ${VAR}=${VALUE:q}" >>| "$ENV_FILE"
done

chmod 600 "$ENV_FILE"

