# Analyzing Data, the DataMade Way

You've [_extracted_ and _transformed_ the data](https://github.com/datamade/data-making-guidelines).
Now it's time to _load_ (analyze) it. Here, you'll find the principles that
inform DataMade's approach to data analysis, as well as the tools and
organizational practices that make it possible.

## Principles

DataMade's approach to data analysis combines [our principles for making data](https://github.com/datamade/data-making-guidelines#basic-principles)
with the basic principles of [literate programming](https://en.wikipedia.org/wiki/Literate_programming).

Namely, data analysis should:

1. be **reproducible** with one command.
2. be conducted using **standard tools**.
3. be kept under **version control**.
4. **prioritize legibility** to other humans.

## Guides

* [Data analysis 001](/setup.md)
  * Setting up your environment
    * [Guide](http://protips.maxmasnick.com/literate-python-setup-with-pweave-and-atom), with some tweaks
    * [Installing LaTeX](http://www.latex-project.org/get/)
      * [GNU/Linux & Windows](http://www.tug.org/texlive/)
      * [OS X](www.tug.org/mactex/)
  * Organizing your analysis
* [Data analysis 101](/using-the-toolkit.md)
  * Using the standard toolkit
    * Introduction to `pweave`
      * Default parameters
      * File formats (`.pmd` for text (Markdown) output, `ptexw` for LaTex & report output)
    * Introduction to `pandas`
      * Reading data
        * `pandas.read_csv` (http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_csv.html)
        * `pandas.read_excel` (http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_excel.html)
        * `pandas.read_sql` (http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_sql.html)
      * Common DataFrame operations
        * Convenience functions / useful attributes
          * `head` / `tail`
          * `describe`
          * `value_counts`
          * `columns`
        * Adding new columns
          * Applying transformations
        * Selecting data
          * `loc` to use DataFrame index `iloc` to use position-based index
          * `df.loc[x, 'attr']` or `df.iloc[x]['attr']` to select an attribute of selected row/s
        * Aggregate functions
          * `axis` arg
          * `groupby`
        * Iterating with `iterrows()`
          * Similar to `enumerate`d `csv.DictReader` in that you get the index and the row, with values accessible via column name
      * Plotting
    * Introduction to `LaTeX`
      * Markup
        * `\documentclass`
        * `\title`
        * `\author`
        * `\section`
        * `\subsection`
        * `\textbf`
        * `\textif`
        * `\underline`
        * `\emph`
        * `\item`
        * `\footnote`
        * `\appendix`
      * Directives
        * `\begin`
          * `\document`
          * `\abstract`
          * `\align`
          * `\description`
          * `\enumerate`
          * `\itemize`
        * `\end`
        * `\usepackage`
        * `\include`
      * Tables and figures
        * Use [`tabulate`](https://pypi.python.org/pypi/tabulate) (Python lib)
        * Placement (LaTeX thinks it's smarter than it is)
      * BibTeX
        * Tutorial [here](https://www.economics.utoronto.ca/osborne/latex/BIBTEX.HTM)
* [Data analysis 201](/multi-part-patterns.md)
  * Patterns for multi-part analysis
  * Producing output in different formats

## Examples

Under construction in the `examples` dir! 👷