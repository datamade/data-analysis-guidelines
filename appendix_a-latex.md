# Appendix A - LaTeX

There is a trove of information online about LaTeX, so I won't write one here.
Instead, here are 15 LaTeX commands, in a table, to get you up and running.

## LaTeX Lightning Round

| command          | description | example |
|------------------|-------------|---|
| [`\documentclass`](https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Document_classes) | specify type of document you're writing | `\documentclass{article}` |
| [`\usepackage`](https://en.wikibooks.org/wiki/A_Brief_Introduction_to_the_LaTeX_Typesetting_Environment/Typesetting:_The_Basics#The_\usepackage_option) | import a package for use in your document (see an "incomplete list" of packages [here](https://en.wikibooks.org/wiki/LaTeX/Package_Reference)) | `\usepackage{amsmath}` |
| [`\include`](https://tex.stackexchange.com/questions/246/when-should-i-use-input-vs-include#250) | assemble content written across multiple files, i.e., in chapters | `\include{chapter-1}` |
| [`\title`](https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Top_matter) | title of your document, styled in large, bold font (like `h1` in HTML) | `\title{Peanut butter and jelly}` |
| [`\author`](https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Top_matter) | you! | `\author{Your name in lights}` |
| [`\section`](https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Sectioning_commands) | title of broad section, styled in medium-sized bold font (like `h2` in HTML) | `\section{The art of PBJ}` |
| [`\subsection`](https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Sectioning_commands) | title of subpart of broad section, styled in bold font (like `h3` in HTML) | `\subsection{Strawberry or grape?}` |
| [`\begin`](https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Global_structure) | directive for beginning something, i.e., `document`, `abstract`, `enumerate` (ordered list), or `itemized` (unordered list) | `\begin{abstract}` |
| [`\end`](https://en.wikibooks.org/wiki/LaTeX/Document_Structure#Global_structure) | directive for ending something, as above | `\end{abstract}` |
| [`\item`](https://en.wikibooks.org/wiki/LaTeX/List_Structures) | markup for items in list | `\begin{enumerate}`<br>`\item Item 1`<br>`\item Item 2`<br>`\end{enumerate}` |
| [`\textbf`](https://www.sharelatex.com/learn/Bold,_italics_and_underlining) | bold text | `\textbf{a very important statement}` |
| [`\textit`](https://www.sharelatex.com/learn/Bold,_italics_and_underlining) | italicized text | `\textit{make your nuance on the nose}` |
| [`\emph`](https://www.sharelatex.com/learn/Bold,_italics_and_underlining) | _emphasized_ text (see link for example) | `\emph{emph is smart italics}` |
| [`\underline`](https://www.sharelatex.com/learn/Bold,_italics_and_underlining) | underlined text | `\underline{please get my point}` |
| [`\footnote`](https://en.wikibooks.org/wiki/LaTeX/Footnotes_and_Margin_Notes#Footnotes) | a footnote | this is text that needs some context. `\footnote{this is context.}` |

## A few more tips

- [Tables](https://en.wikibooks.org/wiki/LaTeX/Tables) and [figures](https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions)
  - **Use [`tabulate`](https://pypi.python.org/pypi/tabulate)** (Python lib) and
  `pweave` to print your data tables to LaTeX format (in `tabulate`, it's
  all-lower 'latex')
  - LaTeX thinks it knows where your tables and figures should be on the page.
  If this vexes you, [take back control](https://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions#Figures).
- [BibTeX](https://www.economics.utoronto.ca/osborne/latex/BIBTEX.HTM) is a
LaTeX package that handles your bibliography for you, given a list of the sources
you used. Click the link for a quick tutorial.
