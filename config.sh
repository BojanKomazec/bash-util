# Get the directory this script lives in (safe even if run from elsewhere)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the log file
source "$SCRIPT_DIR/log.sh"


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
