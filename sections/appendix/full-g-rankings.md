# Full $G$-rankings

`\hyperref[tab:full-g-rankings]{Table~\ref*{tab:full-g-rankings}}`{=latex} lists all 124 benchmarks used across our analyses, sorted by their rank order as in `\hyperref[tab:g-rankings]{Table~\ref*{tab:g-rankings}}`{=latex} of the main text. The ranking method and its diagnostics are described in `\hyperref[benchmark-g-rankings]{Appendix~\ref*{benchmark-g-rankings}}`{=latex}. <!-- Moved here from the g-rankings appendix 2026-09-26, so the 380-row table sits at the end of the appendix. The intro read: Table 4 below shows benchmarks sorted by their rank order, similar to table 5 in the main content, but now including the entirety of 380 benchmarks useda cross our analyses. -->

```{=latex}
\begingroup\normalsize\setlength{\tabcolsep}{3pt}
\begin{longtable}{@{}r>{\raggedright\arraybackslash}p{0.21\textwidth}rrlrrr>{\raggedright\arraybackslash}p{0.25\textwidth}@{}}
\caption{All used 124 benchmarks, sorted by their average normalized rank order (ANR) of their $G$ factor loadings, residualized (RANR) against their frequency. The normalized rank order ranges from 0 to 1. 0 = ranked first, 1 = ranked last. $N$ cells = number of EFA solutions with that benchmark. CI and Best/Worst refers to ANR. Leading zeros are omitted. Reference is the paper introducing the benchmark; $^\dagger$ marks benchmarks without one, cited by the source of their scores.}\label{tab:full-g-rankings}\\
\toprule
No & Benchmark & $\rho_\epsilon$ & $\rho$ & 95\% CI & Best & Worst & $N$ & Reference \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
No & Benchmark & $\rho_\epsilon$ & $\rho$ & 95\% CI & Best & Worst & $N$ & Reference \\
\midrule
\endhead
\bottomrule
\endlastfoot
1 & simpleqa & -.312 & .186 & [-.199, .572] & .041 & .350 & 3 & \citealp{wei2024measuring} \\
2 & kaggle\_yulongt\_facts\_parametric & -.307 & .189 & [-.491, .870] & .006 & .504 & 3 & \citealp{kaggle_benchmarks}$^\dagger$ \\
3 & kaggle\_andrewmingwang\_asset\_ops\_bench & -.267 & .228 & [-.424, .879] & .049 & .528 & 3 & \citealp{constantinides2025failuresensoriq} \\
4 & kaggle\_olamysiak\_eclektic & -.242 & .256 & [.049, .463] & .175 & .341 & 3 & \citealp{goldman2025eclektic} \\
5 & tydiqa & -.235 & .260 & [.046, .474] & .195 & .358 & 3 & \citealp{clark2020tydi} \\
6 & facts\_search & -.232 & .262 & [-.208, .732] & .104 & .472 & 3 & \citealp{cheng2025facts} \\
7 & medqa & -.192 & .316 & [.016, .615] & .065 & .819 & 6 & \citealp{jin2020what} \\
8 & pwc\_arc\_challenge & -.186 & .351 & [.083, .619] & .104 & .767 & 6 & \citealp{clark2018think} \\
9 & thai\_exam\_a\_level & -.175 & .354 & [.020, .688] & .123 & .959 & 6 & \citealp{pipatanakul2023typhoon} \\
10 & bbq & -.162 & .349 & [-.013, .711] & .013 & .967 & 6 & \citealp{parrish2021bbq} \\
11 & legalbench & -.157 & .353 & [.079, .627] & .078 & .748 & 6 & \citealp{guha2023legalbench} \\
12 & pwc\_piqa & -.156 & .381 & [.053, .710] & .033 & .939 & 6 & \citealp{bisk2019piqa} \\
13 & thai\_exam\_tpat1 & -.156 & .373 & [.013, .733] & .000 & .878 & 6 & \citealp{pipatanakul2023typhoon} \\
14 & openbookqa & -.154 & .343 & [-.021, .708] & .026 & .862 & 6 & \citealp{mihaylov2018can} \\
15 & thaiexam & -.153 & .376 & [-.007, .758] & .074 & .984 & 6 & \citealp{pipatanakul2023typhoon} \\
16 & simple\_safety\_tests & -.149 & .363 & [.029, .697] & .039 & .886 & 6 & \citealp{vidgen2023simplesafetytests} \\
17 & anthropic\_red\_team & -.140 & .372 & [.023, .721] & .026 & .902 & 6 & \citealp{ganguli2022red} \\
18 & wisesight & -.136 & .358 & [-.495, 1.212] & .073 & .740 & 3 & \citealp{susanto2025sea}$^\dagger$ \\
19 & wmt\_14 & -.136 & .374 & [.018, .731] & .114 & 1.000 & 6 & \citealp{bojar2014findings} \\
20 & chatbot\_arena & -.134 & .375 & [.116, .633] & .026 & .650 & 6 & \citealp{zheng2023judging} \\
21 & kaggle\_andrewmingwang\_scicode\_subproblem\_with\_background & -.132 & .396 & [.258, .533] & .179 & .519 & 6 & \citealp{tian2024scicode} \\
22 & kaggle\_andrewmingwang\_scicode\_main\_with\_background & -.124 & .374 & [.149, .600] & .276 & .455 & 3 & \citealp{tian2024scicode} \\
23 & xquad & -.119 & .376 & [.190, .562] & .298 & .447 & 3 & \citealp{artetxe2019cross} \\
24 & blimp & -.119 & .376 & [-.758, 1.510] & .087 & .902 & 3 & \citealp{warstadt2019blimp} \\
25 & xstest & -.116 & .396 & [.137, .654] & .182 & .821 & 6 & \citealp{rottger2023xstest} \\
26 & synthetic\_reasoning & -.113 & .409 & [.082, .736] & .000 & .809 & 6 & \citealp{helm2023} \\
27 & synthetic\_reasoning\_natural & -.112 & .410 & [.093, .728] & .041 & .870 & 6 & \citealp{helm2023} \\
28 & nusax & -.111 & .384 & [-.361, 1.130] & .130 & .715 & 3 & \citealp{winata2022nusax} \\
29 & truthfulqa & -.110 & .322 & [.140, .504] & .156 & .642 & 6 & \citealp{lin2021truthfulqa} \\
30 & mmlu\_prox & -.107 & .420 & [.118, .722] & .152 & .805 & 6 & \citealp{xuan2025mmlu} \\
31 & ice & -.104 & .390 & [-.399, 1.179] & .024 & .593 & 3 & \citealp{helm2023}$^\dagger$ \\
32 & xcopa & -.101 & .394 & [-.474, 1.261] & .181 & .797 & 3 & \citealp{ponti2020xcopa} \\
33 & twitter\_aae & -.099 & .395 & [-.686, 1.477] & .000 & .862 & 3 & \citealp{blodgett2016demographic} \\
34 & real\_toxicity\_prompts & -.099 & .431 & [.125, .738] & .097 & .870 & 6 & \citealp{gehman2020realtoxicityprompts} \\
35 & lindsea\_pragmatics\_scalar\_implicatures\_id & -.097 & .397 & [-.050, .845] & .217 & .577 & 3 & \citealp{leong2023bhasa} \\
36 & kaggle\_andrewmingwang\_simpleqa\_verified & -.093 & .438 & [.153, .723] & .049 & .727 & 6 & \citealp{haas2025simpleqa} \\
37 & bfcl & -.090 & .441 & [.118, .764] & .071 & .846 & 6 & \citealp{bfcl_leaderboard} \\
38 & arena\_hard\_auto & -.084 & .447 & [.036, .858] & .013 & .903 & 6 & \citealp{li2024from} \\
39 & kaggle\_andrewmingwang\_scicode\_subproblem\_standard & -.081 & .447 & [.251, .643] & .211 & .779 & 6 & \citealp{tian2024scicode} \\
40 & msmarco\_trec & -.080 & .414 & [-.404, 1.232] & .081 & .740 & 3 & \citealp{campos2016ms} \\
41 & lindsea\_syntax\_minimal\_pairs\_id & -.077 & .418 & [-.683, 1.518] & .122 & .927 & 3 & \citealp{leong2023bhasa} \\
42 & indicqa & -.076 & .419 & [-.153, .991] & .187 & .647 & 3 & \citealp{doddapaneni2022leaving} \\
43 & bbh & -.073 & .317 & [-.003, .638] & .052 & .780 & 6 & \citealp{suzgun2022challenging} \\
44 & uitvsfc & -.072 & .423 & [.039, .808] & .325 & .602 & 3 & \citealp{nguyen2018uit} \\
45 & flores\_en\_vi & -.071 & .424 & [.090, .757] & .293 & .561 & 3 & \citealp{costajussa2022no} \\
46 & mmlu & -.070 & .367 & [.027, .706] & .039 & .829 & 6 & \citealp{hendrycks2021} \\
47 & indicsentiment & -.068 & .427 & [-.498, 1.351] & .171 & .854 & 3 & \citealp{doddapaneni2022leaving} \\
48 & mmlu\_pro & -.065 & .325 & [-.019, .668] & .000 & .797 & 6 & \citealp{wang2024mmlu} \\
49 & kaggle\_andrewmingwang\_facts & -.064 & .430 & [-.157, 1.017] & .163 & .610 & 3 & \citealp{jacovi2025facts} \\
50 & kaggle\_vijitsingh1\_mgsm\_english & -.060 & .468 & [.268, .667] & .171 & .756 & 6 & \citealp{shi2022language} \\
51 & arabicmmlu & -.058 & .473 & [.120, .826] & .019 & .857 & 6 & \citealp{koto2024arabicmmlu} \\
52 & madinah\_qa & -.057 & .474 & [.087, .860] & .003 & .883 & 6 & \citealp{helm_arabic}$^\dagger$ \\
53 & kaggle\_sripalthilakraj\_global\_mmlu\_lite\_english & -.054 & .443 & [-.330, 1.216] & .094 & .691 & 3 & \citealp{singh2024global} \\
54 & msmarco\_regular & -.051 & .443 & [-.456, 1.343] & .089 & .813 & 3 & \citealp{campos2016ms} \\
55 & flores\_th\_en & -.048 & .447 & [-.023, .917] & .244 & .618 & 3 & \citealp{costajussa2022no} \\
56 & multiloko & -.045 & .480 & [.124, .835] & .029 & .909 & 6 & \citealp{hupkes2025multiloko} \\
57 & cogbench & -.043 & .453 & [-.590, 1.495] & .106 & .919 & 3 & \citealp{codaforno2024cogbench} \\
58 & gsm & -.040 & .449 & [.022, .877] & .000 & .935 & 6 & \citealp{cobbe2021training} \\
59 & artificial\_analysis\_intelligence & -.033 & .505 & [.223, .786] & .061 & .818 & 6 & \citealp{artificialanalysis_index} \\
60 & legal\_support & -.030 & .492 & [.145, .838] & .091 & .951 & 6 & \citealp{helm2023} \\
61 & mbpp & -.030 & .510 & [.093, .927] & .039 & .976 & 6 & \citealp{austin2021program} \\
62 & xnli & -.027 & .468 & [-.256, 1.192] & .220 & .789 & 3 & \citealp{conneau2018xnli} \\
63 & thai\_exam\_tgat & -.026 & .503 & [.068, .937] & .023 & .992 & 6 & \citealp{pipatanakul2023typhoon} \\
64 & aratrust & -.025 & .505 & [.091, .919] & .016 & .961 & 6 & \citealp{alghamdi2024aratrust} \\
65 & math\_chain\_of\_thought & -.021 & .468 & [.014, .923] & .013 & .997 & 6 & \citealp{hendrycks2021measuring} \\
66 & kaggle\_andrewmingwang\_scicode\_main\_standard & -.010 & .486 & [-.031, 1.004] & .268 & .683 & 3 & \citealp{tian2024scicode} \\
67 & quac & -.009 & .514 & [.248, .780] & .024 & .753 & 6 & \citealp{choi2018quac} \\
68 & summarization\_xsum & -.003 & .527 & [.270, .784] & .138 & .831 & 6 & \citealp{narayan2018dont} \\
69 & arc & -.003 & .435 & [.161, .709] & .073 & .878 & 6 & \citealp{clark2018think} \\
70 & gsm8k & -.002 & .423 & [.152, .695] & .117 & .841 & 6 & \citealp{cobbe2021training} \\
71 & arabic\_exams & -.001 & .530 & [.116, .943] & .033 & .883 & 6 & \citealp{hardalov2020exams} \\
72 & alghafa & .012 & .542 & [.112, .973] & .008 & .896 & 6 & \citealp{almazrouei2023alghafa} \\
73 & babi\_qa & .017 & .538 & [.224, .853] & .008 & .857 & 6 & \citealp{weston2015ai} \\
74 & lindsea\_pragmatics\_presuppositions\_id & .018 & .513 & [-.002, 1.028] & .294 & .707 & 3 & \citealp{leong2023bhasa} \\
75 & gpqa\_diamond & .019 & .548 & [.353, .743] & .340 & .870 & 6 & \citealp{rein2023gpqa} \\
76 & kaggle\_sjmikler\_livecodebench & .019 & .546 & [.304, .788] & .236 & .883 & 6 & \citealp{jain2024livecodebench} \\
77 & pwc\_arc\_easy & .022 & .518 & [-.561, 1.597] & .016 & .773 & 3 & \citealp{clark2018think} \\
78 & kaggle\_aminmohamedmohami\_browsecomp & .022 & .551 & [.221, .882] & .065 & .935 & 6 & \citealp{wei2025browsecomp} \\
79 & disinformation\_reiteration & .023 & .553 & [.249, .857] & .179 & .896 & 6 & \citealp{helm2023} \\
80 & natural\_qa\_closedbook & .027 & .518 & [.186, .850] & .154 & .877 & 6 & \citealp{kwiatkowski2019natural} \\
81 & alrage & .031 & .562 & [.186, .937] & .089 & .974 & 6 & \citealp{helm_arabic}$^\dagger$ \\
82 & ifeval & .032 & .421 & [.254, .589] & .208 & .660 & 6 & \citealp{zhou2023instruction} \\
83 & harmbench & .032 & .544 & [.314, .774] & .165 & .748 & 6 & \citealp{mazeika2024harmbench} \\
84 & wikifact & .035 & .557 & [.261, .854] & .049 & .828 & 6 & \citealp{helm2023} \\
85 & swe\_bench & .043 & .535 & [-.512, 1.581] & .084 & .919 & 3 & \citealp{jimenez2023swe} \\
86 & disinformation\_wedging & .046 & .577 & [.320, .833] & .154 & .829 & 6 & \citealp{helm2023} \\
87 & gpqa & .048 & .438 & [.088, .787] & .078 & .976 & 6 & \citealp{rein2023gpqa} \\
88 & aime25 & .052 & .580 & [.324, .837] & .301 & .961 & 6 & \citealp{maa_aime} \\
89 & vihsd & .058 & .553 & [.319, .786] & .447 & .626 & 3 & \citealp{luu2021large} \\
90 & math\_regular & .058 & .598 & [.202, .993] & .104 & .990 & 6 & \citealp{hendrycks2021measuring} \\
91 & math500 & .061 & .592 & [.390, .794] & .276 & .818 & 6 & \citealp{lightman2023let} \\
92 & lsat\_qa & .062 & .584 & [.216, .952] & .026 & 1.000 & 6 & \citealp{zhong2021ar} \\
93 & natural\_qa\_openbook\_longans & .067 & .558 & [.317, .799] & .293 & .857 & 6 & \citealp{kwiatkowski2019natural} \\
94 & flores\_en\_th & .073 & .568 & [-.149, 1.285] & .346 & .894 & 3 & \citealp{costajussa2022no} \\
95 & flores\_en\_id & .074 & .569 & [-.013, 1.151] & .309 & .764 & 3 & \citealp{costajussa2022no} \\
96 & winogrande & .077 & .506 & [.248, .765] & .146 & .919 & 6 & \citealp{sakaguchi2019winogrande} \\
97 & copyright\_text & .081 & .611 & [.295, .927] & .236 & .948 & 6 & \citealp{helm2023} \\
98 & financial\_scenarios & .081 & .575 & [-.663, 1.812] & .000 & .886 & 3 & \citealp{helm2023}$^\dagger$ \\
99 & facts\_grounding & .082 & .612 & [.315, .909] & .207 & .922 & 6 & \citealp{cheng2025facts} \\
100 & musr & .086 & .476 & [.305, .646] & .273 & .644 & 6 & \citealp{sprague2023musr} \\
101 & indonli & .089 & .584 & [-.156, 1.323] & .301 & .894 & 3 & \citealp{mahendra2021indonli} \\
102 & raft & .093 & .616 & [.289, .943] & .065 & .948 & 6 & \citealp{alex2021raft} \\
103 & flores\_en\_ta & .095 & .590 & [-.192, 1.371] & .379 & .951 & 3 & \citealp{costajussa2022no} \\
104 & mlhsd & .097 & .592 & [.143, 1.040] & .434 & .789 & 3 & \citealp{susanto2025sea}$^\dagger$ \\
105 & bigcodebench & .100 & .596 & [-.288, 1.480] & .285 & .984 & 3 & \citealp{zhuo2024bigcodebench} \\
106 & boolq & .108 & .630 & [.329, .932] & .130 & .974 & 6 & \citealp{clark2019boolq} \\
107 & entity\_data\_imputation & .126 & .649 & [.377, .920] & .244 & .893 & 6 & \citealp{helm2023} \\
108 & narrative\_qa & .130 & .621 & [.392, .851] & .366 & .922 & 6 & \citealp{kocisky2017narrativeqa} \\
109 & dyck\_language & .138 & .660 & [.387, .933] & .398 & 1.000 & 6 & \citealp{helm2023} \\
110 & banking77 & .138 & .632 & [-.134, 1.399] & .278 & .846 & 3 & \citealp{casanueva2020efficient} \\
111 & financebench & .143 & .636 & [-.615, 1.887] & .055 & .943 & 3 & \citealp{islam2023financebench} \\
112 & bold & .149 & .679 & [.398, .960] & .146 & .870 & 6 & \citealp{dhamala2021bold} \\
113 & math & .155 & .545 & [.180, .909] & .130 & .992 & 6 & \citealp{sobhani2025mathmist} \\
114 & entity\_matching & .155 & .678 & [.400, .956] & .236 & .987 & 6 & \citealp{helm2023} \\
115 & the\_pile & .159 & .689 & [.328, 1.049] & .081 & 1.000 & 6 & \citealp{gao2020pile} \\
116 & hellaswag & .162 & .599 & [.329, .870] & .252 & .961 & 6 & \citealp{zellers2019hellaswag} \\
117 & fin\_qa & .164 & .658 & [-.324, 1.641] & .210 & .959 & 3 & \citealp{chen2021finqa} \\
118 & imdb & .168 & .690 & [.382, .998] & .288 & .948 & 6 & \citealp{maas2011learning} \\
119 & thaitoxicitytweets & .171 & .666 & [.098, 1.234] & .502 & .927 & 3 & \citealp{susanto2025sea}$^\dagger$ \\
120 & flores\_id\_en & .176 & .671 & [-.289, 1.631] & .228 & .935 & 3 & \citealp{costajussa2022no} \\
121 & flores\_vi\_en & .228 & .723 & [-.273, 1.720] & .260 & .967 & 3 & \citealp{costajussa2022no} \\
122 & civil\_comments & .241 & .764 & [.564, .964] & .528 & 1.000 & 6 & \citealp{borkan2019nuanced} \\
123 & flores\_ta\_en & .268 & .763 & [.514, 1.013] & .667 & .867 & 3 & \citealp{costajussa2022no} \\
124 & summarization\_cnndm & .325 & .855 & [.710, 1.001] & .618 & .987 & 6 & \citealp{hermann2015teaching} \\
\end{longtable}
\endgroup
```
