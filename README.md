# MultiPointer
This repository includes the code of the multi-representational parser with Pointer Networks described in the paper [Multitask Pointer Network for Multi-Representational Parsing](https://arxiv.org/abs/2009.09730). The implementation is based on the dependency parser by Ma et al. (2018) (https://github.com/XuezheMax/NeuroNLP2) and reuses part of its code.

### Requirements
This implementation requires Python 2.7, PyTorch 0.3.1 and Gensim >= 0.12.0 for the parser; and Python 3.3+, Cython 0.21+ and Numpy 1.6+ for the evaluation scripts that use EVALB and DISCODOP (https://github.com/andreasvc/disco-dop). The use of two different python virtual environments is advised.
  
### Data

Ask for the multi-representantional datasets so that you can easily reproduce paper's results.

### Experiments
To train the parser, just include the provided datasets and pre-trained word embeddings in ``data`` and ``embs`` folders, respectively; and, then, run the following script (in Python2) for each treebank that you want to work with:

    ./scripts/run_parser_<ptb|lctb|zctb|negra|tiger>.sh <model_name>

Finally, to decode augmented dependencies into constituent trees and compute F1 scores, just use the following script (in Python3), indicating the model name and the epoch of the best trained model on dev:

    ./scripts/eval_<ptb|lctb|zctb|negra|tiger>.sh <model_name> <best_epoch>

### Citation

    @misc{fernándezgonzález2020multitask,
      title={Multitask Pointer Network for Multi-Representational Parsing}, 
      author={Daniel Fernández-González and Carlos Gómez-Rodríguez},
      year={2020},
      eprint={2009.09730},
      archivePrefix={arXiv},
      primaryClass={cs.CL}
    }
    
### Acknowledgments
This work has received funding from the European Research Council (ERC), under the European Union's Horizon 2020 research and innovation programme (FASTPARSE, grant agreement No 714150), from the ANSWER-ASAP project (TIN2017-85160-C2-1-R) from MINECO, and from Xunta de Galicia (ED431B 2017/01). The CITIC research center has been funded by Xunta de Galicia and the European Union (European Regional Development Fund - Galicia 2014-2020 Program), by grant ED431G 2019/01.

### Contact
If you have any suggestion, inquiry or bug to report, please contact d.fgonzalez@udc.es
