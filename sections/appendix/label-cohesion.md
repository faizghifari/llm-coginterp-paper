# Label cohesion results

We present the full label cohesion results for all labels here. From the subject category, only `finance` and `professional_writing` show significantly strong cohesion, both of which are very specific benchmarks with low median n. The next few labels show moderate to weak cohesion at best, a lot of which do not have enough significance to distinguish from chance. Labeling by language surprisingly show many weakly cohesive structure, especially for `monolingual_non_english`, which is an aggregate label. Individual labels for each language are not used due low n. All of the results support our claim that benchmark clusters are weakly cohesive.

```{=latex}
\begin{longtable}{@{}lrrr@{}}
\caption*{\textbf{Task type.} Cohesion by task-format label, sorted by descending median A.}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{likelihood\_probe} & +0.155 & 6/10 & 19 \\
\texttt{short\_qa} & +0.103 & 2/16 & 15 \\
\texttt{interactive} & +0.078 & 1/10 & 16 \\
\texttt{long\_reasoning} & +0.067 & 0/16 & 9 \\
\texttt{classification} & +0.067 & 2/16 & 15 \\
\texttt{multiple\_choice} & +0.056 & 6/16 & 37 \\
\texttt{long\_form\_generation} & +0.024 & 4/16 & 32 \\
\texttt{ranking} & -0.072 & 0/2 & 10 \\
\end{longtable}
```

```{=latex}
\begin{longtable}{@{}lrrr@{}}
\caption*{\textbf{Language.} Cohesion by language-coverage label, sorted by descending median A.}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{monolingual\_non\_english} & +0.272 & 14/16 & 19 \\
\texttt{multilingual} & +0.204 & 6/14 & 9 \\
\texttt{crosslingual} & +0.137 & 1/10 & 12 \\
\texttt{english} & -0.024 & 0/16 & 85 \\
\end{longtable}
```

```{=latex}
\begin{longtable}{@{}lrrr@{}}
\caption*{\textbf{Subject.} Cohesion by subject-matter label, sorted by descending median A.}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{finance} & +0.871 & 9/10 & 4 \\
\texttt{professional\_writing} & +0.631 & 4/6 & 5 \\
\texttt{commonsense} & +0.314 & 7/16 & 11 \\
\texttt{fact\_verification} & +0.304 & 0/4 & 5 \\
\texttt{code} & +0.263 & 7/16 & 11 \\
\texttt{translation} & +0.249 & 5/10 & 16 \\
\texttt{language\_understanding} & +0.247 & 4/6 & 10 \\
\texttt{linguistic\_competence} & +0.228 & 0/10 & 6 \\
\texttt{social\_media} & +0.225 & 2/10 & 6 \\
\texttt{sentiment} & +0.217 & 2/10 & 6 \\
\texttt{dialogue} & +0.202 & 0/6 & 5 \\
\texttt{industrial} & +0.185 & 0/2 & 4 \\
\texttt{cognitive} & +0.179 & 0/6 & 12 \\
\texttt{society\_culture} & +0.171 & 2/6 & 14 \\
\texttt{agentic} & +0.170 & 0/10 & 10 \\
\texttt{factuality} & +0.153 & 1/14 & 7 \\
\texttt{recall} & +0.134 & 10/16 & 21 \\
\texttt{structured\_data} & +0.110 & 0/6 & 15 \\
\texttt{language\_modelling} & +0.100 & 0/6 & 5 \\
\texttt{generation} & +0.092 & 2/10 & 37 \\
\texttt{world\_knowledge} & +0.092 & 0/16 & 7 \\
\texttt{logical\_reasoning} & +0.090 & 1/16 & 6 \\
\texttt{encyclopedic} & +0.076 & 1/16 & 23 \\
\texttt{medical} & +0.067 & 1/6 & 40 \\
\texttt{legal} & +0.065 & 0/4 & 4 \\
\texttt{multi\_subject} & +0.056 & 5/16 & 28 \\
\texttt{math} & +0.048 & 0/16 & 10 \\
\texttt{creativity} & +0.041 & 0/4 & 4 \\
\texttt{instruction\_following} & +0.040 & 0/10 & 16 \\
\texttt{specialized\_domain} & +0.024 & 1/16 & 13 \\
\texttt{games} & +0.019 & 0/6 & 6 \\
\texttt{science} & +0.018 & 0/16 & 11 \\
\texttt{natural\_language\_inference} & +0.017 & 0/6 & 9 \\
\texttt{safety} & +0.013 & 0/16 & 8 \\
\texttt{source\_genre} & +0.006 & 1/16 & 39 \\
\texttt{alignment} & -0.005 & 0/16 & 26 \\
\texttt{text\_classification} & -0.006 & 0/6 & 12 \\
\texttt{summarization} & -0.008 & 0/6 & 13 \\
\texttt{reasoning} & -0.011 & 0/16 & 19 \\
\texttt{retrieval} & -0.014 & 0/6 & 6 \\
\texttt{language\_processing} & -0.018 & 0/16 & 26 \\
\texttt{temporal\_reasoning} & -0.022 & 0/2 & 7 \\
\texttt{reading\_comprehension} & -0.026 & 0/16 & 9 \\
\texttt{news} & -0.045 & 0/16 & 6 \\
\texttt{toxicity} & -0.053 & 1/14 & 6 \\
\texttt{bias\_fairness} & -0.067 & 0/6 & 4 \\
\texttt{information\_extraction} & -0.126 & 0/2 & 4 \\
\texttt{fiction} & -0.225 & 0/6 & 4 \\
\end{longtable}
```
