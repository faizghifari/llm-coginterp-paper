# Top benchmarks per factor

\textcolor{red}{For each of the six solutions in \hyperref[tab:point-summaries]{Table~\ref*{tab:point-summaries}}, the table lists the five benchmarks with the largest absolute loading on the general factor ($g$) and on each group factor of the Schmid--Leiman solution. The full loadings are released with the code.}

```{=latex}
\begin{longtable}{@{}>{\raggedright\arraybackslash}p{0.16\textwidth}l>{\raggedright\arraybackslash}p{0.72\textwidth}@{}}
\caption{\textcolor{red}{Five benchmarks with the largest absolute loading on each factor, with loadings in parentheses.}}\label{tab:factor-top-benchmarks}\\
\toprule
Solution & Factor & Top benchmarks (loading) \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Solution & Factor & Top benchmarks (loading) \\
\midrule
\endhead
\bottomrule
\endlastfoot
\textcolor{red}{missForest, S Std.} & \textcolor{red}{$g$} & \textcolor{red}{synthetic\_\allowbreak{}reasoning (+0.99), babi\_\allowbreak{}qa (+0.99), pwc\_\allowbreak{}arc\_\allowbreak{}easy (+0.97), quac (+0.97), pwc\_\allowbreak{}piqa (+0.96)} \\
 & \textcolor{red}{F1} & \textcolor{red}{--- (all $|\lambda| < 0.01$)} \\
 & \textcolor{red}{F2} & \textcolor{red}{indonli (+0.95), xnli (+0.92), thai\_\allowbreak{}exam\_\allowbreak{}a\_\allowbreak{}level (+0.90), xcopa (+0.90), nusax (+0.88)} \\
 & \textcolor{red}{F3} & \textcolor{red}{kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}facts (+0.77), kaggle\_\allowbreak{}sripalthilakraj\_\allowbreak{}global\_\allowbreak{}mmlu\_\allowbreak{}lite\_\allowbreak{}english (+0.74), kaggle\_\allowbreak{}aminmohamedmohami\_\allowbreak{}browsecomp (+0.72), kaggle\_\allowbreak{}yulongt\_\allowbreak{}facts\_\allowbreak{}parametric (+0.70), kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}scicode\_\allowbreak{}main\_\allowbreak{}standard (+0.70)} \\
 & \textcolor{red}{F4} & \textcolor{red}{twitter\_\allowbreak{}aae (+0.87), disinformation\_\allowbreak{}reiteration (-0.86), real\_\allowbreak{}toxicity\_\allowbreak{}prompts (-0.84), disinformation\_\allowbreak{}wedging (-0.82), blimp (+0.75)} \\
 & \textcolor{red}{F5} & \textcolor{red}{legal\_\allowbreak{}support (-0.73), lsat\_\allowbreak{}qa (-0.72), gsm8k (+0.42), civil\_\allowbreak{}comments (-0.41), thai\_\allowbreak{}exam\_\allowbreak{}tgat (+0.41)} \\
\midrule
\textcolor{red}{k-NN, C Std.} & \textcolor{red}{$g$} & \textcolor{red}{mmlu\_\allowbreak{}pro (+0.82), arena\_\allowbreak{}hard\_\allowbreak{}auto (+0.81), chatbot\_\allowbreak{}arena (+0.81), mmlu (+0.79), bbq (+0.79)} \\
 & \textcolor{red}{F1} & \textcolor{red}{thai\_\allowbreak{}exam\_\allowbreak{}tpat1 (+0.63), thaiexam (+0.60), thai\_\allowbreak{}exam\_\allowbreak{}tgat (+0.59), thai\_\allowbreak{}exam\_\allowbreak{}a\_\allowbreak{}level (+0.58), facts\_\allowbreak{}grounding (-0.39)} \\
 & \textcolor{red}{F2} & \textcolor{red}{entity\_\allowbreak{}data\_\allowbreak{}imputation (+0.79), narrative\_\allowbreak{}qa (+0.70), raft (+0.69), imdb (+0.67), natural\_\allowbreak{}qa\_\allowbreak{}openbook\_\allowbreak{}longans (+0.61)} \\
 & \textcolor{red}{F3} & \textcolor{red}{arc (+0.73), hellaswag (+0.72), winogrande (+0.59), mmlu (+0.54), gsm8k (+0.48)} \\
 & \textcolor{red}{F4} & \textcolor{red}{aratrust (+0.88), arabicmmlu (+0.86), madinah\_\allowbreak{}qa (+0.84), arabic\_\allowbreak{}exams (+0.82), alghafa (+0.80)} \\
 & \textcolor{red}{F5} & \textcolor{red}{the\_\allowbreak{}pile (-0.63), gpqa\_\allowbreak{}diamond (+0.49), kaggle\_\allowbreak{}aminmohamedmohami\_\allowbreak{}browsecomp (+0.47), artificial\_\allowbreak{}analysis\_\allowbreak{}intelligence (+0.45), summarization\_\allowbreak{}cnndm (-0.39)} \\
 & \textcolor{red}{F6} & \textcolor{red}{math\_\allowbreak{}chain\_\allowbreak{}of\_\allowbreak{}thought (+0.66), gsm (+0.65), lsat\_\allowbreak{}qa (+0.61), synthetic\_\allowbreak{}reasoning\_\allowbreak{}natural (+0.47), quac (+0.43)} \\
 & \textcolor{red}{F7} & \textcolor{red}{civil\_\allowbreak{}comments (+0.49), pwc\_\allowbreak{}piqa (-0.40), real\_\allowbreak{}toxicity\_\allowbreak{}prompts (-0.32), pwc\_\allowbreak{}arc\_\allowbreak{}challenge (-0.32), babi\_\allowbreak{}qa (-0.30)} \\
 & \textcolor{red}{F8} & \textcolor{red}{aime25 (+0.78), kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}scicode\_\allowbreak{}subproblem\_\allowbreak{}with\_\allowbreak{}background (+0.60), kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}simpleqa\_\allowbreak{}verified (+0.60), kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}scicode\_\allowbreak{}subproblem\_\allowbreak{}standard (+0.59), kaggle\_\allowbreak{}sjmikler\_\allowbreak{}livecodebench (+0.54)} \\
\midrule
\textcolor{red}{missForest, C Std.} & \textcolor{red}{$g$} & \textcolor{red}{thai\_\allowbreak{}exam\_\allowbreak{}tpat1 (+0.93), bbq (+0.93), anthropic\_\allowbreak{}red\_\allowbreak{}team (+0.92), simple\_\allowbreak{}safety\_\allowbreak{}tests (+0.92), thai\_\allowbreak{}exam\_\allowbreak{}tgat (+0.92)} \\
 & \textcolor{red}{F1} & \textcolor{red}{bbq (+0.33), legalbench (+0.31), xstest (+0.30), pwc\_\allowbreak{}arc\_\allowbreak{}challenge (+0.30), arena\_\allowbreak{}hard\_\allowbreak{}auto (+0.30)} \\
 & \textcolor{red}{F2} & \textcolor{red}{summarization\_\allowbreak{}cnndm (+0.96), imdb (+0.92), entity\_\allowbreak{}data\_\allowbreak{}imputation (+0.86), summarization\_\allowbreak{}xsum (+0.83), narrative\_\allowbreak{}qa (+0.82)} \\
 & \textcolor{red}{F3} & \textcolor{red}{aime25 (+0.96), kaggle\_\allowbreak{}sjmikler\_\allowbreak{}livecodebench (+0.90), artificial\_\allowbreak{}analysis\_\allowbreak{}intelligence (+0.89), madinah\_\allowbreak{}qa (+0.83), arabic\_\allowbreak{}exams (+0.83)} \\
 & \textcolor{red}{F4} & \textcolor{red}{real\_\allowbreak{}toxicity\_\allowbreak{}prompts (-0.61), disinformation\_\allowbreak{}wedging (-0.60), disinformation\_\allowbreak{}reiteration (-0.58), kaggle\_\allowbreak{}vijitsingh1\_\allowbreak{}mgsm\_\allowbreak{}english (+0.40), bold (-0.36)} \\
\midrule
\textcolor{red}{SoftImpute, C Std.} & \textcolor{red}{$g$} & \textcolor{red}{gsm (+0.73), math\_\allowbreak{}chain\_\allowbreak{}of\_\allowbreak{}thought (+0.72), openbookqa (+0.72), mbpp (+0.66), bbh (+0.65)} \\
 & \textcolor{red}{F1} & \textcolor{red}{arabicmmlu (-0.95), madinah\_\allowbreak{}qa (-0.95), aratrust (-0.95), arabic\_\allowbreak{}exams (-0.93), alghafa (-0.92)} \\
 & \textcolor{red}{F2} & \textcolor{red}{math (+0.81), ifeval (+0.70), chatbot\_\allowbreak{}arena (+0.67), mbpp (+0.62), synthetic\_\allowbreak{}reasoning\_\allowbreak{}natural (+0.60)} \\
 & \textcolor{red}{F3} & \textcolor{red}{math500 (+0.88), disinformation\_\allowbreak{}reiteration (-0.83), real\_\allowbreak{}toxicity\_\allowbreak{}prompts (-0.83), disinformation\_\allowbreak{}wedging (-0.83), kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}scicode\_\allowbreak{}subproblem\_\allowbreak{}standard (+0.77)} \\
 & \textcolor{red}{F4} & \textcolor{red}{narrative\_\allowbreak{}qa (+1.00), imdb (+0.95), natural\_\allowbreak{}qa\_\allowbreak{}openbook\_\allowbreak{}longans (+0.81), entity\_\allowbreak{}data\_\allowbreak{}imputation (+0.80), raft (+0.77)} \\
 & \textcolor{red}{F5} & \textcolor{red}{hellaswag (+0.98), arc (+0.94), winogrande (+0.83), mmlu (+0.81), artificial\_\allowbreak{}analysis\_\allowbreak{}intelligence (-0.56)} \\
 & \textcolor{red}{F6} & \textcolor{red}{simple\_\allowbreak{}safety\_\allowbreak{}tests (+0.95), anthropic\_\allowbreak{}red\_\allowbreak{}team (+0.94), xstest (+0.94), bbq (+0.73), harmbench (+0.66)} \\
 & \textcolor{red}{F7} & \textcolor{red}{legal\_\allowbreak{}support (+0.90), lsat\_\allowbreak{}qa (+0.86), copyright\_\allowbreak{}text (-0.67), wmt\_\allowbreak{}14 (+0.54), summarization\_\allowbreak{}xsum (+0.43)} \\
 & \textcolor{red}{F8} & \textcolor{red}{kaggle\_\allowbreak{}aminmohamedmohami\_\allowbreak{}browsecomp (-0.79), bfcl (+0.55), multiloko (-0.51), arena\_\allowbreak{}hard\_\allowbreak{}auto (+0.46), legalbench (+0.45)} \\
 & \textcolor{red}{F9} & \textcolor{red}{bold (+0.77), facts\_\allowbreak{}grounding (-0.65), copyright\_\allowbreak{}text (+0.51), civil\_\allowbreak{}comments (-0.47), entity\_\allowbreak{}matching (+0.47)} \\
 & \textcolor{red}{F10} & \textcolor{red}{gsm (+0.61), openbookqa (+0.61), math\_\allowbreak{}chain\_\allowbreak{}of\_\allowbreak{}thought (+0.53), gsm8k (+0.42), wmt\_\allowbreak{}14 (+0.33)} \\
\midrule
\textcolor{red}{SoftImpute, R Aggr.} & \textcolor{red}{$g$} & \textcolor{red}{financial\_\allowbreak{}scenarios (+0.90), madinah\_\allowbreak{}qa (+0.90), kaggle\_\allowbreak{}yulongt\_\allowbreak{}facts\_\allowbreak{}parametric (+0.90), sorry\_\allowbreak{}bench (-0.90), pwc\_\allowbreak{}siqa (+0.89)} \\
 & \textcolor{red}{F1} & \textcolor{red}{pwc\_\allowbreak{}peerqa (+0.70), include (+0.44), mt\_\allowbreak{}bench (+0.41), naturalquestions (+0.39), agentif (+0.38)} \\
 & \textcolor{red}{F2} & \textcolor{red}{litbench (+0.39), chw\_\allowbreak{}care\_\allowbreak{}plan (-0.34), vihsd (-0.33), head\_\allowbreak{}qa (-0.33), benchmax (+0.32)} \\
 & \textcolor{red}{F3} & \textcolor{red}{cogbench (+0.45), scigen (+0.44), worldvaluesbench (+0.42), ewok\_\allowbreak{}social\_\allowbreak{}relations (+0.42), ewok\_\allowbreak{}agent\_\allowbreak{}properties (+0.42)} \\
 & \textcolor{red}{F4} & \textcolor{red}{summarization\_\allowbreak{}cnndm (+0.79), summarization\_\allowbreak{}xsum (+0.62), narrative\_\allowbreak{}qa (+0.50), pwc\_\allowbreak{}arc\_\allowbreak{}challenge (+0.47), pwc\_\allowbreak{}arc\_\allowbreak{}easy (+0.45)} \\
 & \textcolor{red}{F5} & \textcolor{red}{kaggle\_\allowbreak{}jonlipovetz\_\allowbreak{}game\_\allowbreak{}arena (-0.75), oogiri (-0.72), kaggle\_\allowbreak{}jonlipovetz\_\allowbreak{}chess\_\allowbreak{}suite (-0.67), SuperGPQA (-0.64), workplacehumor (+0.50)} \\
 & \textcolor{red}{F6} & \textcolor{red}{medi\_\allowbreak{}qa (-0.86), facts\_\allowbreak{}parametric (+0.80), medication\_\allowbreak{}qa (-0.62), math\_\allowbreak{}regular (+0.57), medmcqa (-0.49)} \\
 & \textcolor{red}{F7} & \textcolor{red}{bold (+0.89), copyright\_\allowbreak{}text (+0.85), pwc\_\allowbreak{}bioasq (+0.58), pwc\_\allowbreak{}lambada (+0.54), twitter\_\allowbreak{}aae (-0.47)} \\
 & \textcolor{red}{F8} & \textcolor{red}{pwc\_\allowbreak{}bioasq (-0.91), indoculture (+0.81), mega (+0.54), ice (-0.43), indommlu (+0.42)} \\
 & \textcolor{red}{F9} & \textcolor{red}{pubmedqa (-1.09), naturalquestions (+0.70), pwc\_\allowbreak{}svamp (-0.53), pwc\_\allowbreak{}big\_\allowbreak{}bench\_\allowbreak{}penguins\_\allowbreak{}in\_\allowbreak{}a\_\allowbreak{}table (+0.52), pwc\_\allowbreak{}big\_\allowbreak{}bench\_\allowbreak{}causal\_\allowbreak{}judgment (+0.52)} \\
 & \textcolor{red}{F10} & \textcolor{red}{ehr\_\allowbreak{}sql (+0.86), medbullets (+0.71), medmcqa (+0.53), medec (+0.49), pwc\_\allowbreak{}frontiermath (+0.49)} \\
 & \textcolor{red}{F11} & \textcolor{red}{flores\_\allowbreak{}vi\_\allowbreak{}en (+0.82), flores\_\allowbreak{}id\_\allowbreak{}en (+0.69), filbench (+0.53), wisesight (+0.53), flores\_\allowbreak{}en\_\allowbreak{}id (+0.51)} \\
 & \textcolor{red}{F12} & \textcolor{red}{disinformation\_\allowbreak{}wedging (-0.53), disinformation\_\allowbreak{}reiteration (-0.50), twitter\_\allowbreak{}aae (+0.40), msmarco\_\allowbreak{}trec (-0.38), msmarco\_\allowbreak{}regular (-0.38)} \\
 & \textcolor{red}{F13} & \textcolor{red}{pwc\_\allowbreak{}obqa (-0.72), pwc\_\allowbreak{}record (+0.46), pwc\_\allowbreak{}storycloze (-0.43), irokobench (+0.33), triviaqa (+0.31)} \\
 & \textcolor{red}{F14} & \textcolor{red}{legal\_\allowbreak{}support (+0.45), lsat\_\allowbreak{}qa (+0.34), aratrust (+0.24), livebench (+0.23), hellaswag (-0.22)} \\
 & \textcolor{red}{F15} & \textcolor{red}{vmlu (+1.14), indommlu (+0.60), medqa (+0.55), cogbench (+0.48), legalbench (+0.40)} \\
 & \textcolor{red}{F16} & \textcolor{red}{boolq (-0.68), babi\_\allowbreak{}qa (-0.62), civil\_\allowbreak{}comments (-0.61), entity\_\allowbreak{}data\_\allowbreak{}imputation (-0.60), entity\_\allowbreak{}matching (-0.40)} \\
 & \textcolor{red}{F17} & \textcolor{red}{mbpp (-0.35), mtrag (-0.35), sea\_\allowbreak{}exam (-0.35), gpqa (+0.34), pwc\_\allowbreak{}pecc (-0.34)} \\
 & \textcolor{red}{F18} & \textcolor{red}{complexbench (-0.35), pwc\_\allowbreak{}arc\_\allowbreak{}challenge (-0.33), disinformation\_\allowbreak{}reiteration (-0.32), neuro\_\allowbreak{}eval (+0.31), harmbench (-0.31)} \\
 & \textcolor{red}{F19} & \textcolor{red}{artificial\_\allowbreak{}analysis\_\allowbreak{}intelligence (-0.38), livecodebench (-0.29), aime\_\allowbreak{}2025 (-0.27), swe\_\allowbreak{}bench (-0.23), gpqa\_\allowbreak{}diamond (-0.22)} \\
 & \textcolor{red}{F20} & \textcolor{red}{indicqa (+0.55), arabic\_\allowbreak{}exams (+0.38), pwc\_\allowbreak{}sst\_\allowbreak{}5\_\allowbreak{}fine\_\allowbreak{}grained\_\allowbreak{}classification (+0.36), tydiqa (+0.34), arabicmmlu (+0.33)} \\
\midrule
\textcolor{red}{SoftImpute, S Std.} & \textcolor{red}{$g$} & \textcolor{red}{twitter\_\allowbreak{}aae (-0.72), alghafa (-0.69), aratrust (-0.66), ice (-0.65), arabic\_\allowbreak{}exams (-0.64)} \\
 & \textcolor{red}{F1} & \textcolor{red}{blimp (-0.69), ice (-0.65), twitter\_\allowbreak{}aae (-0.62), alghafa (-0.49), the\_\allowbreak{}pile (-0.48)} \\
 & \textcolor{red}{F2} & \textcolor{red}{msmarco\_\allowbreak{}regular (+1.00), msmarco\_\allowbreak{}trec (+0.98), boolq (+0.84), wikifact (+0.77), entity\_\allowbreak{}data\_\allowbreak{}imputation (+0.74)} \\
 & \textcolor{red}{F3} & \textcolor{red}{gsm (+0.95), math\_\allowbreak{}chain\_\allowbreak{}of\_\allowbreak{}thought (+0.94), openbookqa (+0.91), medqa (+0.84), math\_\allowbreak{}regular (+0.78)} \\
 & \textcolor{red}{F4} & \textcolor{red}{kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}scicode\_\allowbreak{}subproblem\_\allowbreak{}with\_\allowbreak{}background (+0.86), mmlu\_\allowbreak{}prox (+0.86), kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}scicode\_\allowbreak{}main\_\allowbreak{}with\_\allowbreak{}background (+0.85), math500 (+0.81), kaggle\_\allowbreak{}andrewmingwang\_\allowbreak{}scicode\_\allowbreak{}subproblem\_\allowbreak{}standard (+0.80)} \\
 & \textcolor{red}{F5} & \textcolor{red}{mlhsd (+0.97), vihsd (+0.95), thaitoxicitytweets (+0.91), uitvsfc (+0.87), lindsea\_\allowbreak{}pragmatics\_\allowbreak{}presuppositions\_\allowbreak{}id (+0.84)} \\
 & \textcolor{red}{F6} & \textcolor{red}{simple\_\allowbreak{}safety\_\allowbreak{}tests (+0.95), anthropic\_\allowbreak{}red\_\allowbreak{}team (+0.93), xstest (+0.72), summarization\_\allowbreak{}cnndm (+0.71), arena\_\allowbreak{}hard\_\allowbreak{}auto (+0.65)} \\
 & \textcolor{red}{F7} & \textcolor{red}{xquad (-0.75), bbh (+0.69), kaggle\_\allowbreak{}aminmohamedmohami\_\allowbreak{}browsecomp (-0.67), lsat\_\allowbreak{}qa (+0.66), musr (+0.64)} \\
 & \textcolor{red}{F8} & \textcolor{red}{disinformation\_\allowbreak{}reiteration (+0.85), disinformation\_\allowbreak{}wedging (+0.83), artificial\_\allowbreak{}analysis\_\allowbreak{}intelligence (+0.74), real\_\allowbreak{}toxicity\_\allowbreak{}prompts (+0.67), gpqa\_\allowbreak{}diamond (+0.56)} \\
\end{longtable}
```
