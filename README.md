# Snakemake Tutorial

A hands-on introduction to [Snakemake](https://snakemake.readthedocs.io/), the Python-based workflow management system. The tutorial is a series of small, self-contained examples. Each one pairs a `Snakefile` with a Jupyter notebook that runs the workflow, inspects its results, and visualizes how the steps connect.

The examples build on each other, from a two-rule "hello world" to a data pipeline that produces a plot and an interactive HTML report.

New to Snakemake? Start with the [Introduction](Introduction.md), which explains what Snakemake does, how workflows differ from pipelines, and why workflows are drawn as DAGs.

## Repository layout

```
.
├── Introduction.md      # concepts: what Snakemake does, workflows vs. pipelines, DAGs
├── environment.yaml     # conda environment definition
├── create.sh            # create the conda environment
├── start.sh             # launch JupyterLab in the environment
├── clean.sh             # remove the conda environment
├── examples/            # worked examples, example0–example4
└── exercises/           # hands-on exercises to try on your own
```

## Examples

All examples live in the [`examples/`](examples/) directory.

| Example | Topic | What you learn |
|---|---|---|
| [`example0/`](examples/example0/) | Anatomy of a Snakefile | A fully commented tour of `configfile`, wildcards, `expand()`, rule directives (`params`, `log`, `benchmark`, `threads`, `resources`, `message`, `shell`/`run`), `temp()`, and event handlers |
| [`example1/`](examples/example1/) | Run a workflow and render its DAG | Rules, inputs/outputs, `rule all`, dry runs (`-n`), executing a workflow, rendering the job DAG with Graphviz |
| [`example2/`](examples/example2/) | Branching DAGs, rulegraph and Mermaid | Wildcards, `expand()`, merging multiple samples, comparing `--dag`, `--rulegraph`, and Mermaid output |
| [`example3/`](examples/example3/) | A data pipeline that produces a plot | Python `run:` blocks, generating data with NumPy/pandas, plotting with matplotlib, why re-running is a no-op when outputs are up to date |
| [`example4/`](examples/example4/) | Interactive HTML reports | Marking outputs with `report(...)`, captions and categories, building a self-contained report with `snakemake --report` |

Each example directory contains:

- `Snakefile` — the workflow definition
- `exampleN.ipynb` — a notebook that walks through running and inspecting it (examples 1–4 only)
- `example0/` has no notebook; instead it includes a `README.md` explaining the annotated `Snakefile` and a `config.yaml` it reads
- `example4/report_caption.rst` — the caption shown for the figure in the HTML report

## Exercises

The [`exercises/`](exercises/) directory is for hands-on exercises that build on the examples.

## Requirements

- [conda](https://docs.conda.io/), ideally from [Miniforge](https://github.com/conda-forge/miniforge). `create.sh` always uses `conda` to build the environment, even if [mamba](https://mamba.readthedocs.io/) is installed.

All other dependencies, such as Snakemake 8+, JupyterLab, pandas, NumPy, matplotlib, and Graphviz, are listed in [`environment.yaml`](environment.yaml) and installed from `conda-forge` and `bioconda`.

## Getting started

```bash
# 1. Create the conda environment (named "snakemake")
./create.sh

# 2. Launch JupyterLab inside that environment
./start.sh
```

Then open any `examples/exampleN/exampleN.ipynb` and make sure its kernel is the `snakemake` environment. Work through the examples in order.

To run a workflow without the notebook:

```bash
conda activate snakemake
cd examples/example1
snakemake -n -p --cores 1   # dry run: show what would be executed
snakemake --cores 1         # run the workflow
```

## Helper scripts

| Script | Purpose |
|---|---|
| `create.sh` | Creates the `snakemake` conda environment from `environment.yaml` using `conda` (never `mamba`). Does nothing if the environment already exists. |
| `start.sh` | Starts JupyterLab inside the environment. Uses Miniforge's `conda` if a Miniforge install is found (set `MINIFORGE_HOME` to point at a custom location), otherwise the `conda` on your `PATH`. Extra arguments are passed to `jupyter lab`, for example `./start.sh --port 9999`. |
| `clean.sh` | Removes the `snakemake` conda environment. |

To rebuild the environment from scratch, run `./clean.sh && ./create.sh`.
