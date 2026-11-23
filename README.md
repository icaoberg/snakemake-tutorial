# Snakemake Tutorial

A hands-on introduction to [Snakemake](https://snakemake.readthedocs.io/), the Python-based workflow management system. The tutorial is a series of small, self-contained examples. Each one pairs a `Snakefile` with a Jupyter notebook that runs the workflow, inspects its results, and visualizes how the steps connect.

The examples build on each other, from a two-rule "hello world" to a data pipeline that produces a plot and an interactive HTML report.

## Examples

| Example | Topic | What you learn |
|---|---|---|
| [`example1/`](example1/) | Run a workflow and render its DAG | Rules, inputs/outputs, `rule all`, dry runs (`-n`), executing a workflow, rendering the job DAG with Graphviz |
| [`example2/`](example2/) | Branching DAGs, rulegraph and Mermaid | Wildcards, `expand()`, merging multiple samples, comparing `--dag`, `--rulegraph`, and Mermaid output |
| [`example3/`](example3/) | A data pipeline that produces a plot | Python `run:` blocks, generating data with NumPy/pandas, plotting with matplotlib, why re-running is a no-op when outputs are up to date |
| [`example4/`](example4/) | Interactive HTML reports | Marking outputs with `report(...)`, captions and categories, building a self-contained report with `snakemake --report` |

Each example directory contains:

- `Snakefile` — the workflow definition
- `exampleN.ipynb` — a notebook that walks through running and inspecting it
- `example4/report_caption.rst` — the caption shown for the figure in the HTML report

## Requirements

- [conda](https://docs.conda.io/) or [mamba](https://mamba.readthedocs.io/) (mamba is used automatically if available)

All other dependencies, such as Snakemake 8+, JupyterLab, pandas, NumPy, matplotlib, and Graphviz, are listed in [`environment.yaml`](environment.yaml) and installed from `conda-forge` and `bioconda`.

## Getting started

```bash
# 1. Create the conda environment (named "snakemake-tutorial")
./create.sh

# 2. Launch JupyterLab inside that environment
./start.sh
```

Then open any `exampleN/exampleN.ipynb` and make sure its kernel is the `snakemake-tutorial` environment. Work through the examples in order.

To run a workflow without the notebook:

```bash
conda activate snakemake-tutorial
cd example1
snakemake -n -p --cores 1   # dry run: show what would be executed
snakemake --cores 1         # run the workflow
```

## Helper scripts

| Script | Purpose |
|---|---|
| `create.sh` | Creates the `snakemake-tutorial` conda environment from `environment.yaml`. Does nothing if it already exists. |
| `start.sh` | Starts JupyterLab inside the environment. Uses Miniforge's `conda` if a Miniforge install is found (set `MINIFORGE_HOME` to point at a custom location), otherwise the `conda` on your `PATH`. Extra arguments are passed to `jupyter lab`, for example `./start.sh --port 9999`. |
| `clean.sh` | Removes the `snakemake-tutorial` conda environment. |

To rebuild the environment from scratch, run `./clean.sh && ./create.sh`.
