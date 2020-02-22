from seqEncoders import *

# original dataset files
# generated with datasets/Rfam-novel/dataset-preparation.R
# Labels are in the description fasta line
fastaTrain = 'datasets/Rfam-novel/x_train.fasta'
fastaVal = 'datasets/Rfam-novel/x_val.fasta'
fastaTest = 'datasets/Rfam-novel/x_test.fasta'

kappas=[1,2,6]  # genome simulation multipliers (not used)
nlayers=[0,1,2,3]  # deep architecture layers
bnoise=[0,25,50,75,100] # boundary noise simulation
padds = ['random','constant','new'] # how padding is done

# Encoders configurations 
seqEncoders = (
               {'enc' : seq2Kmer,
                'filename' : '3mer',
                'param0' : [[50],3,['A','T','C','G']],
                'param25' : [[64],3,['A','T','C','G']],
                'param50' : [[75],3,['A','T','C','G']],
                'param75' : [[88],3,['A','T','C','G']],
                'param100' : [[100],3,['A','T','C','G']]
                          },
               {'enc' : seq2Kmer,
                'filename' : '2mer',
                'param0' : [[75],2,['A','T','C','G']],
                'param25' : [[95],2,['A','T','C','G']],
                'param50' : [[113],2,['A','T','C','G']],
                'param75' : [[132],2,['A','T','C','G']],
                'param100' : [[150],2,['A','T','C','G']]
                          },
               {'enc' : seq2Kmer,
                'filename' : '1mer',
                'param0' : [[150],1,['A','T','C','G']],
                'param25' : [[190],1,['A','T','C','G']],
                'param50' : [[225],1,['A','T','C','G']],
                'param75' : [[263],1,['A','T','C','G']],
                'param100' : [[300],1,['A','T','C','G']]
                          },               
               {'enc' : seq2Snake,
                'filename' : 'Snake',
                'param0' : [[13,13],['A','T','C','G']],
                'param25' : [[14,14],['A','T','C','G']],
                'param50' : [[15,15],['A','T','C','G']],
                'param75' : [[17,17],['A','T','C','G']],
                'param100' : [[18,18],['A','T','C','G']]
                          },
               {'enc' : seq2Morton,
                'filename' : 'Morton',
                'param0' : [[16,16],['A','T','C','G']],
                'param25' : [[16,16],['A','T','C','G']],
                'param50' : [[16,16],['A','T','C','G']],
                'param75' : [[32,32],['A','T','C','G']],
                'param100' : [[32,32],['A','T','C','G']]
                          },
               {'enc' : seq2Hilbert,
                'filename' : 'Hilbert',
                'param0' : [[16,16],['A','T','C','G']],
                'param25' : [[16,16],['A','T','C','G']],
                'param50' : [[16,16],['A','T','C','G']],
                'param75' : [[32,32],['A','T','C','G']],
                'param100' : [[32,32],['A','T','C','G']]
                          }
               )


