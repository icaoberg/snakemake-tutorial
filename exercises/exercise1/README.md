# Exercise 1 — A single rule

The smallest possible Snakemake workflow: one rule that creates one file.

## Goal

Complete the [`Snakefile`](Snakefile) in this directory so that it has a single rule named `hello` that creates `hello.txt` containing:

```
Hello, Snakemake!
```

## Steps

1. Open `Snakefile` and fill in the two `TODO`s:
   - **`output:`** — the name of the file the rule creates, as a quoted string.
   - **`shell:`** — a command that writes the greeting into that file. Use `{output}` instead of typing the filename again.
2. Do a dry run to see what Snakemake plans to do:

   ```bash
   conda activate snakemake
   cd exercises/exercise1
   snakemake -n -p --cores 1
   ```

3. Run it for real and check the result:

   ```bash
   snakemake --cores 1
   cat hello.txt
   ```

## Check your understanding

- Run `snakemake --cores 1` a second time. Why does Snakemake say there is nothing to be done?
- Delete `hello.txt` and run again. What happens?
- This rule has no `input:`. Why is that allowed?

## Hints

- Every value in a rule directive is a quoted string followed by a comma, for example `"hello.txt",`.
- `echo 'some text' > file` writes text into a file in the shell.
- [Example 1](../../examples/example1/Snakefile) has a rule, `create`, that is almost identical.

<details>
<summary>Solution</summary>

```python
rule hello:
    output:
        "hello.txt",
    shell:
        "echo 'Hello, Snakemake!' > {output}"
```

- A rule needs no input when it creates something from scratch.
- On the second run, `hello.txt` already exists and nothing it depends on has changed, so there is nothing to do.
- After you delete `hello.txt`, Snakemake notices the missing output and runs the rule again.

</details>
