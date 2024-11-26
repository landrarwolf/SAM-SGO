# Paper Title: Self-adaptive multi-measure unsupervised feature selection method with structured graph optimization [SAM-SGO]

## Abstract
Unsupervised feature selection attracts much attention in the field of machine learning, which is very important for dimensionality reduction and classification of high-dimensional data. The similarity between data points can be measured by several different functions, which results in the inconsistency of the similarity between different data points. Moreover, in existing methods the similar matrices are most obtained by allocation of neighbors; thus, the number of connected components is usually not ideal. To address these problems, a novel adaptive multi metric fusion method SAM-SGO(Self-adaptive multi-measure unsupervised feature selection with structured graph optimization) was proposed, which regards the similarity matrix as a varying one rather than a preset one. By fusing different measurement functions into a unified measurement adaptively, various measurement methods can be synthesized, and the similarity matrix of data can be obtained adaptively, and the relationship between data points can be captured more accurately. In order to obtain an ideal graph structure, a constraint was imposed on the rank of similarity matrix to optimize the local structure of the graph and simplify the calculation. In addition, sparsity-inducing regularization was introduced to obtain the sparse projection for feature selection. Experiments on several standard datasets demonstrate the effectiveness of SAM-SGO. Compared with LLCFS(Local Learning-based Clustering Feature Selection), DGUFS(Dependence Guided Unsupervised Feature Selection) and SOGFS(Structured Optimal Graph Feature Selection) proposed in recent years, the clustering accuracy of SAM-SGO is improved by about 3.6 percentage points.

## Publication Information
- **Publication Date**: [2021-05]

## Keywords
Adaptive multi-measure; Structured graph optimization; Subspace learning; Sparse regularization constraints; Unsupervised feature selection



## How to Cite
If you find this work useful for your research, please cite it using the following BibTeX entry:

```bibtex
@article{lin2021self,
  title={Self-adaptive multi-measure unsupervised feature selection method with structured graph optimization},
  author={LIN, Junchao and WAN, Yuan},
  journal={Journal of Computer Applications},
  volume={41},
  number={5},
  pages={1282},
  year={2021}
}
