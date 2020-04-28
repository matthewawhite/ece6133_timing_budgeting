import matplotlib.pyplot as plt
import pandas as pd
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
import tensorflow_docs as tfdocs
import tensorflow_docs.plots
import tensorflow_docs.modeling

import sys

def normalize(x):
    return (x - train_stats['mean']) / train_stats['std']

def construct_nn():
    nn = keras.Sequential([
        layers.Dense(64, activation='sigmoid', input_shape=[len(train_data.keys())]),
        layers.Dense(64, activation='sigmoid'),
        layers.Dense(1)
    ])

    optimizer = tf.keras.optimizers.RMSprop(0.001)

    nn.compile(loss='mse',
                optimizer=optimizer,
                metrics=['mae', 'mse'])
    return nn

col = str(sys.argv[1])

frac_train = 0.7
epochs = 1000

column_names = ["top_slack", "tile_slack", "slack_delta", "driver_slack", "receiver_slack", \
                "delay_split", "available_time", "driver_delay", "receiver_delay", "driver_efo", \
                "receiver_efo", "efo_delta", "route_ratio", "efo_ratio"]

data = pd.read_csv("./AMD_data.csv", header=0, sep=",", skipinitialspace=True, index_col=0)
data = data.astype(float)

data.drop(data.columns[[9, 10]], axis=1, inplace=True)

train_data = data.sample(frac=frac_train, random_state=0)
test_data = data.drop(train_data.index)

train_labels = train_data.pop(col)
test_labels = test_data.pop(col)

train_stats = train_data.describe()
train_stats = train_stats.transpose()

normalized_train_data = normalize(train_data)
normalized_test_data = normalize(test_data)

nn = construct_nn()
print(nn.summary())

history = nn.fit(
  normalized_train_data, train_labels,
  epochs=epochs, validation_split=(1-frac_train), verbose=0,
  callbacks=[tfdocs.modeling.EpochDots()])

hist = pd.DataFrame(history.history)
hist['epoch'] = history.epoch

ylim_max = 1
if col == "route_ratio":
    ylim_max = 0.2

plotter = tfdocs.plots.HistoryPlotter(smoothing_std=2)
plotter.plot({'Basic': history}, metric = "mean_absolute_error")
plt.ylim([0, ylim_max])
plt.ylabel('MAE [' + col + ']')
plt.show()

filename = ("nn_mae-" + str(sys.argv[1]) + ".png")
plt.savefig(filename)
print('wrote figure to ' + filename)
