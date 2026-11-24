# Exercise 3 — Plotting a parabola

Build a two-rule workflow that plots the parabola

$$y = ax^2 + bx + c$$

The coefficients `a`, `b`, `c` are inputs to the workflow, and so is an optional plot title. If no title is given, the plot is titled **"This is a parabola"**.

## The workflow

```
config.yaml ─► points ─► plot ─► all
               results/points.csv   results/parabola.png
```

| Rule | Input | Output | Parameters |
|---|---|---|---|
| `points` | — | `results/points.csv` | `a`, `b`, `c`, `xmin`, `xmax`, `points` |
| `plot` | `results/points.csv` | `results/parabola.png` | `title` (default `"This is a parabola"`) |

[`config.yaml`](config.yaml) sets a = 1, b = −2, c = −3, which crosses the x axis at x = −1 and x = 3 and has its lowest point at (1, −4).

## Steps

1. Fill in every `TODO` in the [`Snakefile`](Snakefile):
   - `points`: read `a`, `b`, `c` from `config` into `params`, and compute `y`.
   - `plot`: set its `input:`, and set `params.title` to `config["title"]` if it exists, otherwise `DEFAULT_TITLE`.

   Until every `TODO` is filled in, Snakemake will stop with an error or the results will be wrong.
2. Dry run, then run:

   ```bash
   conda activate snakemake-tutorial
   cd exercises/exercise3
   snakemake -n -p --cores 1
   snakemake --cores 1
   ```

3. Open `results/parabola.png`. Is the title "This is a parabola"? Does the curve cross the x axis at −1 and 3?
4. Give it your own title from the command line:

   ```bash
   snakemake --cores 1 --config title="My first parabola"
   ```

5. Change the coefficients without editing `config.yaml`. Create `upside_down.yaml`:

   ```yaml
   a: -0.5
   b: 1
   c: 4
   title: "An upside-down parabola"
   ```

   and run:

   ```bash
   snakemake --cores 1 --configfile upside_down.yaml
   ```

   Values in `upside_down.yaml` override the same keys in `config.yaml`. Keys it doesn't mention, such as `xmin`, keep their values from `config.yaml`.

## Check your understanding

- In step 4 you changed only the title. Which rules re-ran, and why didn't `points` re-run?
- In step 5 you changed the coefficients. Which rules re-ran this time?
- Run the same command twice. Why does the second run do nothing?
- What happens if you remove `xmin` from `config.yaml`? When does Snakemake report the error?

## Challenge

- Mark the vertex, at x = −b / 2a, on the plot.
- Let `--config color=red` change the line color, with a sensible default.

## Hints

- Values in `config.yaml` are available as `config["a"]`, `config["b"]`, and so on.
- `config.get("title", DEFAULT_TITLE)` returns the title if it is set and the default otherwise.
- NumPy arrays support arithmetic directly: `params.a * x**2` squares every element of `x`.
- Why not `--config a=2`? Snakemake only accepts `--config` keys that are at least two characters long, so single-letter keys like `a` must come from a config file. That's why step 5 uses `--configfile`.

<details>
<summary>Solution</summary>

```python
rule points:
    output:
        "results/points.csv",
    params:
        a=config["a"],
        b=config["b"],
        c=config["c"],
        ...
    run:
        ...
        y = params.a * x**2 + params.b * x + params.c
        ...


rule plot:
    input:
        "results/points.csv",
    output:
        "results/parabola.png",
    params:
        title=config.get("title", DEFAULT_TITLE),
        ...
```

- Changing only the title changes the `params` of `plot`, so only `plot` (and `all`) re-run. `points.csv` doesn't depend on the title, so it is reused.
- Changing `a`, `b` or `c` changes the `params` of `points`, so `points` re-runs, and then `plot` re-runs because its input changed.
- With nothing changed, every output is newer than its inputs and has the same parameters, so there is nothing to do.
- `config["xmin"]` is read when Snakemake parses the Snakefile, so the workflow fails with a `KeyError` before any job runs.

</details>
