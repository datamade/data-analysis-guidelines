# 🛠 Data analysis 101 – Standard toolkit

## Introduction to `pweave`

### Weaving from the command line

[Installing `pweave`](/setup#install-pweave) gives you a fancy new command
with which you can compile blended text, markup, and code to your desired
format, like so:

```bash
pweave myfile.mdw
```

An unmodified `pweave` command will guess what output you want based on your
input and pipe its results into a file of that type with the same name as your
input file.

At DataMade, our analysis is generally in the form of a memo or a report
styled with LaTeX and compiled to `pdf`. `pweave` weaves `ptexw` files –
that's LaTeX markup with noweb code chunks – to `tex` files by default.
We can then use `pdflatex` to arrive at our PDF.

```
\begin{document}

Here is \textbf{my report}!

<<>>=
print('This is a noweb code chunk!')
@

\end{document}
```
_An example `ptexw` file_

If you need to override `pweave` defaults, [you can](http://mpastell.com/pweave/script.html).
Here are the options you're like to use most often:

- `-f` or `--format=` - Desired [output format](http://mpastell.com/pweave/formats.html)
  (See [`LaTeX.mk`](/examples/LaTeX.mk) for this option in action)
- `-o` or `--output=` - Name of output file

Need to compile to plaintext? Start with an `mdw` file. You can input plain
old text, `noweb` codeblocks, and (optionally) HTML markup (use `-f html` to
compile HTML) or markdown (use `-f markdown` to compile markdown, or `-f md2html`
to compile HTML).

### Default parameters

You can [configure `pweave` code chunks](http://mpastell.com/pweave/chunks.html)
to behave just about any way you'd like by passing options between the angled
brackets `<<>>=` at the start.

```python
<< echo = False, caption = 'Output from a code chunk' >>=
for i in range(10):
    print(i)
@
```

Sometimes, you want to use the same options for your entire document. For example,
we tend to omit source code from the compiled analysis and render code chunk output
as plaintext rather than `\verbatim`.

To set global code chunk options, `update` the appropriate options in `pweave.rcParams`,
like so:

```python
<< echo = False >>=
import pweave

pweave.rcParams["chunk"]["defaultoptions"].update({
    'results' : 'raw',
    'echo': False,
})
@
```

## Introduction to `pandas`

  - Reading data
    - `pandas.read_csv` (http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_csv.html)
    - `pandas.read_excel` (http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_excel.html)
    - `pandas.read_sql` (http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_sql.html)
  - Common DataFrame operations
    - Convenience functions / useful attributes
      - `head` / `tail`
      - `describe`
      - `value_counts`
      - `columns`
    - Adding new columns
      - Applying transformations
    - Selecting data
      - `loc` to use DataFrame index `iloc` to use position-based index
      - `df.loc[x, 'attr']` or `df.iloc[x]['attr']` to select an attribute of selected row/s
    - Aggregate functions
      - `axis` arg
      - `groupby`
    - Iterating with `iterrows()`
      - Similar to `enumerate`d `csv.DictReader` in that you get the index and the row, with values accessible via column name
  - Plotting

## Introduction to `LaTeX`

  - [DataMade styles](https://github.com/datamade/datamade-latex) (private repo)
  - Markup
    - `\documentclass`
    - `\title`
    - `\author`
    - `\section`
    - `\subsection`
    - `\textbf`
    - `\textif`
    - `\underline`
    - `\emph`
    - `\item`
    - `\footnote`
    - `\appendix`
  - Directives
    - `\begin`
      - `\document`
      - `\abstract`
      - `\align`
      - `\description`
      - `\enumerate`
      - `\itemize`
    - `\end`
    - `\usepackage`
    - `\include`
  - Tables and figures
    - Use [`tabulate`](https://pypi.python.org/pypi/tabulate) (Python lib)
    - Placement (LaTeX thinks it's smarter than it is)
  - BibTeX
    - Tutorial [here](https://www.economics.utoronto.ca/osborne/latex/BIBTEX.HTM)
