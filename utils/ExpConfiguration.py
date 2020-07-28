from utils.seqEncoders import *

# original dataset files
# generated with datasets/Rfam-novel/dataset-preparation.R
# Labels are in the description fasta line
fastaTrain = 'datasets/Rfam-novel/x_train.fasta'
fastaVal = 'datasets/Rfam-novel/x_val.fasta'
fastaTest = 'datasets/Rfam-novel/x_test.fasta'

nlayers=[0,1,2,3]  # deep architecture layers
bnoise=[0,25,50,75,100,125,150,175,200] # boundary noise simulation
t=[1,2,5,10] # number of random (non functional) seqs for each test seq
padds = ['random','constant','new'] # how padding is done

# Encoders configurations 
seqEncoders = (
               {'enc' : seq2Kmer,
                'filename' : '3mer',
                'param0' : [[67],3,['A','T','C','G']],
                'param25' : [[84],3,['A','T','C','G']],
                'param50' : [[100],3,['A','T','C','G']],
                'param75' : [[117],3,['A','T','C','G']],
                'param100' : [[134],3,['A','T','C','G']],
                'param125' : [[150],3,['A','T','C','G']],
                'param150' : [[167],3,['A','T','C','G']],
                'param175' : [[184],3,['A','T','C','G']],
                'param200' : [[200],3,['A','T','C','G']]
                          },
               {'enc' : seq2Kmer,
                'filename' : '2mer',
                'param0' : [[100],2,['A','T','C','G']],
                'param25' : [[125],2,['A','T','C','G']],
                'param50' : [[150],2,['A','T','C','G']],
                'param75' : [[175],2,['A','T','C','G']],
                'param100' : [[200],2,['A','T','C','G']],
                'param125' : [[225],2,['A','T','C','G']],
                'param150' : [[250],2,['A','T','C','G']],
                'param175' : [[275],2,['A','T','C','G']],
                'param200' : [[300],2,['A','T','C','G']]
                          },
               {'enc' : seq2Kmer,
                'filename' : '1mer',
                'param0' : [[200],1,['A','T','C','G']],
                'param25' : [[250],1,['A','T','C','G']],
                'param50' : [[300],1,['A','T','C','G']],
                'param75' : [[350],1,['A','T','C','G']],
                'param100' : [[400],1,['A','T','C','G']],
                'param125' : [[450],1,['A','T','C','G']],
                'param150' : [[500],1,['A','T','C','G']],
                'param175' : [[550],1,['A','T','C','G']],
                'param200' : [[600],1,['A','T','C','G']]
                          },               
               {'enc' : seq2Snake,
                'filename' : 'Snake',
                'param0' : [[15,15],['A','T','C','G']],
                'param25' : [[16,16],['A','T','C','G']],
                'param50' : [[18,18],['A','T','C','G']],
                'param75' : [[19,19],['A','T','C','G']],
                'param100' : [[20,20],['A','T','C','G']],
                'param125' : [[22,22],['A','T','C','G']],
                'param150' : [[23,23],['A','T','C','G']],
                'param175' : [[24,24],['A','T','C','G']],
                'param200' : [[25,25],['A','T','C','G']]
                          },
               {'enc' : seq2Morton,
                'filename' : 'Morton',
                'param0' : [[16,16],['A','T','C','G']],
                'param25' : [[16,16],['A','T','C','G']],
                'param50' : [[32,32],['A','T','C','G']],
                'param75' : [[32,32],['A','T','C','G']],
                'param100' : [[32,32],['A','T','C','G']],
                'param125' : [[32,32],['A','T','C','G']],
                'param150' : [[32,32],['A','T','C','G']],
                'param175' : [[32,32],['A','T','C','G']],
                'param200' : [[32,32],['A','T','C','G']]
                          },
               {'enc' : seq2Hilbert,
                'filename' : 'Hilbert',
                'param0' : [[16,16],['A','T','C','G']],
                'param25' : [[16,16],['A','T','C','G']],
                'param50' : [[32,32],['A','T','C','G']],
                'param75' : [[32,32],['A','T','C','G']],
                'param100' : [[32,32],['A','T','C','G']],
                'param125' : [[32,32],['A','T','C','G']],
                'param150' : [[32,32],['A','T','C','G']],
                'param175' : [[32,32],['A','T','C','G']],
                'param200' : [[32,32],['A','T','C','G']]
                          }
               )


