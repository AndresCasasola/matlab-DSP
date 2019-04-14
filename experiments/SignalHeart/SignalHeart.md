
# ECG Signal Processing

## Introduction
In this experiment, will be processed ECG (Electrocardiography) signals obtained from a data aquisition system based on TM4C123G microcontroller. The aquisition application used is in this [repository](https://github.com/AndresCasasola/freeRTOS-projects).

### Sensors positioning
To measure the heart signal, electrodes must be placed in fairly accurate positions. In this experiment it has been used the positions showed in the following figure.

![Figure 1](https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/heartelectrodes.png "Figure 1")

Only one leg electrode is used as reference voltage.

### Obtained signals

Studying the signal *short1-240Hz*. 

The raw signal is the following:

![Figure 2](https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/heartsignal_raw.png "Figure 2")

By applying some filters, the following signal has been obtained:

![Figure 3](https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/heartsignal_filtered.png "Figure 3")
