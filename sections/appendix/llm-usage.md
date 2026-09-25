# The Use of Large Language Models

In ths work, we used large language models in four ways:

**First**, the analytical designs and choices of the study are partly informed by discussions with language models, particularly regarding the validity of methods initially selected by the authors.

**Second**, for writing. We drafted parts of this paper with AI assistance and used it to polish our own prose throughout. Every claim, number, and citation was written or checked by us, and we take full responsibility for the final text.

**Third**, for coding assistance. The corpus construction, densification, imputation, and factor-analysis pipelines were written with the same tool acting as a coding assistant. We reviewed the code it produced and verified its numerical output against the underlying data.

**Fourth**, for data collection. The corpus draws on evaluation results, benchmark documentation, and model metadata scattered across leaderboards, papers, repositories, and model cards, at a volume we could not read by hand. We used locally-run language models to extract and structure that material. We did not take those extractions on trust. Release-date provenance is recorded per row together with the class of evidence behind it, every dated answer carrying a citation was re-checked against the cited page, and the resulting verification rates and failure modes are reported in `\hyperref[release-date-provenance]{Appendix~\ref*{release-date-provenance}}`{=latex}.

No language model is an author of this work, and none contributed interpretation of results.

<!-- Section title follows the ICLR author guide's own wording for the required
LLM-usage statement ("The Use of Large Language Models"), which is also what the
ICLR template names the section. Other venues word it differently: NeurIPS uses
"LLM usage" and the ACL venues use "Use of AI Assistants". If ICLR 2027 changes
the wording in its call, retitle to match it exactly, since the statement is
checked against the call rather than read as prose.

Placed last in the appendix, which is the usual position. It is deliberately
specific about which of the three uses was checked and how, because the third
one (local models extracting corpus metadata) is the only one that feeds the
numbers, and a reader is entitled to know it was verified rather than trusted.
The cross-reference points at the Release-date provenance section, which carries
the 404-of-565 verification count and the three recurring failure modes. -->
