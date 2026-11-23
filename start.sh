#!/usr/bin/env bash
# Start JupyterLab inside the conda environment, if it exists.
set -euo pipefail

cd "$(dirname "$0")"

ENV_NAME="snakemake-tutorial"

if command -v mamba >/dev/null 2>&1; then
    CONDA="mamba"
elif command -v conda >/dev/null 2>&1; then
    CONDA="conda"
else
    echo "Error: neither mamba nor conda found on PATH." >&2
    exit 1
fi

if ! "$CONDA" env list | grep -qE "^${ENV_NAME}\s"; then
    echo "Error: environment '${ENV_NAME}' does not exist." >&2
    echo "Create it first with: ./create.sh" >&2
    exit 1
fi

echo "Starting JupyterLab in '${ENV_NAME}'..."
exec conda run --no-capture-output -n "${ENV_NAME}" jupyter lab "$@"
