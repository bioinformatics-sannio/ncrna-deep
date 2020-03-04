.. raw:: html

   <!--- to be converter in rst first in order to add references at the end of this document --->

.. raw:: html

   <!--- pandoc README.md -o README.rst --bibliography=../../document.bib --->

Exploring non-coding RNA functions with deep learning tools
===========================================================

Scripts and datasets to reproduce the experiments reported in the paper

Datasets
========

Two datasets have been adopted in the experiments: *Rfam novel*, a novel
generated dataset of sequences downloaded from Rfam database; and
*RNAGCN/nRC*, the dataset made public available by (Fiannaca et al.
2017). Raw data are available in `datasets <datasets/>`__. The *Rfam
novel* dataset needs to be prepared first with an R script available in
`dataset-preparation.R <datasets/Rfam-novel/dataset-preparation.R>`__ to
generate the initial set of fasta files. The script must be executed in
the same directory as:

.. code:: console

   Rscript dataset-preparation.R

To run this script a working R environment with *Biostrings* and
*ggplot2* packages is necessary. The script generates in the same
directory three fasta files, ``x_train.fasta``, ``x_val.fasta``, and
``x_test.fasta`` adopted by the subsequent scripts and the distribution
graph of sequences among Rfam classes ``class-distribution.pdf`` shown
in the paper.

Experiments
===========

Prerequisites
-------------

To run the experiments a working Python environment with the following
libraries is necessary:

-  tensorflow
-  sklearn
-  numpy
-  pickle
-  matplotlib
-  pandas

Datasets preparation
--------------------

The Python notebook `datasets.ipynb <datasets.ipynb>`__ generates all
the data, in numpy format, necessary to run the experiments for both
*Rfam novel* and *RNAGCN/nRC* datasets. The notebook is self explained
and is able to create the necessary train, validation, and test sets for
each combination of boundary noise (0, 25, 50, 75, 100), padding (new,
random, constant), and encoder (K-mer, Snake, Morton, Hilbert).

*Rfam novel* experiments
------------------------

*RNAGCN/nRC* experiments
------------------------

Tables and Figures generation
-----------------------------

References
~~~~~~~~~~

.. container:: references hanging-indent
   :name: refs

   .. container::
      :name: ref-fiannaca2017nrc

      Fiannaca, Antonino, Massimo La Rosa, Laura La Paglia, Riccardo
      Rizzo, and Alfonso Urso. 2017. “NRC: Non-Coding Rna Classifier
      Based on Structural Features.” *BioData Mining* 10 (1): 27.
