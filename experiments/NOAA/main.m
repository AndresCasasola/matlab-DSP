filename = 'signal.wav';
[s,fs] = audioread(filename);
t = [0:1/fs:5-1/fs];        % 5-1/fs to get 240000 time values (5s)

% DEFINITION OF PARAMETERS
G = 1;                  % Gain
f_lowcut = 2500;        % Lowpass filter cutoff frequency
f_highcut = 2300;       % Highpass filter cutoff frequency
datarate_out = 48000;   % Output audio datarate

% FILTERING AND AMPLIFYING
% Filters normalized frequency calculation
fn_lowcut = f_lowcut/(fs/2);      
fn_highcut = f_highcut/(fs/2);

% Lowpass filter
[zhi,phi,khi] = butter(20,fn_lowcut,'low'); %% zhi: zeros, phi: poles, k: gain
soshi = zp2sos(zhi,phi,khi);
s_filtered = sosfilt(soshi,s);

% Highpass filter
[zhi,phi,khi] = butter(20,fn_highcut,'high'); %% zhi: zeros, phi: poles, k: gain
soshi = zp2sos(zhi,phi,khi);
s_filtered = sosfilt(soshi,s_filtered);

% Amplification
s_filtered = G.*s_filtered;

% Transform sampling datarate from 48.000Hz to 11.200Hz
[P,Q] = rat(datarate_out/fs, 0.0001);
s_filtered = resample(s_filtered, P, Q);


% WRITE AUDIO
audiowrite('signal_filtered.wav', s_filtered, datarate_out);
