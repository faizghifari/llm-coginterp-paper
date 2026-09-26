# Label cohesion results

We present the full label cohesion results for all labels here. From the subject category, only `finance` and `professional_writing` show significantly strong cohesion, both of which are very specific benchmarks with low median n. The next few labels show moderate to weak cohesion at best, a lot of which do not have enough significance to distinguish from chance. Labeling by language surprisingly show many weakly cohesive structure, especially for `monolingual_non_english`, which is an aggregate label. Individual labels for each language are not used due low n. All of the results support our claim that benchmark clusters are weakly cohesive.

```{=latex}
\begin{longtable}{@{}lrrr@{}}
\caption{Cohesion by task-format label, sorted by descending median A.}\label{tab:cohesion-task-type}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{conversation} & +0.283 & 3/6 & 7 \\
\texttt{likelihood\_probe} & +0.153 & 6/10 & 19 \\
\texttt{short\_qa} & +0.098 & 2/18 & 15 \\
\texttt{classification} & +0.095 & 2/18 & 15 \\
\texttt{interactive} & +0.078 & 1/10 & 16 \\
\texttt{long\_reasoning} & +0.066 & 0/18 & 9 \\
\texttt{multiple\_choice} & +0.059 & 8/18 & 37 \\
\texttt{long\_form\_generation} & +0.023 & 4/18 & 32 \\
\texttt{extraction} & -0.000 & 0/14 & 5 \\
\texttt{ranking} & -0.072 & 0/2 & 10 \\
\texttt{sentence\_completion} & -0.101 & 0/18 & 6 \\
\end{longtable}
```

```{=latex}
\begin{longtable}{@{}lrrr@{}}
\caption{Cohesion by language-coverage label, sorted by descending median A.}\label{tab:cohesion-language}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{monolingual\_non\_english} & +0.291 & 16/18 & 19 \\
\texttt{multilingual} & +0.204 & 6/14 & 9 \\
\texttt{crosslingual} & +0.137 & 1/10 & 12 \\
\texttt{english} & -0.034 & 0/18 & 85 \\
\end{longtable}
```

```{=latex}
\begin{longtable}{@{}lrrr@{}}
\caption{Cohesion by subject-matter label, sorted by descending median A.}\label{tab:cohesion-subject}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Label & Median A & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{finance} & +0.870 & 10/10 & 4 \\
\texttt{professional\_writing} & +0.632 & 4/6 & 5 \\
\texttt{fact\_verification} & +0.300 & 0/4 & 5 \\
\texttt{commonsense} & +0.287 & 5/18 & 11 \\
\texttt{code} & +0.264 & 6/18 & 11 \\
\texttt{translation} & +0.249 & 6/10 & 16 \\
\texttt{language\_understanding} & +0.247 & 4/6 & 10 \\
\texttt{linguistic\_competence} & +0.226 & 0/10 & 6 \\
\texttt{social\_media} & +0.226 & 2/10 & 6 \\
\texttt{sentiment} & +0.217 & 2/10 & 6 \\
\texttt{dialogue} & +0.203 & 0/6 & 5 \\
\texttt{industrial} & +0.186 & 0/2 & 4 \\
\texttt{cognitive} & +0.178 & 0/6 & 12 \\
\texttt{society\_culture} & +0.172 & 2/6 & 14 \\
\texttt{agentic} & +0.171 & 0/10 & 10 \\
\texttt{recall} & +0.169 & 13/18 & 21 \\
\texttt{factuality} & +0.154 & 1/14 & 7 \\
\texttt{structured\_data} & +0.111 & 0/6 & 15 \\
\texttt{language\_modelling} & +0.106 & 0/6 & 5 \\
\texttt{encyclopedic} & +0.104 & 1/18 & 23 \\
\texttt{world\_knowledge} & +0.092 & 0/18 & 7 \\
\texttt{generation} & +0.091 & 1/10 & 37 \\
\texttt{legal} & +0.069 & 0/4 & 4 \\
\texttt{multi\_subject} & +0.068 & 6/18 & 28 \\
\texttt{logical\_reasoning} & +0.068 & 2/18 & 6 \\
\texttt{medical} & +0.066 & 1/6 & 40 \\
\texttt{instruction\_following} & +0.044 & 0/10 & 16 \\
\texttt{creativity} & +0.042 & 0/4 & 4 \\
\texttt{safety} & +0.042 & 0/18 & 8 \\
\texttt{math} & +0.031 & 0/18 & 10 \\
\texttt{science} & +0.029 & 0/18 & 11 \\
\texttt{specialized\_domain} & +0.029 & 1/18 & 13 \\
\texttt{games} & +0.022 & 0/6 & 6 \\
\texttt{natural\_language\_inference} & +0.018 & 0/6 & 9 \\
\texttt{source\_genre} & +0.007 & 0/18 & 39 \\
\texttt{text\_classification} & -0.007 & 0/6 & 12 \\
\texttt{reasoning} & -0.008 & 0/18 & 19 \\
\texttt{summarization} & -0.008 & 0/6 & 13 \\
\texttt{reading\_comprehension} & -0.013 & 0/18 & 9 \\
\texttt{retrieval} & -0.014 & 0/6 & 6 \\
\texttt{language\_processing} & -0.016 & 0/18 & 26 \\
\texttt{alignment} & -0.016 & 0/18 & 26 \\
\texttt{temporal\_reasoning} & -0.024 & 0/2 & 7 \\
\texttt{news} & -0.042 & 0/18 & 6 \\
\texttt{toxicity} & -0.056 & 1/14 & 6 \\
\texttt{bias\_fairness} & -0.069 & 0/6 & 4 \\
\texttt{information\_extraction} & -0.120 & 0/2 & 4 \\
\texttt{fiction} & -0.232 & 0/6 & 4 \\
\end{longtable}
```
