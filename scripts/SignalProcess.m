[s,fs] = audioread('signal.wav');
t = [0:1/fs:5-1/fs]; % fs = 48000, se resta 5-1/fs para que sean 240000 valores de tiempo (5s)
f = fs*[0:(240000/2)]/240000;

% DEFINITION OF PARAMETERS
% Samples selection
sgood_seconds = 420;     % 420s = 7min
sgood_width = 5;         % 5s signal width (240000 samples)
snoise_seconds = 175;    % 175s = 2min 55s
snoise_width = 5;        % 5s signal width (240000 samples)
% Filtering and gain
G = 2;  % Gain

sgood_low = fs * sgood_seconds;
sgood_high = sgood_low + fs * sgood_width;
snoise_low = fs * snoise_seconds;
snoise_high = snoise_low + fs * snoise_width;

sgood = s(sgood_low : sgood_high-1);    % 5 segundos de señal (240000 samples) centradas en el centro
snoise = s(snoise_low : snoise_high-1);    % 5 segundos de señal (240000 samples) desde 3s

% PLOT RAW SIGNAL
figure(1);
% Signal good
subplot(2,2,1);
plot(t, sgood, '-b');
axis([min(t) max(t) min(sgood)-0.5 max(sgood)+0.5]);
title('Signal good');
xlabel('Time (s)');
ylabel('Amplitude');
sgood_transform = fft(sgood);
P2 = abs(sgood_transform/240000);
P1 = P2(1:240000/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(2,2,3);
plot(f, P1, '-r');
title('Signal good transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Signal noise
subplot(2,2,2);
plot(t, snoise, '-b');
axis([min(t) max(t) min(snoise)-0.5 max(snoise)+0.5]);
title('Signal noise');
xlabel('Time (s)');
ylabel('Amplitude');
snoise_transform = fft(snoise);
P2 = abs(snoise_transform/240000);
P1 = P2(1:240000/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(2,2,4);
plot(f, P1, '-r');
title('Signal noise transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


% FILTERING AND AMPLIFYING
% Low pass filter parameters
f_lowcut = 2500;                  % 3000 Hz for lowpass filter cut frequency
fn_lowcut = f_lowcut/(fs/2);      % Normalize with sampling frequency
% Band pass filter parameters
f_bandcut = [80 2200];            % 3000 Hz for lowpass filter cut frequency
fn_bandcut = f_bandcut/(fs/2);    % Normalize with sampling frequency

% Lowpass filter
[zhi,phi,khi] = butter(20,fn_lowcut,'low'); %% zhi: zeros, phi: poles, k: gain
soshi = zp2sos(zhi,phi,khi);
sgood_filtered = sosfilt(soshi,sgood);
snoise_filtered = sosfilt(soshi,snoise);

% Highpass filter
%[zhi,phi,khi] = butter(20,fn,'high'); %% zhi: zeros, phi: poles, k: gain
%soshi = zp2sos(zhi,phi,khi);
%sgood_filtered = sosfilt(soshi,sgood_filtered);
%snoise_filtered = sosfilt(soshi,snoise_filtered);

% Anti Bandpass filter
[B,A] = butter(5,fn_bandcut, 'stop');
sgood_filtered = filter(B, A, sgood_filtered);
snoise_filtered = filter(B, A, snoise_filtered);

% Bandpass filter
%[B,A] = butter(5,fn_bandcut, 'bandpass');
%sgood_filtered = filter(B, A, sgood_filtered);
%snoise_filtered = filter(B, A, snoise_filtered);

% Amplification
sgood_filtered = G.*sgood_filtered;
snoise_filtered = G.*snoise_filtered;

% PLOT FILTERED SIGNAL
figure(2);
% Signal good filtered
subplot(2,2,1);
plot(t, sgood_filtered, '-b');
axis([min(t) max(t) min(sgood_filtered)-0.5 max(sgood_filtered)+0.5]);
title('Signal good filtered');
xlabel('Time (s)');
ylabel('Amplitude');
sgood_filtered_transform = fft(sgood_filtered);
P2 = abs(sgood_filtered_transform/240000);
P1 = P2(1:240000/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(2,2,3);
plot(f, P1, '-r');
title('Signal good filtered transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Signal noise filtered
subplot(2,2,2);
plot(t, snoise_filtered, '-b');
axis([min(t) max(t) min(snoise_filtered)-0.5 max(snoise_filtered)+0.5]);
title('Signal noise filtered');
xlabel('Time (s)');
ylabel('Amplitude');
snoise_filtered_transform = fft(snoise_filtered);
P2 = abs(snoise_filtered_transform/240000);
P1 = P2(1:240000/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(2,2,4);
plot(f, P1, '-r');
title('Signal noise filtered transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% WRITE AUDIO
audiowrite('signal_good.wav',sgood,fs);
audiowrite('signal_good_filtered.wav',sgood_filtered,fs);
audiowrite('signal_noise.wav',snoise,fs);
audiowrite('signal_noise_filtered.wav',snoise_filtered,fs);

%clear sound; pause(1);
%sound(snoise, fs);
%clear sound; pause(1);
%sound(snoise_filtered, fs);

