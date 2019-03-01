# Signal Processing with Matlab

<p align="center">
  <img width="400" height="150" src="https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/matlab.png">
</p>

### Introduction
In this repository will be explained how to import audio files in matlab, filter, process, represent them and finally generate output audio files processed.
For this example will be used an audio signal got from NOAA-18 satellite.
The characteristics of the audio signal are the following:
- Input data rate: 48000 Hz or samples/s.
- Output data rate: 11025 Hz or samples/s.
- Relevant data frequency: 2.4 kHz.

### Starting with matlab
There are two scripts in matlab, *SignalProcess.m* and *main.m*.
#### SignalProcess

##### Description:
This script loads the audio into matlab as a vector variable with the samples, then takes two segments of the original audio file with a duration of 5 seconds and represents them in time and frequency. Its important to say that one of the segments are very noisy and the other one is very clearly. The objetive is to delete the noise of the noisy signal.

##### Code explain:
Watching at the code, it is presented diferents blocks. The first part loads the audio signal, define time and frequency domain and takes both segments from the original audio. Next block plots the raw clear and noisy signals. The following block implements four different Butterworth filters (Lowpass, Highpass, Bandpass, Anti-Bandpass), for this example only will be used lowpass and bandpass filters. After the filtering there is an amplification. The next block is the representation of the filtered and amplified signals and finally the last block write the audio samples to output files.

##### Running in matlab:
The audio file and the matlab script must be in the same directory, otherwise the audio file must be imported in matlab environment.

Now run on matlab and let´s study the results.
The first figure (1) represents the raw data.

<p align="center">
  <img width="1600" height="793" src="https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/signal_raw.png">
</p>

The *signal good* is the clearly signal and if observe fourier transform, the continous and 2.4kHz are really bigger than other frequencies.
The *signal noise* is the noisy signal and if observe the transform, the continous and 2.4kHz are bigger than other frequencies but the power distributed on the other frequencies are bigger too.

The filters will delete this frequencies that do not contain relevant data.

Now the second figure (2) represents the filtered signals.

<p align="center">
  <img width="1600" height="793" src="https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/signal_filtered.png">
</p>

The *signal good filtered* is still very clear, and in the frequency domain can be observed that all frequencies different than 2.4kHz are eliminated. That is correct.

The *signal noise filtered* is very much better in time domain than before and in the frequency domain can be observed that all frequencies different than 2.4kHz are eliminated. The result is very good.

Finally you can hear the raw samples and the processed samples and test it by yourself.