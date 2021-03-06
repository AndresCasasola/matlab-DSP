
% Script for the Bioengineering course, grade in Electronic Systems Engineering in University of Malaga.
% Author: Andres Casasola Dominguez.

% This script loads ECG and Photoplethysmography signals from a csv file
% and makes multiple DSP operations to filter, plot time signals, plot FFT
% signals and also apply a threshold based algorithm to calculate heart
% rate with both signals.

% Sources and references:
% https://es.mathworks.com/matlabcentral/fileexchange/11755-peak-finding-and-measurement-2019
% https://es.mathworks.com/matlabcentral/fileexchange/73049-calculate-heart-rate-from-electrocardiogram-data

% Note: This scripts requires Signal Processing Toolbox

%% INIT
clear all;
[data1,fs] = audioread('original.mp3');
[data2,fs] = audioread('tomorrowland.wav');

% Constants
Ts = 1 / fs;            % Samples period
ThresholdECG = 4e6;     % ECG Peak detect threshold
ThresholdPhoto = 2e6;   % Photo Peak detect threshold
maxsize = 0;            %
if(maxsize == 1)
    offset = 1;
    size = 282000-1;
else
    offset = fs * 90;
    size = fs * 3;
end

% Variables
t = [0 : Ts : Ts * size];

%% GETTING DATA
% Get data
orig = data1(:,1);      % Original data
tom = data2(:,1);       % Tomorrowland data
% Cut signal interval
orig = orig(offset:offset + size);
tom = tom(offset:offset + size);

noisyECG = orig;
noisyPhoto = tom;

%% FILTERING
% Highpass filter
f_highcut = 10;                                     % (10Hz) Highpass filter cutoff frequency
fn_highcut = f_highcut / (fs / 2);
[zhi, phi, khi] = butter(1, fn_highcut, 'high');    % zhi: zeros, phi: poles, k: gain
soshi = zp2sos(zhi, phi, khi);
filteredECG = sosfilt(soshi, orig);

%% FFT
f = fs*[0:(length(noisyECG)/2)]/length(noisyECG);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ECG
% NoisyECG FFT
FFTnoisyECG = fft(noisyECG);
P2 = abs(FFTnoisyECG/length(noisyECG));
FFTnoisyECG = P2(1:length(noisyECG)/2+1);
FFTnoisyECG(2:end-1) = 2*FFTnoisyECG(2:end-1);
% FilteredECG FFT
FFTfilteredECG = fft(filteredECG);
P2 = abs(FFTfilteredECG/length(filteredECG));
FFTfilteredECG = P2(1:length(filteredECG)/2+1);
FFTfilteredECG(2:end-1) = 2*FFTfilteredECG(2:end-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PHOTO
% NoisyPhoto FFT
FFTnoisyPhoto = fft(noisyPhoto);
P2 = abs(FFTnoisyPhoto/length(noisyPhoto));
FFTnoisyPhoto = P2(1:length(noisyPhoto)/2+1);
FFTnoisyPhoto(2:end-1) = 2*FFTnoisyPhoto(2:end-1);

%% THRESHOLD ALGORITHM
% Get ECG local maxims
noisyismaxECG = islocalmax(noisyECG, 'MinProminence', ThresholdECG);
filteredismaxECG = islocalmax(filteredECG, 'MinProminence', ThresholdECG);
% Get Photo local maxims
noisyismaxPhoto = islocalmax(noisyPhoto, 'MinProminence', ThresholdPhoto);

%% HEART RATE
% Calculate heart rate ECG
% Noisy rate
maxIndices = find(noisyismaxECG);
msPerBeat = mean(diff(maxIndices));
noisyheartRateECG = 60*(1000/msPerBeat)
% Filtered rate
maxIndices = find(filteredismaxECG);
msPerBeat = mean(diff(maxIndices));
filteredheartRateECG = 60*(1000/msPerBeat)

% Calculate heart rate Photo
% Noisy rate
maxIndices = find(noisyismaxPhoto);
msPerBeat = mean(diff(maxIndices));
noisyheartRatePhoto = 60*(1000/msPerBeat)

%% PLOT SIGNALS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ECG
figure(1); hold on;

% NOISY PLOT 1
subplot(221); hold on;
plot(t*fs, noisyECG);
title('Noisy ECG');
xlabel('Time');
ylabel('Amplitude');
plot(find(noisyismaxECG), noisyECG(noisyismaxECG), '^', 'Color', [217 83 25]/255, 'MarkerFaceColor', [217 83 25]/255);
% NOISY PLOT 2
subplot(223); hold on;
plot(f, FFTnoisyECG, 'r');
axis([min(f) max(f)*0.2 min(FFTnoisyECG) max(FFTnoisyECG)*1.2]);
title('Noisy ECG FFT');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% FILTERED PLOT 1
subplot(222); hold on;
plot(t*fs, filteredECG);
title('Filtered ECG');
xlabel('Time');
ylabel('Amplitude');
plot(find(filteredismaxECG), filteredECG(filteredismaxECG), '^', 'Color', [217 83 25]/255, 'MarkerFaceColor', [217 83 25]/255);
% FILTERED PLOT 2
subplot(224); hold on;
plot(f, FFTfilteredECG, 'r');
axis([min(f) max(f)*0.2 min(FFTfilteredECG) max(FFTfilteredECG)*1.2]);
title('Filtered ECG FFT');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PHOTO
figure(2); hold on;

% NOISY PLOT 1
subplot(221); hold on;
plot(t*fs, noisyPhoto);
title('Noisy Photo');
xlabel('Time');
ylabel('Amplitude');
plot(find(noisyismaxPhoto), noisyPhoto(noisyismaxPhoto), '^', 'Color', [217 83 25]/255, 'MarkerFaceColor', [217 83 25]/255);
% NOISY PLOT 2
subplot(223); hold on;
plot(f, FFTnoisyPhoto, 'r');
axis([min(f) max(f)*0.2 min(FFTnoisyPhoto) max(FFTnoisyPhoto)*1.2]);
title('Noisy Photo FFT');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% NOISY PLOT 1
subplot(222); hold on;
plot(t*fs, noisyPhoto);
title('Noisy Photo');
xlabel('Time');
ylabel('Amplitude');
plot(find(noisyismaxPhoto), noisyPhoto(noisyismaxPhoto), '^', 'Color', [217 83 25]/255, 'MarkerFaceColor', [217 83 25]/255);
% NOISY PLOT 2
subplot(224); hold on;
plot(f, FFTnoisyPhoto, 'r');
axis([min(f) max(f)*0.2 min(FFTnoisyPhoto) max(FFTnoisyPhoto)*1.2]);
title('Noisy Photo FFT');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


%% AUDIO OUT
sound(noisyPhoto, fs);

