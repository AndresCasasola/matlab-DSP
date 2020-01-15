
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
data = load("signals.mat");
data = data.signals;

% Constants
fs = 1000;              % 1000 Samples/s
Ts = 1 / fs;            % Samples period
ThresholdECG = 4e6;     % ECG Peak detect threshold
ThresholdPhoto = 2e6;   % Photo Peak detect threshold
maxsize = 0;            % All data(1) or only a piece(0)

if(maxsize == 1)
    offset = 1;
    size = 282000-1;
else
    offset = 45000;
    size = 20000;
end

% Variables
t = [0 : Ts : Ts * size];

%% GETTING DATA
% Get ECG and Photo data
noisyPhoto = data(:,1);   % Photoplethysmography signal
noisyECG = data(:,2);     % ECG signal
% Cut signal interval
noisyPhoto = noisyPhoto{:,:};
noisyPhoto = noisyPhoto(offset:offset + size);
noisyECG = noisyECG{:,:};
noisyECG = noisyECG(offset:offset + size);

%% FILTERING
% Highpass filter
f_highcut = 10;                                     % (10Hz) Highpass filter cutoff frequency
fn_highcut = f_highcut / (fs / 2);
[zhi, phi, khi] = butter(1, fn_highcut, 'high');    % zhi: zeros, phi: poles, k: gain
soshi = zp2sos(zhi, phi, khi);
filteredECG = sosfilt(soshi, noisyECG);

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
instantRateECG = 60.*(1000./diff(maxIndices));
noisyheartRateECG = 60*(1000/msPerBeat)
% Filtered rate
maxIndices = find(filteredismaxECG);
msPerBeat = mean(diff(maxIndices));
filteredheartRateECG = 60*(1000/msPerBeat)

% Calculate heart rate Photo
% Noisy rate
maxIndices = find(noisyismaxPhoto);
msPerBeat = mean(diff(maxIndices));
instantRatePhoto = 60.*(1000./diff(maxIndices));
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
subplot(211); hold on;
plot(t*fs, noisyPhoto);
title('Noisy Photo');
xlabel('Time');
ylabel('Amplitude');
plot(find(noisyismaxPhoto), noisyPhoto(noisyismaxPhoto), '^', 'Color', [217 83 25]/255, 'MarkerFaceColor', [217 83 25]/255);
% NOISY PLOT 2
subplot(212); hold on;
plot(f, FFTnoisyPhoto, 'r');
axis([min(f) max(f)*0.2 min(FFTnoisyPhoto) max(FFTnoisyPhoto)*1.2]);
title('Noisy Photo FFT');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INSTANT RATE
figure(3); hold on;

% INSTANT RATE ECGnoisyismaxPhoto
subplot(211); hold on;
if(maxsize==0)
    instantRateECG(end+1) = instantRateECG(end);
else
    instantRateECG(end) = [];
end

plot(find(filteredismaxECG), instantRateECG);
plot(find(filteredismaxECG), instantRateECG, 'bo');
title('Instant Rate ECG');
xlabel('Time');
ylabel('Beats/s');
% INSTANT RATE PHOTO
subplot(212); hold on;
instantRatePhoto(end+1) = instantRatePhoto(end);
plot(find(noisyismaxPhoto), instantRatePhoto);
plot(find(noisyismaxPhoto), instantRatePhoto, 'bo');
title('Instant Rate Photo');
xlabel('Time');
ylabel('Beats/s');
