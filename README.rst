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
public available by (Fiannaca et al. 2017).

.. code:: console

   Rscript dataset-preparation.R

this will generate three fasta files ``x_train.fasta``, ``x_val.fasta``,
and ``x_test.fasta`` and the distribution graph among Rfam classes
``class-distribution.pdf``.

References
----------

.. container:: references hanging-indent
   :name: refs

   .. container::
      :name: ref-fiannaca2017nrc

      Fiannaca, Antonino, Massimo La Rosa, Laura La Paglia, Riccardo
      Rizzo, and Alfonso Urso. 2017. “NRC: Non-Coding Rna Classifier
      Based on Structural Features.” *BioData Mining* 10 (1): 27.
