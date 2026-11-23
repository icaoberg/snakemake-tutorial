#!/usr/bin/env bash
# Create the conda environment from environment.yaml.
set -euo pipefail

cd "$(dirname "$0")"

ENV_NAME="snakemake-tutorial"

# Prefer mamba if available (faster solver), fall back to conda.
if command -v mamba >/dev/null 2>&1; then
    CONDA="mamba"
elif command -v conda >/dev/null 2>&1; then
    CONDA="conda"
else
    echo "Error: neither mamba nor conda found on PATH." >&2
    exit 1
fi

if "$CONDA" env list | grep -qE "^${ENV_NAME}\s"; then
    echo "Environment '${ENV_NAME}' already exists. Nothing to do."
    echo "Run ./clean.sh first if you want to recreate it."
    exit 0
fi

echo "Creating environment '${ENV_NAME}' with ${CONDA}..."
"$CONDA" env create -f environment.yaml

echo "Done. Activate it with: conda activate ${ENV_NAME}"
