#!/usr/bin/env bash

if [[ -z "$BASH_UTIL_CONFIG_LOADED" ]]; then
  BASH_UTIL_CONFIG_LOADED=true
fi

if [[ -z "$BASH_UTIL_LOG_LOADED" ]]; then
  # Try local first (for development)
  # Get the directory this script lives in (safe even if run from elsewhere)
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
  echo "SCRIPT_DIR = $SCRIPT_DIR"
  if [[ -f "$SCRIPT_DIR/log.sh" ]]; then
    echo "Using source..."
    source "$SCRIPT_DIR/log.sh"
  else
    echo "Using curl..."
    # Fall back to remote (for imports)
    BASH_UTIL_REPO="${BASH_UTIL_REPO:-BojanKomazec/bash-util}"
    BASH_UTIL_VERSION="${BASH_UTIL_VERSION:-main}"
    source <(curl -fsSL "https://raw.githubusercontent.com/$BASH_UTIL_REPO/refs/heads/$BASH_UTIL_VERSION/log.sh")
  fi
fi

load_env_file() {
    local ENV_FILE="$1"

    # Check if the corresponding .env file
    if [ -f "$ENV_FILE" ]; then
        log_wait "Loading environment variables from $ENV_FILE..."
        source "$ENV_FILE"
    else
        log_error_and_exit "Error: Environment file $ENV_FILE not found!"
    fi
}
