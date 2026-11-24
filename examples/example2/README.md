# Example 2 — Branching DAGs, rulegraph and Mermaid

Two independent samples are created and then merged:

```
make_sample (a) ─┐
                 ├─► merge (merged.txt) ─► all
make_sample (b) ─┘
```

- `make_sample` uses the wildcard `{sample}`: one rule, one job per sample (`sample_a.txt`, `sample_b.txt`).
- `merge` uses `expand("sample_{sample}.txt", sample=SAMPLES)` to wait for every sample.
- The two `make_sample` jobs don't depend on each other, so with `--cores 2` they can run in parallel.

## Run it

```bash
conda activate snakemake-tutorial
cd examples/example2
snakemake -n -p --cores 1
snakemake --cores 2
cat merged.txt

snakemake --dag | dot -Tsvg > dag.svg             # one node per job
snakemake --rulegraph | dot -Tsvg > rulegraph.svg # one node per rule
snakemake --dag mermaid-js                        # the DAG as Mermaid text
```

Or open [`example2.ipynb`](example2.ipynb) to compare the three views side by side.

## Files

| File | Purpose |
|---|---|
| [`Snakefile`](Snakefile) | The workflow |
| [`example2.ipynb`](example2.ipynb) | Notebook walk-through |
