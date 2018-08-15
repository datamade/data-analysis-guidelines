# 🔢 Data analysis 201 - Putting it all together

## Patterns for multi-part analysis

When it comes to data analysis, having it all in one place is great – until it
isn't. If your analysis has sections, consider breaking your master analysis
file into topical subfiles, and stringing them all together when you compile
your report.

Luckily, LaTeX provides not one but two useful functions that support this very
pattern: `\input` and `\include`. Read about the difference between them in
[this well-put answer on the TeX Stack Exchange](https://tex.stackexchange.com/a/250),
and select the one best suited to your needs.

To use `\input` or `\include`, create a `tex` file with the bones of your document.

**`analyses/00-my-analysis.tex`**
```
\documentclass{article}
\title{A cool analysis}
\author{A cool analyst}

\begin{document}

\maketitle

\end{document}
```

Next, conduct your analysis across a series of `ptexw` files. (Need a refresher
on `pweave`, our tool for compiling prose and Python into sweet data nectar?
Check out [our introduction](/using-the-toolkit.md).)

**`analyses/01-part-1.ptexw`**
```
\section*{Part 1}

<<>>=
# some analysis here
@
```

**`analyses/02-part-2.ptexw`**
```
\section*{Part 2}

<<>>=
# yet more analysis here
@
```

As you complete your subfiles, simply `\include` or `\input` them in your master
`tex` file, where the thing to include is the basename of your subfile (that is,
the name of your file, without preceding directories or a trailing file extension).

**`analyses/00-my-analysis.tex`**
```
\documentclass{article}
\title{A cool analysis}
\author{A cool analyst}

\begin{document}

\maketitle

\include{01-part-1}
\include{02-part-2}

\end{document}
```

When you're ready to produce your final report, compile your `pweave` files –

```bash
pweave -o analysis/01-part-1.tex analysis/01-part-1.ptexw
pweave -o analysis/02-part-2.tex analysis/02-part-2.ptexw
```

– then, run `pdflatex`.

```bash
cd analyses && pdflatex 00-my-analysis.tex
```

It's as simple as that!

Using [Make](https://github.com/datamade/data-making-guidelines)? A Makefile
to compile reports organized in the above fashion might look like this:


```Make
# Define a variable containing paths/to/each of your subfiles.
subsections=analyses/01-part-1.tex analyses/02-part-2.tex

# Set a phony target, all, to make your final report.
all : analyses/my-analysis.pdf

# Set a phony target to delete generated files. (pdflatex emits a bunch.)
clean :
    rm analyses/*.pdf analyses/*.aux analyses/*.log analyses/0[1-9]*.tex analyses/figures/*

# Define a recipe for compiling your final report that depends on your master
# tex file, as well as each subsection.
analyses/time-tracking.pdf : analyses/00-my-analysis.tex $(subsections)
    cd analyses && \
    pdflatex $(notdir $<)

# Define a wildcard recipe that compiles your pweave files to tex files, i.e.,
# the dependencies of your final report.
analyses/%.tex : analyses/%.ptexw
    pweave -o $@ $<
```
