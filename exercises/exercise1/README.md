# Exercise 1 — Solving quadratic equations

Use Snakemake to solve a batch of quadratic equations

$$ax^2 + bx + c = 0 \qquad x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$$

The math is easy on purpose. The point is how to split a problem into **rules** that Snakemake chains together.

## The workflow

```
config.yaml ─► coefficients ─► discriminant ─► roots ─┐
               (one job per equation)                 ├─► summary ─► all
                                                      ┘
```

| Rule | Input | Output |
|---|---|---|
| `coefficients` | `config.yaml` | `data/{equation}.txt` (the line `a b c`) |
| `discriminant` | `data/{equation}.txt` | `results/{equation}/discriminant.txt` |
| `roots` | coefficients + discriminant | `results/{equation}/roots.txt` |
| `summary` | every `roots.txt` | `results/summary.tsv` |

[`config.yaml`](config.yaml) lists three equations, one for each kind of answer:

| Equation | Discriminant | Roots |
|---|---|---|
| `two_real`: x² − 3x + 2 = 0 | 1 (> 0) | 2, 1 |
| `one_real`: x² − 2x + 1 = 0 | 0 | 1, 1 |
| `complex`: x² + 2x + 5 = 0 | −16 (< 0) | −1+2i, −1−2i |

## Steps

1. Read the [`Snakefile`](Snakefile). The `coefficients` rule is finished; use it as your model.
2. Fill in every `TODO`:
   - the `input:` and `output:` of `discriminant`, `roots` and `summary`
   - the formulas for the discriminant and the two roots

   Until every `TODO` is filled in, Snakemake will stop with an error or the results will be wrong.
3. Do a dry run, then look at the plan:

   ```bash
   conda activate snakemake
   cd exercises/exercise1
   snakemake -n -p --cores 1
   ```

   How many jobs of each rule does Snakemake plan? Why?
4. Run it and check the answers against the table above:

   ```bash
   snakemake --cores 1
   cat results/summary.tsv
   ```

5. Draw the DAG:

   ```bash
   snakemake --dag | dot -Tsvg > dag.svg
   ```

## Check your understanding

- Run `snakemake --cores 1` again. Why is there nothing to be done?
- Add a fourth equation to `config.yaml` (try `irrational`: a=1, b=0, c=−2). Which jobs run, and which are skipped?
- Change one coefficient of `two_real`. Which jobs re-run? (`snakemake -n --cores 1` shows you without running anything.)
- Delete `results/one_real/discriminant.txt`. What does Snakemake rebuild?
- How did Snakemake know to run `discriminant` before `roots`? You never told it the order.

## Challenge

What happens if an equation has `a: 0`? Make the workflow handle it, for example by solving the linear equation bx + c = 0 instead.

## Hints

- Inside `input:`/`output:`, the wildcard `{equation}` must appear exactly as in the other rules' file names. That's how Snakemake links them.
- A directive with several named files looks like `name="path",`. In the `run:` block, use `input.name`.
- `expand("results/{equation}/roots.txt", equation=EQUATIONS)` turns one pattern into a list of files.
- `x ** 2` squares a number in Python.

<details>
<summary>Solution</summary>

```python
rule discriminant:
    input:
        "data/{equation}.txt",
    output:
        "results/{equation}/discriminant.txt",
    run:
        ...
        d = b**2 - 4 * a * c
        ...


rule roots:
    input:
        coefficients="data/{equation}.txt",
        discriminant="results/{equation}/discriminant.txt",
    output:
        "results/{equation}/roots.txt",
    run:
        ...
        x1 = (-b + cmath.sqrt(d)) / (2 * a)
        x2 = (-b - cmath.sqrt(d)) / (2 * a)
        ...


rule summary:
    input:
        expand("results/{equation}/roots.txt", equation=EQUATIONS),
    ...
```

Expected `results/summary.tsv`:

```
equation	x1	x2
two_real	2	1
one_real	1	1
complex	-1+2i	-1-2i
```

- The dry run plans 3 jobs each of `coefficients`, `discriminant` and `roots` (one per equation), and 1 each of `summary` and `all`.
- Snakemake works backwards from `results/summary.tsv`. It matches each file a rule needs to the rule whose `output:` pattern produces it, and that sets `{equation}`. Order comes from these file dependencies.
- Adding an equation runs only that equation's three jobs, plus `summary`, because `summary`'s input list changed.
- Changing a coefficient changes the `params` of `coefficients`, so that job re-runs, followed by everything downstream of it for that equation only.

</details>
