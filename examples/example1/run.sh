#!/usr/bin/env bash
# Run this example's Snakemake workflow on a single core.
# Extra arguments are passed to snakemake, e.g. ./run.sh -n -p for a dry run.
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v snakemake >/dev/null 2>&1; then
    echo "snakemake not found. Activate the environment first: conda activate snakemake-tutorial" >&2
    exit 1
fi

snakemake --cores 1 "$@"
