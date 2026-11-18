# Discussion

## Uninterpretable hierarchical structure

Classically, cognitive sciences have approached intelligence from verbal, conceptual beginnings \citep{legg2007}. Intelligence is given a definition, then systems are developed according to the specs provided by the definition. This is not true in psychometric paradigms, which start by analyzing the covariance of performance measurements. Thus, adopting the psychometric approach for LLM benchmarks, our study has found that any substantially effective $G$ factor cannot be coherently approximated. Adding to this, tasks with similar contents, like mathematics and coding, do not necessarily cluster together. Machine intelligence does not follow any coherent structure or definition.

Unlike theories of human psychology \citep{schneider2018} where intelligence is explicitly assumed to possess higher-order structure, with fluid intelligence as one higher-order factor that has theoretical causal effects \citep{vandermaas2014} on the performance of other cognitive abilities, abilities in LLMs like abstract reasoning, domain memorization, and agentic tool use, are more likely to be horizontal with respect to each other with no clear higher-order structure. What higher-order structure exists are not likely to be .

%%
Establishing such causal mechanisms would be practically important. If there were no causal generalization, then no blanket improvement of abilities could be gained by improving one family of tasks. A generally-intelligent model can only be trained by including all relevant tasks in the training corpus, and there is no silver-bullet construct or ability that can be efficiently targeted in training that will causally improve aptitude in specific tasks. Such a model would require a brute-force, increasingly expansive training dataset until it covers the universe of all possible tasks.%%

## Related experimental evidence

\textcolor{red}{Factor analysis assumes a reflective data generating process, but it is strictly an analysis of correlations. The next question is whether such causality can be observed and exploited in practice. One way is to follow psychological science, where training participants in one cognitive task leads to observable improvements in a different task (hence, generalization) \citep{simons2016}. For LLMs, this means measuring a model's performance in coding, fine-tuning it to be better at mathematics, and then measuring its coding performance again.  There are prior studies of this sort which documents non-obvious ability transfers. Empirically, we categorize them into 3 sorts in relation to this hypothesis, described below.}

### Low-level primitive ability

\textcolor{red}{Prior experiments have provided some support for this hypothesis, describing that ability transfers occur through subtle shared representations. \citep{maniparambil2026when} ran a training experiment on OLMo3-7B where post-training exclusively on constraint-satisfaction puzzles raised pass@32 on OlymMATH-Hard from 16.0\% to 36.0\%, suggesting that transferable reasoning primitives rather than mathematical domain content underlie the gain. \citep{waheed2025on} found across 3,331 controlled fine-tuning experiments that syntactic style shapes downstream task gains in non-semantic ways, where Python-style training favors natural-language reasoning, while Java/Rust-style training favors mathematics.}

### Different-domain transfer

\textcolor{red}{Other documented transfers appear unpredictable from semantic domain alone. \citep{liu2025spiral} found that training Qwen3-4B-Base solely on Kuhn Poker self-play raised mathematical reasoning by 8.6 percentage points and general reasoning by 8.4 percentage points. \citep{fan2026nexttoken} trained a reward model on 11M tokens of math-focused web text and found overall RewardBench 2 accuracy rose by 7.6--8.3 percentage points over initialization, with gains of up to +16.1 on math subsets and consistent improvements on out-of-domain safety benchmarks. \citep{chung2026insightemb} trained an embedding model exclusively on mathematical reasoning data and found it transferred to ALFWorld, WebShop, and ScienceWorld agents, outperforming in-domain retrievers despite zero environment-specific training.}

### Same-domain forgetting

\textcolor{red}{Third, training on similar domains can actively hurt performance. \citep{dymkiewicz2026donors} found that single-source LoRA fine-tuning yields a mean change of −0.75−0.75 percentage points across tasks, with degradations typically larger than gains. The interference is directional, where adding one reasoning task to a training mix can lower accuracy on another task from the same corpus by 9--12 percentage points \citep{siboni2026helps}. Within coding, joint training on React, Vue, and Angular causes compilation failures because the model mixes their syntax \citep{ma2026phasewise}, and providing a Python reference for Cangjie code drops pass rates by 19.5 percentage points as the model adopts Python idioms the other compiler rejects \citep{cheng2026can}. Even two agent benchmarks collide: training on household-agent tasks slashes accuracy on another agent benchmark from 41.5\% to 6.6\% \citep{kong2026agentic}. Shared labels like "coding" or "agent reasoning'' do not prevent negative transfer.}

### Relating observational and experimental evidence

\textcolor{red}{In light of the experimental evidence, it is possible to. Table~\ref*{tab:transfer-mapping} makes the correspondence explicit.}

```{=latex}
\begin{longtable}{@{}p{0.32\textwidth}p{0.64\textwidth}@{}}
\caption{Correspondence between experimental transfer findings and our observational results.}\label{tab:transfer-mapping}\\
\toprule
Experimental finding & Our observations \\
\midrule
\endfirsthead
\caption[]{(continued)}\\
\toprule
Experimental finding & Our observations \\
\midrule
\endhead
\bottomrule
\endlastfoot
Transfer through low-level task representations & $G$ explains only a substantive share of variance ($\omega_h$ 0.04--0.76, ECV 0.11--0.52), but is domain-free \\
\midrule
Transfer from unrelated semantic domains & Miscellaneous benchmarks load highest on $G$; \texttt{arc} and \texttt{gpqa\_diamond} rank mid-table \\
\midrule
Negative transfer within similar domains & Same-subject benchmarks do not cluster (median cohesion $A$ near chance for \texttt{math}) \\
\end{longtable}
```

\textcolor{red}{With regards to this correspondence, several issues remain open. For one, there is a lack of evidence that singular low-level task representations can account for the universe of all (or at least, most) language model abilities. Moreover, it's not clear how fine-grained this low-level representation is. Available experimental evidence are limited to a few set of benchmarks with unknown reporting bias. Are reasoning-like primitives homogenous? If not, are they hierarchically structured such that there is a single reasoning-like latent variable that accounts for all of their variants? Our analysis suggests no to both, given how benchmarks rank on the $G$ loadings. On a similar vein, negative transfers of same-domain training should only exist if models do not group task representations by their semantic interpretability.}

\textcolor{red}{Nevertheless, factor analysis by itself is a strictly statistical observational procedure. Stronger evidence and a more final view of machine intelligence should be acquired by running empirical training experiments that 1. Tests a considerably higher number of benchmarks, 2. Analyze the heterogeneity of low-level representations (e.g., are there distinct reasoning-like primitives?), 3. Maps how tasks what kind of shared representation do tasks share with each other such that they are correlated. Such an experiment would be challenging to do, however, as there is no reliable way (as our observations suggest) to determine how many low-level representation there are, how correlated each of them are, and to what degree they are fundamental to model abilities.}

%%
## Alternative to a latent factor view

Through this paper we have shown that the implicitly causal model of intelligence yields an incoherent structure. However, factor analysis by itself is an analysis of correlations, and is merely compatible with a causal model. The formative paradigm, usually associated with PCA, makes no claim about the nature of the resultant components \citep{vandermaas2014}. Even so, generalizability would be impossible without a common factor to begin with, since two tasks sharing a dominant factor decompose into a similar lower-level representation \citep{caruana1997,menghi2025} that the network must discern. The mutualist paradigm \citep{borsboom2013}, which describes indicators as nodes in a graph of mutual causality, is harder to rule out, since a mutualist process (concretely described as simply a matrix of parial correlations without latent processes) reproduces a positive manifold without any common cause \citep{vandermaas2014}.

This view is attractive, as it does not require a supposedly parsimonious \citep{van2016} single latent variable to explain the origins of correlations (which, per our findings, are mostly unintelligible). The caveat, if this mechanism is correct, is that the $G$-oriented research program is untenable, as $G$ is merely a summary scalar and not a real, targetable ability. It also leaves inter-task correlations unintuitive and not bound by domain similarity. It is a more informative model, but it does not explain the uninterpretability of the correlation structure.

%%
