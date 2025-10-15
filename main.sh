#!/usr/bin/env bash

# This file contains function tests

 # Get the directory this script lives in (safe even if run from elsewhere)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the log file
source "$SCRIPT_DIR/config.sh"

# Enable info, debug and trace logging
VERBOSE=true

main() {
    load_env_file "$SCRIPT_DIR/.env.example"
    log_info "FOO=$FOO"

    log_info "This is an info message."
    log_debug "This is a debug message."
    log_trace "This is a trace message."
    log_warning "This is a warning message."
    log_error "This is an error message."
    log_fatal "This is a fatal message."
    log_success "This is a success message."
    log_wait "This is a wait message."
    log_start "This is a start message."
    log_skip "This is a skip message."

    # Uncomment to test exit on error
    # log_error_and_exit "This is an error message with exit."

    echo "Script completed."
}

main