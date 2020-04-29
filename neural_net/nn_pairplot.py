import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

frac_train = 0.7

column_names = ["top_slack", "tile_slack", "slack_delta", "driver_slack", "receiver_slack", \
                "delay_split", "available_time", "driver_delay", "receiver_delay", "driver_efo", \
                "receiver_efo", "efo_delta", "route_ratio", "efo_ratio"]

data = pd.read_csv("./AMD_data.csv", header=0, sep=",", skipinitialspace=True, index_col=0)
data = data.astype(float)

data.drop(data.columns[[9, 10]], axis=1, inplace=True)

train_data = data.sample(frac=frac_train, random_state=0)

sns.pairplot(train_data[["slack_delta", "delay_split", "efo_ratio", "route_ratio"]], diag_kind="kde")
plt.show()
plt.savefig("nn_pairplot.png")
print('wrote figure to nn_pairplot.png')

