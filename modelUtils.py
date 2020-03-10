"""Provides utilities fro depp model construction."""
import tensorflow as tf
from tensorflow import keras

from tensorflow.keras.layers import LeakyReLU
# workaround to solve keras __name__ issue
LR = LeakyReLU()
LR.__name__ = 'relu'


def buildCNNModel(inshape,num_classes,nlayers=2,cnndim=2):
    n = 32
    model = keras.Sequential()
    for i in range(nlayers):
        if (i==0):
            if (cnndim==2):
                model.add(keras.layers.Conv2D(n*(2**(i)),(3),padding='same',input_shape=inshape, activation=LR))
            else:
                model.add(keras.layers.Conv1D(n*(2**(i)),(3),padding='same',input_shape=inshape, activation=LR))
        else:
            if (cnndim==2):
                model.add(keras.layers.Conv2D(n*(2**(i)),(3),padding='same',activation=LR))
            else:
                model.add(keras.layers.Conv1D(n*(2**(i)),(3),padding='same',activation=LR))
        if (cnndim==2):
            model.add(keras.layers.MaxPooling2D(2))
        else:
            model.add(keras.layers.MaxPooling1D(2))
        model.add(keras.layers.Dropout(rate=0.25))
        
    if (nlayers>0):
        model.add(keras.layers.Flatten())
    else:
        model.add(keras.layers.Dense(500, input_shape=inshape, activation=LR))

    model.add(keras.layers.Dense(1000, activation=LR))
    model.add(keras.layers.Dense(100, activation=LR))
    model.add(keras.layers.Dropout(rate=0.5))
    model.add(keras.layers.Dense(num_classes, activation=tf.nn.softmax))
    return model




def buildCNNModelImproved1D(inshape,num_classes):

    model = keras.Sequential()
    
    model.add(keras.layers.Conv1D(128,10,padding='same',input_shape=inshape))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    model.add(keras.layers.MaxPooling1D(2))

    model.add(keras.layers.Conv1D(128,10,padding='same'))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    model.add(keras.layers.MaxPooling1D(4))

    model.add(keras.layers.GaussianNoise(0.3))
    
    model.add(keras.layers.Conv1D(256,10,padding='same'))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    model.add(keras.layers.MaxPooling1D(2))

    model.add(keras.layers.Conv1D(256,10,padding='same'))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    model.add(keras.layers.MaxPooling1D(4))

    model.add(keras.layers.GaussianNoise(0.3))
    
    model.add(keras.layers.Conv1D(256,10,padding='same'))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    model.add(keras.layers.MaxPooling1D(4))
    model.add(keras.layers.GaussianNoise(0.3))
    
    model.add(keras.layers.Dropout(rate=0.2))
    
    model.add(keras.layers.Flatten())

    model.add(keras.layers.Dense(128))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    
    model.add(keras.layers.Dense(64))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))

    model.add(keras.layers.Dense(num_classes, activation=tf.nn.softmax))
    return model

def buildCNNModelImproved2D(inshape,num_classes):

    model = keras.Sequential()
    
    model.add(keras.layers.Conv2D(128,(3,3),padding='same',input_shape=inshape,
                                 kernel_regularizer=keras.regularizers.l2(0.003)))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))

    model.add(keras.layers.Conv2D(128,(3,3),padding='same'))   
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    model.add(keras.layers.MaxPooling2D((2,2)))

    model.add(keras.layers.GaussianNoise(0.3))
    
    model.add(keras.layers.Conv2D(256,(3,3),padding='same'))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    
    model.add(keras.layers.Conv2D(256,(3,3),padding='same'))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    model.add(keras.layers.MaxPooling2D((2,2)))

    model.add(keras.layers.GaussianNoise(0.3))
    
    model.add(keras.layers.Conv2D(256,(3,3),padding='same'))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    model.add(keras.layers.MaxPooling2D((2,2)))
    model.add(keras.layers.GaussianNoise(0.3))
    
    model.add(keras.layers.Dropout(rate=0.2))
    
    model.add(keras.layers.Flatten())

    model.add(keras.layers.Dense(128))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))
    
    model.add(keras.layers.Dense(64))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.LeakyReLU(alpha=0.5))

    model.add(keras.layers.Dense(num_classes, activation=tf.nn.softmax))
    return model


