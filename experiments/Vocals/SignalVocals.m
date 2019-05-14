[sa_,fs] = audioread('VocalA.mp3');
[se_,fs] = audioread('VocalE.mp3');
[si_,fs] = audioread('VocalI.mp3');
[so_,fs] = audioread('VocalO.mp3');
[su_,fs] = audioread('VocalU.mp3');
samples_duration = 3;
totalsamples = samples_duration * fs;
transform_limits = [0 5000];
t = [0:1/fs:samples_duration-1/fs];
f = fs*[0:(totalsamples/2)]/totalsamples;

% DEFINITION OF PARAMETERS
% Samples timing parameters
sa_seconds = 2;
sa_width = samples_duration;
se_seconds = 2;
se_width = samples_duration;
si_seconds = 2;
si_width = samples_duration;
so_seconds = 2;
so_width = samples_duration;
su_seconds = 2;
su_width = samples_duration;

% Samples timing limits
sa_low = fs * sa_seconds;
sa_high = sa_low + fs * sa_width;
se_low = fs * se_seconds;
se_high = se_low + fs * se_width;
si_low = fs * si_seconds;
si_high = si_low + fs * si_width;
so_low = fs * so_seconds;
so_high = so_low + fs * so_width;
su_low = fs * su_seconds;
su_high = su_low + fs * su_width;

% Getting samples segments
sa = sa_(sa_low : sa_high-1);
se = se_(se_low : se_high-1);
si = si_(si_low : si_high-1);
so = so_(so_low : so_high-1);
su = su_(su_low : su_high-1);

% PLOT SIGNALS
figure(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Vocal A
subplot(1,2,1);
plot(t, sa, '-b');
axis([max(t)/2 max(t)/2+0.03 min(sa)*1.2 max(sa)*1.2]);
title('Vocal A');
xlabel('Time (s)');
ylabel('Amplitude');
s_transform = fft(sa);
P2 = abs(s_transform/totalsamples); % Normalize
P1 = P2(1:totalsamples/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(1,2,2);
plot(f, P1, '-r');
axis([transform_limits min(P1) max(P1)]);
title('Vocal A transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Vocal E
figure(2);
subplot(1,2,1);
plot(t, se, '-b');
axis([max(t)/2 max(t)/2+0.03 min(se)*1.2 max(se)*1.2]);
title('Vocal E');
xlabel('Time (s)');
ylabel('Amplitude');
s_transform = fft(se);
P2 = abs(s_transform/totalsamples);
P1 = P2(1:totalsamples/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(1,2,2);
plot(f, P1, '-r');
axis([transform_limits min(P1) max(P1)]);
title('Vocal E transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Vocal I
figure(3);
subplot(1,2,1);
plot(t, si, '-b');
axis([max(t)/2 max(t)/2+0.03 min(si)*1.2 max(si)*1.2]);
title('Vocal I');
xlabel('Time (s)');
ylabel('Amplitude');
s_transform = fft(si);
P2 = abs(s_transform/totalsamples);
P1 = P2(1:totalsamples/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(1,2,2);
plot(f, P1, '-r');
axis([transform_limits min(P1) max(P1)]);
title('Vocal I transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Vocal O
figure(4);
subplot(1,2,1);
plot(t, so, '-b');
axis([max(t)/2 max(t)/2+0.03 min(so)*1.2 max(so)*1.2]);
title('Vocal O');
xlabel('Time (s)');
ylabel('Amplitude');
s_transform = fft(so);
P2 = abs(s_transform/totalsamples);
P1 = P2(1:totalsamples/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(1,2,2);
plot(f, P1, '-r');
axis([transform_limits min(P1) max(P1)]);
title('Vocal O transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Vocal U
figure(5);
subplot(1,2,1);
plot(t, su, '-b');
axis([max(t)/2 max(t)/2+0.03 min(su)*1.2 max(su)*1.2]);
title('Vocal U');
xlabel('Time (s)');
ylabel('Amplitude');
s_transform = fft(su);
P2 = abs(s_transform/totalsamples);
P1 = P2(1:totalsamples/2+1);
P1(2:end-1) = 2*P1(2:end-1);
subplot(1,2,2);
plot(f, P1, '-r');
axis([transform_limits min(P1) max(P1)]);
title('Vocal U transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
