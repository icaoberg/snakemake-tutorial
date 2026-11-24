# Example 3 — A data pipeline that produces a plot

```
generate (data.csv) ─► plot (river.png) ─► leaf
```

- `generate` uses a Python `run:` block to draw 1,000 random numbers with NumPy (fixed seed 42) and save them with pandas.
- `plot` draws their histogram with matplotlib and saves `river.png`.
- The target rule is called `leaf` instead of `all`. Snakemake doesn't care about the name; the first rule in the file is the default target.

## Run it

```bash
conda activate snakemake
cd examples/example3
snakemake -n -p --cores 1
snakemake --cores 1
snakemake --cores 1    # nothing to do: every output is up to date
```

Or open [`example3.ipynb`](example3.ipynb), which also displays the plot.

## Files

| File | Purpose |
|---|---|
| [`Snakefile`](Snakefile) | The workflow |
| [`example3.ipynb`](example3.ipynb) | Notebook walk-through |
