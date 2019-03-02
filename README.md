
# Signal Processing with Matlab

<p align="center">
  <img width="400" height="150" src="https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/matlab.png">
</p>

## Introduction
- In this repository will be explained how to import audio files in matlab, filter, amplify, represent them and finally generate output audio files processed.

For this example an audio signal obtained from the NOAA-18 satellite will be used.
The characteristics of the audio signal are the following:
- Audio data rate: 48000 Hz or samples/s.
- Relevant data frequency: 2.4 kHz.

The output audio data rate that matlab will return is by default programmed to 48000 Hz or samples/s.

## Starting with matlab
There are two scripts in matlab code, *SignalProcess.m* and *Main.m*.

<br>
<center><strong><font size="+2">Explaining SignalProcess.m</font></strong></center>

##### Description:
- This script loads the audio into matlab as a vector variable with the samples, then takes two segments of the original audio file with a duration of 5 seconds and represents them in time and frequency. Its important to say that one of the segments are very noisy and the other one is very clearly. The objetive is to delete the noise of the noisy signal.

##### Code explain:
Looking at the code, diferents blocks are presented.
1) The first part loads the audio signal, define time and frequency domain and takes a noisy segment and a clearly segment from the original audio. 
2) Next block represents both signals in raw format, with no modifications. 
3) The following block implements four different Butterworth filters (Lowpass, Highpass, Bandpass, Bandstop), for this example will be used lowpass and highpass filters. After the filtering there is an amplification. 
4) Next block is the representation of the filtered and amplified signals.
5) Finally the last block write the audio samples to output files.

##### Running on matlab:
The audio file and the matlab script must be in the same directory, otherwise the audio file must be imported in matlab environment.

Now run matlab and let's study the results.
The first figure (Figure 1, on matlab) represents the raw data.

![Figure 1](https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/signal_raw.png "Figure 1")

- *Signal good* is the clearly signal, looking at frequency domain the continuous and 2.4kHz frequencies are really bigger than other frequencies.
- *Signal noise* is the noisy signal and in the frequency domain the continuous and 2.4kHz frequencies are bigger than others, but the power distributed on those other frequencies are bigger than in the *signal good*.

The filters will delete those frequencies that do not contain relevant data.

Now the second figure (Figure 2, on matlab) represents the filtered signals.

![Figure 2](https://github.com/AndresCasasola/Matlab-SignalProcessing/raw/master/resources/images/signal_filtered.png "Figure 2")

- *Signal good filtered* is still very clear, and in the frequency domain can be observed that all frequencies different than 2.4kHz are eliminated. That is correct.

- *Signal noise filtered* is very much better in time domain than before and in the frequency domain can be observed that all frequencies different than 2.4kHz are eliminated. The result is very good.

Finally you can hear the raw samples and the processed samples and test it by yourself.


<center><strong><font size="+2">Explaining Main.m</font></strong></center>

##### Description:

*Main.m* is a modification of *SignalProcess.m*, it takes an audio file as input and process it according to the user's input parameters. Then it returns the full audio output file processed.

The parameters that the user can change are the following:
- Lowpass cutoff frequency for lowpass filter.
- Highpass cutoff frequency for highpass filter.
- Bandpass cutoff frequencies (lower and higher) for bandpass filter.
- Bandstop cutoff frequencies (lower and higher) for bandstop filter.
- Output gain.
- Output audio data rate.