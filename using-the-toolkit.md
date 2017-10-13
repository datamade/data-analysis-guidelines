# 🛠 Data analysis 101 – Standard toolkit

## Introduction to `pweave`

  - Default parameters
  - File formats (`.pmd` for text (Markdown) output, `ptexw` for LaTex & report output)

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