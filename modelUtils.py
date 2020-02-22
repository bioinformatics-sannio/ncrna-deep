"""Provides utilities fro depp model construction."""
import tensorflow as tf
from tensorflow import keras


def buildCNNModel(inshape,num_classes,nlayers=2,cnndim=2):
    n = 32
    model = keras.Sequential()
    for i in range(nlayers):
        if (i==0):
            if (cnndim==2):
                model.add(keras.layers.Conv2D(n*(2**(i)),(3),padding='same',input_shape=inshape, activation=keras.layers.LeakyReLU()))
            else:
                model.add(keras.layers.Conv1D(n*(2**(i)),(3),padding='same',input_shape=inshape, activation=keras.layers.LeakyReLU()))
        else:
            if (cnndim==2):
                model.add(keras.layers.Conv2D(n*(2**(i)),(3),padding='same',activation=keras.layers.LeakyReLU()))
            else:
                model.add(keras.layers.Conv1D(n*(2**(i)),(3),padding='same',activation=keras.layers.LeakyReLU()))
        if (cnndim==2):
            model.add(keras.layers.MaxPooling2D(2))
        else:
            model.add(keras.layers.MaxPooling1D(2))
        model.add(keras.layers.Dropout(rate=0.25))
        
    if (nlayers>0):
        model.add(keras.layers.Flatten())
    else:
        model.add(keras.layers.Dense(500, input_shape=inshape, activation=keras.layers.LeakyReLU()))

    model.add(keras.layers.Dense(1000, activation=keras.layers.LeakyReLU()))
    model.add(keras.layers.Dense(100, activation=keras.layers.LeakyReLU()))
    model.add(keras.layers.Dropout(rate=0.5))
    model.add(keras.layers.Dense(num_classes, activation=tf.nn.softmax))
    return model


def buildCNNModel2(inshape,num_classes,nlayers=2,cnndim=2):
    n = 64
    model = keras.Sequential()
    for i in range(nlayers):
        if (i==0):
            if (cnndim==2):
                model.add(keras.layers.Conv2D(n*(2**(i)),(3),padding='same',input_shape=inshape, 
                                              kernel_regularizer=keras.regularizers.l2(0.003),
                                              activation=keras.layers.LeakyReLU()))
            else:
                model.add(keras.layers.Conv1D(n*(2**(i)),(3),padding='same',input_shape=inshape, 
                                              kernel_regularizer=keras.regularizers.l2(0.003),
                                              activation=keras.layers.LeakyReLU()))
        else:
            if (cnndim==2):
                model.add(keras.layers.Conv2D(n*(2**(i)),(3),padding='same',
                                              kernel_regularizer=keras.regularizers.l2(0.003),
                                              activation=keras.layers.LeakyReLU()))
            else:
                model.add(keras.layers.Conv1D(n*(2**(i)),(3),padding='same',
                                              kernel_regularizer=keras.regularizers.l2(0.003),
                                              activation=keras.layers.LeakyReLU()))
        model.add(keras.layers.BatchNormalization())
        
        if (cnndim==2):
            model.add(keras.layers.MaxPooling2D(2))
        else:
            model.add(keras.layers.MaxPooling1D(2))
        model.add(keras.layers.GaussianNoise(0.2))
        model.add(keras.layers.Dropout(rate=0.3))
        
    if (nlayers>0):
        model.add(keras.layers.Flatten())
    else:
        model.add(keras.layers.Dense(500, input_shape=inshape, activation=keras.layers.LeakyReLU()))

    model.add(keras.layers.Dense(1000, activation=keras.layers.LeakyReLU()))
    model.add(keras.layers.Dense(100, activation=keras.layers.LeakyReLU()))
    model.add(keras.layers.BatchNormalization())
    model.add(keras.layers.Dropout(rate=0.3))
    model.add(keras.layers.Dense(num_classes, activation=tf.nn.softmax))
    return model

