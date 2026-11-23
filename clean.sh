#!/usr/bin/env bash
# Remove the conda environment.
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
    echo "Environment '${ENV_NAME}' does not exist. Nothing to do."
    exit 0
fi

echo "Removing environment '${ENV_NAME}'..."
"$CONDA" env remove -n "${ENV_NAME}" -y

echo "Done."
