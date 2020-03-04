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

To run this script a working R environment with *Biostrings* and
*ggplot2* packages is necessary. The script generates in the same
directory three fasta files, ``x_train.fasta``, ``x_val.fasta``, and
``x_test.fasta`` and the distribution graph of sequences among Rfam
classes ``class-distribution.pdf`` shown in the paper.

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

With the `datasets.ipynb <datasets.ipynb>`__ Python notebook is possible
to create all the data necessary to run the experiments. The notebook is
selfexplained and generates for each combination of, boundary noise,
padding, and encoder, the corresponding train, val, and test sets saved
in numpy format in the same directory.

References
----------

.. container:: references hanging-indent
   :name: refs

   .. container::
      :name: ref-fiannaca2017nrc

      Fiannaca, Antonino, Massimo La Rosa, Laura La Paglia, Riccardo
      Rizzo, and Alfonso Urso. 2017. “NRC: Non-Coding Rna Classifier
      Based on Structural Features.” *BioData Mining* 10 (1): 27.
