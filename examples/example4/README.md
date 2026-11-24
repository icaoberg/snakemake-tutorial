# Example 4 — Interactive HTML reports

The same data-and-plot pipeline as [example 3](../example3/), with the figure marked for a Snakemake report:

```
generate (data.csv) ─► plot (histogram.png) ─► all
```

```python
output:
    report("histogram.png", caption="report_caption.rst", category="Figures"),
```

`report(...)` tells Snakemake to include the file in the HTML report, with the caption from [`report_caption.rst`](report_caption.rst), under the category "Figures".

## Run it

```bash
conda activate snakemake-tutorial
cd examples/example4
snakemake --cores 1
snakemake --report report.html    # a single self-contained HTML file
```

Open `report.html` in a browser to see the figure, its caption, the workflow graph, and run-time statistics. Or open [`example4.ipynb`](example4.ipynb).

## Files

| File | Purpose |
|---|---|
| [`Snakefile`](Snakefile) | The workflow |
| [`report_caption.rst`](report_caption.rst) | Caption for the figure in the report |
| [`example4.ipynb`](example4.ipynb) | Notebook walk-through |
