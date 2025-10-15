#!/bin/bash
# cli.sh
# General helper functions for command-line tools.

if [[ -z "$BASH_UTIL_LOG_LOADED" ]]; then
  # Try local first (for development)
  # Get the directory this script lives in (safe even if run from elsewhere)
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"

  if [[ -f "$SCRIPT_DIR/log.sh" ]]; then
    # If this file is loaded from this repo, it can use source to load its dependencies.
    source "$SCRIPT_DIR/log.sh"
  else
    # If this file is loaded from another repo, it needs to use curl to load its dependencies.
    BASH_UTIL_REPO="${BASH_UTIL_REPO:-BojanKomazec/bash-util}"
    BASH_UTIL_VERSION="${BASH_UTIL_VERSION:-main}"
    source <(curl -fsSL "https://raw.githubusercontent.com/$BASH_UTIL_REPO/refs/heads/$BASH_UTIL_VERSION/log.sh")
  fi
fi

# Check if a command-line tool is available
check_if_command_tool_is_available() {
  local cmd=$1
  if ! command -v "$cmd" &> /dev/null; then
    log_error "Command '$cmd' not found. Please install it first."
    return 1
  fi
  return 0
}
