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
# Make sure to hide this cell with "echo = False"!
import pweave

pweave.rcParams["chunk"]["defaultoptions"].update({
    'results' : 'raw',
    'echo': False,
})
@
```

## Introduction to `pandas`



### DataFrames

`pandas` provides really useful convenienience functions for reading data
into their fundamental data type, the [`DataFrame`](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.html).

For CSV files, use [`pandas.read_csv`](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_csv.html).


```python
csv = pd.read_csv('examples/data/cpl-wifi.csv')
```



If you've got a database, [`pandas.read_sql`](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.read_sql.html)
accepts a table name or SQL query and a database connection, and returns the
table data or query result as a DataFrame.


```python
table = pd.read_sql('wifi', conn)
```



Sneak a peek at your data with `head`...


```python
csv.head()
```

```
cumulative_number_of_sessions     month  number_of_sessions  year
0                          22263   January               22263  2011
1                          41920  February               19657  2011
2                          66426     March               24506  2011
3                          90424     April               23998  2011
4                         113666       May               23242  2011
```



...and/or `tail`.


```python
table.tail()
```

```
cumulative_number_of_sessions      month  number_of_sessions  year
43                        4311589     August              267902  2014
44                        4591246  September              279657  2014
45                        4892338    October              301092  2014
46                        5157545   November              265207  2014
47                        5422163  December               264618  2014
```



Inherited a file or database with horrid column names? Rename them by setting
`DataFrame.columns` equal to a list of new labels for each column...


```python
# Given a DataFrame with columns ['This is a horrible col', 'Here is more BAD DATA!!!', 'FOIA AWAY']
df.columns = ['good_column', 'better_column', 'best_column']
```



...or change a few particularly egregious columns with [`DataFrame.rename`](http://pandas.pydata.org/pandas-docs/stable/generated/pandas.DataFrame.rename.html#pandas.DataFrame.rename).


```python
df.rename({'The WORST COLUnnfdm OF ever time': 'sensible_column'}, inplace=True)
```



### Selecting data

Select a column or columns with a column name...


```python
table['cumulative_number_of_sessions'].head()
```

```
0     22263
1     41920
2     66426
3     90424
4    113666
Name: cumulative_number_of_sessions, dtype: int64
```



...or array of column names.


```python
table[['month', 'year', 'number_of_sessions']].head()
```

```
month  year  number_of_sessions
0   January  2011               22263
1  February  2011               19657
2     March  2011               24506
3     April  2011               23998
4       May  2011               23242
```



You can use `DataFrame.loc` to select rows meeting a given condition...


```python
table.loc[table['number_of_sessions'] > 200000].head()
```

```
cumulative_number_of_sessions  month  number_of_sessions  year
38                        3005168  March              239094  2014
39                        3261318  April              256150  2014
40                        3504247    May              242929  2014
41                        3759587   June              255340  2014
42                        4043687   July              284100  2014
```



...or you can give your DataFrame a custom index...


```python
# Note that indices need not be unique nor numeric!
indexed_table = table.set_index('month')
indexed_table.head(3)
```

```
cumulative_number_of_sessions  number_of_sessions  year
month
January                           22263               22263  2011
February                          41920               19657  2011
March                             66426               24506  2011
```



...then use `DataFrame.loc` to select rows with the given index value...


```python
indexed_table.loc['January']
```

```
cumulative_number_of_sessions  number_of_sessions  year
month
January                          22263               22263  2011
January                         367319               33089  2012
January                         919469               50927  2013
January                        2570635              195108  2014
```



...or to select attributes with the given index value and a column name.


```python
indexed_table.loc['February', 'cumulative_number_of_sessions']
```

```
month
February      41920
February     401747
February     968453
February    2766074
Name: cumulative_number_of_sessions, dtype: int64
```



For positional indexing, there's `DataFrame.iloc`. Pass in a single integer
or a slice to get the corresponding rows...


```python
table.iloc[:5]
```

```
cumulative_number_of_sessions     month  number_of_sessions  year
0                          22263   January               22263  2011
1                          41920  February               19657  2011
2                          66426     March               24506  2011
3                          90424     April               23998  2011
4                         113666       May               23242  2011
```



...and key notation to select attributes.


```python
table.iloc[:5]['number_of_sessions']
```

```
0    22263
1    19657
2    24506
3    23998
4    23242
Name: number_of_sessions, dtype: int64
```



### Summary statistics


```python
table['number_of_sessions'].describe()
```

```
count        48.000000
mean     112961.729167
std       94804.167455
min       19657.000000
25%       34304.500000
50%       53743.500000
75%      189012.750000
max      301092.000000
Name: number_of_sessions, dtype: float64
```




```python
table['year'].value_counts()
```

```
2014    12
2013    12
2012    12
2011    12
Name: year, dtype: int64
```



### Transformations

Calculated columns are useful and easy! Operate on multiple columns...


```python
working_table = table.copy()
working_table['pct_total_to_date'] = working_table['number_of_sessions'] / working_table['cumulative_number_of_sessions']
working_table.head()
```

```
cumulative_number_of_sessions     month  number_of_sessions  year
\
0                          22263   January               22263  2011
1                          41920  February               19657  2011
2                          66426     March               24506  2011
3                          90424     April               23998  2011
4                         113666       May               23242  2011

   pct_total_to_date
0           1.000000
1           0.468917
2           0.368922
3           0.265394
4           0.204476
```



...`apply` lambda functions...


```python
average = working_table['number_of_sessions'].mean()
working_table['above_average'] = working_table['number_of_sessions'].apply(lambda x: x > average)
working_table.iloc[25:30]
```

```
cumulative_number_of_sessions     month  number_of_sessions  year
\
25                         968453  February               48984  2013
26                        1038212     March               69759  2013
27                        1152321     April              114109  2013
28                        1266074       May              113753  2013
29                        1401720      June              135646  2013

    pct_total_to_date  above_average
25           0.050580          False
26           0.067191          False
27           0.099025           True
28           0.089847           True
29           0.096771           True
```



...or `map` dictionaries for simple calculated or categorical fields.


```python
seasons = {
    'January': 'Winter',
    'February': 'Winter',
    'March': 'Spring',
    'April': 'Spring',
    'May': 'Spring',
    'June': 'Summer',
    'July': 'Summer',
    'August': 'Summer',
    'September': 'Fall',
    'October': 'Fall',
    'November': 'Fall',
    'December': 'Winter'
}

working_table['season'] = working_table['month'].map(seasons)

working_table.head(12)
```

```
cumulative_number_of_sessions      month  number_of_sessions  year
\
0                           22263    January               22263  2011
1                           41920   February               19657  2011
2                           66426      March               24506  2011
3                           90424      April               23998  2011
4                          113666        May               23242  2011
5                          139710       June               26044  2011
6                          167445       July               27735  2011
7                          201379     August               33934  2011
8                          234093  September               32714  2011
9                          268853    October               34760  2011
10                         302388   November               33535  2011
11                         334230   December               31842  2011

    pct_total_to_date  above_average  season
0            1.000000          False  Winter
1            0.468917          False  Winter
2            0.368922          False  Spring
3            0.265394          False  Spring
4            0.204476          False  Spring
5            0.186415          False  Summer
6            0.165636          False  Summer
7            0.168508          False  Summer
8            0.139748          False    Fall
9            0.129290          False    Fall
10           0.110901          False    Fall
11           0.095270          False  Winter
```



Have something a bit more involved? Iterate over your `DataFrame` with `iterrows`.
Note that each iterated row is a tuple containing an index value and the row attributes,
accessible via key notation.


```python
previous_year = None
pct_change = []

for idx, row in working_table.iterrows():
    current_year = row['number_of_sessions']
    if previous_year:
        pct_change.append((current_year - previous_year) / previous_year)
    else:
        pct_change.append(None)
    previous_year = current_year

working_table['pct_change'] = pct_change
```



### Aggregate functions

http://wesmckinney.com/blog/groupby-fu-improvements-in-grouping-and-aggregating-data-in-pandas/

### Plotting



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
