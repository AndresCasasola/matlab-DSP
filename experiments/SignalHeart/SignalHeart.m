s = load('short1-240Hz');

fs = 240;     % Hz
t = [0:1/fs:(length(s)/fs)-(1/fs)];     % Increments of 1/fs because in 1s there are fs samples, 
                                        % stop in (length(s)/fs)-(1/fs) because length(s) is the 
                                        % number of samples and dividing by fs, is obtained the 
                                        % duration in time. Then subtract 1/fs because the array 
                                        % started in 0, not in 1/fs.
f = fs*[0:(length(s)/2)]/length(s);

% DEFINITION OF PARAMETERS
% Filtering and gain
G = 1;                      % Gain
f_lowcut = 30;               % Lowpass filter cutoff frequency
f_highcut = 2300;           % Highpass filter cutoff frequency
f_bandpasscut = [2000 2800];% Bandpass filter cutoff frequencies
f_bandstopcut = [80 2200];  % Bandstop filter cutoff frequencies

% PLOT RAW SIGNAL
figure(1);
% Signal
subplot(2,1,1);
plot(t, s, '-b');
axis([min(t) max(t) 0 max(s)*1.2]);
title('Signal');
xlabel('Time (s)');
ylabel('Amplitude');

s_transform = fft(s);
P2 = abs(s_transform/length(s));
P1 = P2(1:length(s)/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(2,1,2);
plot(f, P1, '-r');
axis([min(f) max(f)-90 min(P1) max(P1)*1.2]);
title('Signal transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


% FILTERING AND AMPLIFYING
% Filters normalized frequency calculation
fn_lowcut = f_lowcut/(fs/2);      
%fn_highcut = f_highcut/(fs/2);
%fn_bandpasscut = f_bandpasscut/(fs/2);
%fn_bandstopcut = f_bandstopcut/(fs/2);

% Lowpass filter
[zhi,phi,khi] = butter(20,fn_lowcut,'low'); %% zhi: zeros, phi: poles, k: gain
soshi = zp2sos(zhi,phi,khi);
s_filtered = sosfilt(soshi,s);
%se_filtered = sosfilt(soshi,se);

% Highpass filter
%[zhi,phi,khi] = butter(20,fn_highcut,'high'); %% zhi: zeros, phi: poles, k: gain
%soshi = zp2sos(zhi,phi,khi);
%sa_filtered = sosfilt(soshi,sa_filtered);
%se_filtered = sosfilt(soshi,se_filtered);

% Anti Bandpass filter
%[B,A] = butter(5,fn_bandstopcut, 'stop');
%sgood_filtered = filter(B, A, sgood_filtered);
%snoise_filtered = filter(B, A, snoise_filtered);

% Bandpass filter
%[B,A] = butter(5,fn_bandpasscut, 'bandpass');
%sgood_filtered = filter(B, A, sgood_filtered);
%snoise_filtered = filter(B, A, snoise_filtered);

% Amplification
%sa = G.*sa;
%se = G.*se;

% PLOT FILTERED SIGNAL
figure(2);
% Signal filtered
subplot(2,1,1);
plot(t, s_filtered, '-b');
axis([min(t) max(t) 0 max(s)*1.2]);
title('Signal filtered');
xlabel('Time (s)');
ylabel('Amplitude');
s_filtered_transform = fft(s_filtered);
P2 = abs(s_filtered_transform/length(s));
P1 = P2(1:length(s)/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(2,1,2);
plot(f, P1, '-r');
axis([min(f) max(f)-90 min(P1) max(P1)*1.2]);
title('Signal filtered transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


