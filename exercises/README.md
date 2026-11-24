# Exercises

Hands-on exercises for practicing what the [examples](../examples/) cover. Work through the examples first, then try these on your own.

Set up the environment as described in the [top-level README](../README.md#getting-started), then activate it:

```bash
conda activate snakemake-tutorial
```

| Exercise | Topic | What you practice |
|---|---|---|
| [`exercise1/`](exercise1/) | Solving quadratic equations | Chaining rules through files, wildcards, `config.yaml`, `expand()`, `run:` blocks, and what re-runs when inputs change |
| [`exercise3/`](exercise3/) | Plotting a parabola | Coefficients from `config.yaml`, an optional `--config title=...` with a default, `--configfile`, plotting with matplotlib, and which rules re-run when a parameter changes |

Each exercise has a `README.md` with instructions and a hidden solution, plus a starter `Snakefile` with `TODO`s to fill in.
