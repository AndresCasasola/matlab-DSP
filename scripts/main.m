filename = 'capture4.wav';
[s,fs] = audioread(filename);
t = [0:1/fs:5-1/fs]; % fs = 48000, se resta 5-1/fs para que sean 240000 valores de tiempo (5s)

% DEFINITION OF PARAMETERS
% Filtering and gain
G = 1;  % Gain

% FILTERING AND AMPLIFYING
% Low pass filter parameters
f_lowcut = 3000;                % 3000 Hz for lowpass filter cut frequency
fn_lowcut = f_lowcut/(fs/2);    % Normalize with sampling frequency
% Band pass filter parameters
f_bandcut = [200 2000];        % 3000 Hz for lowpass filter cut frequency
fn_bandcut = f_bandcut/(fs/2);    % Normalize with sampling frequency

% Lowpass filter
[zhi,phi,khi] = butter(20,fn_lowcut,'low'); %% zhi: zeros, phi: poles, k: gain
soshi = zp2sos(zhi,phi,khi);
s_filtered = sosfilt(soshi,s);

% Anti Bandpass filter
[B,A] = butter(5,fn_bandcut, 'stop');
s_filtered = filter(B, A, s_filtered);

% Amplification
s_filtered = G.*s_filtered;

% Transform sampling data rate from 48.000Hz to 11.200Hz
[P,Q] = rat(11025/fs, 0.0001);
s_filtered = resample(s_filtered, P, Q);


% WRITE AUDIO
audiowrite('capture4_filtered.wav', s_filtered, 11025);
