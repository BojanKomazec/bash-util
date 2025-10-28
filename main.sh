#!/usr/bin/env bash

# This file contains function tests

 # Get the directory this script lives in (safe even if run from elsewhere)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the log file
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/cli.sh"
source "$SCRIPT_DIR/user_input.sh"

# Enable info, debug and trace logging
VERBOSE=true

test_prompt_user_for_confirmation() {
    local action="test"
    local user_confirmed
    user_confirmed=$(prompt_user_for_confirmation "❓ Do you want to proceed with '$action'?" "n")
    if [[ "$user_confirmed" != "true" ]]; then
        log_warning "Skipping action: $action"
        log_empty_line
        return
    fi
}

test_prompt_user_for_confirmation_inside_while_loop() {
    while read -r action; do
        local user_confirmed
        user_confirmed=$(prompt_user_for_confirmation "❓ Do you want to proceed with '$action'?" "n")
        if [[ "$user_confirmed" == "true" ]]; then
            log_info "Proceeding with action: $action"
            log_empty_line
        else
            log_warning "Skipping action: $action"
            log_empty_line
        fi
    done < <(printf "action1\naction2\naction3\n")
    # done < <(echo -e "action1\naction2\naction3\n") # it passes an extra empty string as an action (!)
}

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

    check_if_command_tool_is_available "ls"
    check_if_command_tool_is_available "nonexistentcommand"

    # test_prompt_user_for_confirmation
    test_prompt_user_for_confirmation_inside_while_loop

    echo "Script completed."
}

main