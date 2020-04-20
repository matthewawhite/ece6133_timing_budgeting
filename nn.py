import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
import tensorflow_docs as tfdocs
import tensorflow_docs.plots
import tensorflow_docs.modeling

column_names = ["top_slack", "tile_slack", "slack_delta", "driver_slack", "receiver_slack", \
                "delay_split", "available_time", "driver_delay", "receiver_delay", "driver_efo", \
                "receiver_efo", "efo_delta", "route_ratio"]

data = pd.read_csv("./AMD_data.csv", names=column_names, sep=",", skipinitialspace=True, use_cols=column_names)
data.tail()

