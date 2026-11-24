# Example 0: Anatomy of a Snakefile

Before running bigger pipelines, it helps to know what each part of a `Snakefile` does. This example is a small, fully commented workflow that uses the components you will see most often. Open [`Snakefile`](Snakefile) and read it from top to bottom; every section is explained inline.

## What the workflow does

For each sample listed in [`config.yaml`](config.yaml) (`alpha`, `beta`, `gamma`), it:

1. **`make_sample`**: writes a one-line text file `data/{sample}.txt`
2. **`count_words`**: counts the words in that file and writes `results/counts/{sample}.txt`
3. **`summarize`**: merges all counts into one table, `results/summary.txt`

```
make_sample (alpha) ─► count_words (alpha) ─┐
make_sample (beta)  ─► count_words (beta)  ─┼─► summarize ─► all
make_sample (gamma) ─► count_words (gamma) ─┘
```

## Components covered

| Component | Where in the Snakefile | What it does |
|---|---|---|
| `configfile:` and `config` | top of file | Loads `config.yaml` into a Python dict so parameters live outside the code |
| Plain Python | `SAMPLES`, `greeting_for()` | Any Python outside a rule runs once when the file is parsed |
| `wildcard_constraints:` | global | Restricts what a wildcard may match (regex) to avoid ambiguity |
| `rule all` | first rule | The default target. Lists the final files; Snakemake works backwards from them |
| `input:` / `output:` | every rule | The files a rule needs and produces. Matching names link rules into a DAG |
| Wildcards `{sample}` | `make_sample`, `count_words` | One rule definition becomes one job per sample |
| `expand()` | `summarize` | Turns a pattern plus a list into many file names, gathering all samples |
| `params:` | `make_sample` | Non-file values for the command, optionally computed per job by a function |
| `log:` | every rule | Where a job's messages go. Kept even when the job fails |
| `benchmark:` | `count_words` | Records runtime and memory for each job as a TSV |
| `threads:` / `resources:` | `count_words` | CPU cores and other named limits the scheduler respects |
| `message:` | `make_sample`, `count_words` | A readable line printed when the job starts |
| `shell:` | `make_sample`, `count_words` | A shell command with `{input}`, `{output}`, and similar placeholders |
| `run:` | `summarize` | A Python block used instead of a shell command |
| `temp()` | `make_sample` output | Marks an intermediate file for automatic deletion once it is no longer needed |
| `onstart:` / `onsuccess:` / `onerror:` | bottom of file | Python run at workflow start, after success, or on failure |

## Running it

From the repository root, inside the `snakemake` environment (see the [top-level README](../../README.md)):

```bash
conda activate snakemake
cd examples/example0

snakemake -n -p --cores 1     # dry run: show the jobs and commands, run nothing
snakemake --cores 1           # run the workflow
cat results/summary.txt       # look at the result
```

Expected output:

```
sample	words
alpha	4
beta	4
gamma	4
```

## Things to try

- **Run it again.** Snakemake reports `Nothing to be done` because every output is newer than its inputs.
- **Override the config.** `snakemake --cores 1 --config greeting="hi"` re-runs the jobs whose `params` changed. The word counts drop to 2.
- **Add a sample.** Add `delta` to `samples:` in `config.yaml` and run again. Only the new sample's jobs, plus `summarize`, run.
- **Ask for a single file.** `snakemake --cores 1 results/counts/beta.txt` builds just that target and the steps it depends on.
- **See `temp()` at work.** After a run, `data/` is gone. Snakemake deleted those intermediate files once `count_words` finished.
- **Inspect the extras.** Look at `logs/` and `benchmarks/count_words/` to see what `log:` and `benchmark:` produce.
- **Draw the DAG.** `snakemake --dag | dot -Tpng > dag.png` (covered in more detail in [example1](../example1/)).

## Files

| File | Purpose |
|---|---|
| `Snakefile` | The commented workflow |
| `config.yaml` | Sample names and the greeting text, read via `configfile:` |

Generated on a run: `results/`, `logs/`, `benchmarks/`, and Snakemake's own bookkeeping in `.snakemake/`.

To start over, delete them:

```bash
rm -rf results logs benchmarks .snakemake
```
