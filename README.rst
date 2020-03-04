.. raw:: html

   <!--- to be converter in rst first in order to add references at the end of this document --->

.. raw:: html

   <!--- pandoc README.md -o README.rst --bibliography=../../document.bib --->

Exploring non-coding RNA functions with deep learning tools
===========================================================

Scripts and datasets to reproduce the experiment reported in the paper

Datasets
========

Two datasets has been adopted in the experiments: a novel generated
dataset of sequences downloaded from Rfam database and the dataset made
public available by (Fiannaca et al. 2017). Raw data are available in
`datasets <datasets/>`__. The novel Rfam dataset need to be prepared
first with an R script available in
`dataset-preparation.R <datasets/Rfam-novel/dataset-preparation.R>`__.
The script must be executed in the same directory as:

.. code:: console

   Rscript dataset-preparation.R

The script generate three fasta files, ``x_train.fasta``,
``x_val.fasta``, and ``x_test.fasta`` and the distribution graph of
sequences among Rfam classes ``class-distribution.pdf`` shown in the
paper.

Experiments
===========

Prerequisites
-------------

To run the experiments a working python environment with the following
library installed:

-  tensorflow
-  sklearn
-  numpy
-  pickle
-  matplotlib
-  pandas

References
----------

.. container:: references hanging-indent
   :name: refs

   .. container::
      :name: ref-fiannaca2017nrc

      Fiannaca, Antonino, Massimo La Rosa, Laura La Paglia, Riccardo
      Rizzo, and Alfonso Urso. 2017. “NRC: Non-Coding Rna Classifier
      Based on Structural Features.” *BioData Mining* 10 (1): 27.
