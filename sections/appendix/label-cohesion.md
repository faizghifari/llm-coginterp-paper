# Label cohesion results

We present the full label cohesion results for all labels here. From the subject category, only `finance` and `professional_writing` show significantly strong cohesion, both of which are very specific labels with low median n. The next few labels show moderate to weak cohesion at best, a lot of which do not have enough significance to distinguish from chance. Labeling by language surprisingly shows many weakly cohesive structures, especially for `monolingual_non_english`, which is an aggregate label. Individual labels for each language are not used due to low n. All of the results support our claim that benchmark clusters are weakly cohesive.

```{=latex}
\begin{longtable}{@{}lrcrr@{}}
\caption{Cohesion by task-format label, sorted by descending median A.}\label{tab:cohesion-task-type}\\
\toprule
Label & Median A & A across cells & Significant & Median n \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Label & Median A & A across cells & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{likelihood\_probe} & +0.768 & +0.181 to +0.879 & 3/5 & 4 \\
\texttt{extraction} & +0.459 & +0.026 to +0.772 & 3/5 & 5 \\
\texttt{interactive} & +0.244 & +0.159 to +0.587 & 2/5 & 6 \\
\texttt{short\_qa} & +0.198 & +0.060 to +0.462 & 2/9 & 15 \\
\texttt{classification} & +0.186 & +0.008 to +0.285 & 0/9 & 15 \\
\texttt{multiple\_choice} & +0.079 & -0.003 to +0.235 & 1/9 & 36 \\
\texttt{conversation} & +0.026 & +0.025 to +0.028 & 0/2 & 7 \\
\texttt{long\_reasoning} & +0.014 & -0.211 to +0.370 & 0/9 & 9 \\
\texttt{sentence\_completion} & -0.035 & -0.646 to +0.128 & 0/9 & 5 \\
\texttt{long\_form\_generation} & -0.036 & -0.144 to +0.037 & 0/9 & 32 \\
\end{longtable}
```

```{=latex}
\begin{longtable}{@{}lrcrr@{}}
\caption{Cohesion by language-coverage label, sorted by descending median A.}\label{tab:cohesion-language}\\
\toprule
Label & Median A & A across cells & Significant & Median n \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Label & Median A & A across cells & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{monolingual\_non\_english} & +0.272 & +0.024 to +0.771 & 6/9 & 19 \\
\texttt{multilingual} & +0.183 & -0.006 to +0.435 & 2/5 & 9 \\
\texttt{crosslingual} & +0.135 & +0.083 to +0.193 & 0/5 & 10 \\
\texttt{english} & -0.009 & -0.176 to +0.004 & 0/9 & 85 \\
\end{longtable}
```

```{=latex}
\begin{longtable}{@{}lrcrr@{}}
\caption{Cohesion by subject-matter label, sorted by descending median A.}\label{tab:cohesion-subject}\\
\toprule
Label & Median A & A across cells & Significant & Median n \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Label & Median A & A across cells & Significant & Median n \\
\midrule
\endhead
\bottomrule
\endlastfoot
\texttt{finance} & +0.910 & +0.814 to +0.912 & 5/5 & 4 \\
\texttt{professional\_writing} & +0.612 & +0.610 to +0.613 & 1/2 & 5 \\
\texttt{factuality} & +0.485 & +0.132 to +0.577 & 2/5 & 7 \\
\texttt{world\_knowledge} & +0.399 & +0.119 to +0.602 & 2/9 & 7 \\
\texttt{creativity} & +0.378 & +0.377 to +0.378 & 0/2 & 4 \\
\texttt{reading\_comprehension} & +0.331 & -0.025 to +0.485 & 3/9 & 9 \\
\texttt{commonsense} & +0.329 & +0.189 to +0.514 & 2/9 & 7 \\
\texttt{sentiment} & +0.319 & -0.071 to +0.733 & 2/5 & 5 \\
\texttt{code} & +0.278 & +0.196 to +0.589 & 4/9 & 10 \\
\texttt{agentic} & +0.257 & +0.199 to +0.542 & 0/5 & 5 \\
\texttt{language\_understanding} & +0.253 & +0.251 to +0.254 & 0/2 & 10 \\
\texttt{science} & +0.233 & -0.014 to +0.614 & 1/9 & 11 \\
\texttt{language\_modelling} & +0.205 & +0.205 to +0.206 & 0/2 & 5 \\
\texttt{translation} & +0.190 & +0.004 to +0.221 & 0/5 & 9 \\
\texttt{linguistic\_competence} & +0.180 & -0.142 to +0.481 & 0/5 & 4 \\
\texttt{encyclopedic} & +0.165 & +0.078 to +0.574 & 2/9 & 23 \\
\texttt{social\_media} & +0.153 & +0.056 to +0.477 & 0/5 & 6 \\
\texttt{medical} & +0.139 & +0.139 to +0.139 & 2/2 & 40 \\
\texttt{games} & +0.113 & +0.112 to +0.113 & 0/2 & 6 \\
\texttt{structured\_data} & +0.110 & +0.109 to +0.111 & 0/2 & 15 \\
\texttt{recall} & +0.094 & -0.001 to +0.617 & 4/9 & 21 \\
\texttt{cognitive} & +0.086 & +0.086 to +0.087 & 0/2 & 12 \\
\texttt{dialogue} & +0.066 & +0.062 to +0.070 & 0/2 & 5 \\
\texttt{society\_culture} & +0.047 & +0.045 to +0.049 & 0/2 & 13 \\
\texttt{multi\_subject} & +0.037 & +0.011 to +0.320 & 0/9 & 28 \\
\texttt{generation} & +0.030 & -0.185 to +0.134 & 0/5 & 11 \\
\texttt{language\_processing} & +0.029 & -0.199 to +0.366 & 1/9 & 26 \\
\texttt{math} & +0.028 & -0.152 to +0.366 & 0/9 & 10 \\
\texttt{specialized\_domain} & +0.013 & -0.159 to +0.175 & 0/9 & 13 \\
\texttt{text\_classification} & -0.002 & -0.002 to -0.002 & 0/2 & 12 \\
\texttt{source\_genre} & -0.002 & -0.155 to +0.137 & 1/9 & 39 \\
\texttt{reasoning} & -0.017 & -0.071 to +0.008 & 0/9 & 19 \\
\texttt{logical\_reasoning} & -0.033 & -0.337 to +0.071 & 0/9 & 6 \\
\texttt{summarization} & -0.035 & -0.035 to -0.034 & 0/2 & 13 \\
\texttt{instruction\_following} & -0.045 & -0.045 to -0.044 & 0/2 & 19 \\
\texttt{alignment} & -0.051 & -0.336 to +0.092 & 1/9 & 26 \\
\texttt{natural\_language\_inference} & -0.052 & -0.054 to -0.051 & 0/2 & 6 \\
\texttt{toxicity} & -0.070 & -0.317 to +0.224 & 0/5 & 6 \\
\texttt{fiction} & -0.087 & -0.088 to -0.086 & 0/2 & 4 \\
\texttt{safety} & -0.094 & -0.901 to +0.236 & 1/9 & 8 \\
\texttt{retrieval} & -0.115 & -0.118 to -0.113 & 0/2 & 6 \\
\texttt{bias\_fairness} & -0.222 & -0.228 to -0.216 & 0/2 & 4 \\
\texttt{news} & -0.222 & -0.727 to +0.188 & 0/9 & 5 \\
\end{longtable}
```
