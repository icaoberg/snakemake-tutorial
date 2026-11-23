#!/usr/bin/env bash
# Start JupyterLab inside the conda environment, if it exists.
# Uses Miniforge's conda if a Miniforge install is found, otherwise
# falls back to whatever conda is on PATH.
set -euo pipefail

cd "$(dirname "$0")"

ENV_NAME="snakemake-tutorial"

# Common Miniforge install locations. Set MINIFORGE_HOME to override.
MINIFORGE_CANDIDATES=(
    "${MINIFORGE_HOME:-}"
    "$HOME/miniforge3"
    "$HOME/miniforge"
    "/opt/miniforge3"
    "/opt/miniforge"
    "/opt/homebrew/Caskroom/miniforge/base"
    "/usr/local/Caskroom/miniforge/base"
)

CONDA=""
for base in "${MINIFORGE_CANDIDATES[@]}"; do
    if [[ -n "$base" && -x "$base/bin/conda" ]]; then
        CONDA="$base/bin/conda"
        echo "Using Miniforge at ${base}"
        break
    fi
done

if [[ -z "$CONDA" ]]; then
    if command -v conda >/dev/null 2>&1; then
        CONDA="$(command -v conda)"
        echo "Miniforge not found; using conda at ${CONDA}"
    elif [[ -n "${CONDA_EXE:-}" && -x "${CONDA_EXE}" ]]; then
        CONDA="${CONDA_EXE}"
        echo "Miniforge not found; using conda at ${CONDA}"
    else
        echo "Error: neither Miniforge nor conda found." >&2
        exit 1
    fi
fi

if ! "$CONDA" env list | grep -qE "^${ENV_NAME}\s"; then
    echo "Error: environment '${ENV_NAME}' does not exist." >&2
    echo "Create it first with: ./create.sh" >&2
    exit 1
fi

echo "Starting JupyterLab in '${ENV_NAME}'..."
exec "$CONDA" run --no-capture-output -n "${ENV_NAME}" jupyter lab "$@"
