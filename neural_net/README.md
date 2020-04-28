This folder contains four Python scripts that plot different graphs based on the AMD data and the results of Tensorflow training. These four files are:
 - nn_pairplot.py
    - This shows a Kernel Density Estimation (KDE) plot for the data which is useful in observing if there are any easily discernable patterns in the data.
 - nn_histogram.py
    - Creates histogram with 25 bins showing the difference between the predicted values and true values.
 - nn_mae.py
    - Creates a plot showing how the mean absolute error of the predicted values changes as more epochs are used to train.
 - nn_predicted_vs_true.py
    - Creates a plot showing the predicted values versus the true values of the column being trained on

To run the software, several Python packages first need to be installed. If using the ECE servers follow the instructions below:
1.) bash
2.) virtualenv env
3.) source env/bin/activate
4.) pip3 install -r requirements.txt
5.) python3 [file_name] [column_name]

Examples:
python3 nn_histogram.py efo_ratio
python3 nn_predicted_vs_true.py route_ratio

The argument after the Python file name is the column being trained and predicted on. We focussed on efo_ratio and route_ratio since many of the other columns can be
calculated from the others using linear equations. The total list of column available to be trained on is:
["top_slack", "tile_slack", "slack_delta", "driver_slack", "receiver_slack", "delay_split", "available_time", "driver_delay", "receiver_delay", "driver_efo", "receiver_efo", "efo_delta", "route_ratio", "efo_ratio"]

To ensure that the plots show up, make sure to ssh into the server using the -XY flag to enable X11 forwarding (similar to running a Cadence/Synopsys tool's GUI remotely).
