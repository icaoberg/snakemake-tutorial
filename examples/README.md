# Examples

Worked examples that introduce Snakemake one idea at a time. Work through them in order, then try the [exercises](../exercises/).

Set up the environment as described in the [top-level README](../README.md#getting-started), then activate it:

```bash
conda activate snakemake-tutorial
```

| Example | Topic | What you learn |
|---|---|---|
| [`example0/`](example0/) | Anatomy of a Snakefile | A fully commented tour of `configfile`, wildcards, `expand()`, rule directives, `temp()`, and event handlers |
| [`example1/`](example1/) | Run a workflow and render its DAG | Rules, inputs/outputs, `rule all`, dry runs, rendering the DAG |
| [`example2/`](example2/) | Branching DAGs | Wildcards, `expand()`, merging samples, `--dag` vs. `--rulegraph` vs. Mermaid |
| [`example3/`](example3/) | A data pipeline that produces a plot | Python `run:` blocks, NumPy/pandas, matplotlib |
| [`example4/`](example4/) | Interactive HTML reports | `report(...)`, captions, `snakemake --report` |

Each example has a `README.md` and a `Snakefile`. Examples 1–4 also have a notebook, `exampleN.ipynb`, that runs the workflow and inspects the results.
