
clc
clear
load('GroupData_3.mat')


fs = 1/mean(diff(timevec)); % hz
npnts = length(timevec);

%% Determine signal
yOrig = original;
y = measurement;

% power spectrum of signal
yX = abs(fft(y)/npnts).^2;
hz = linspace(0,fs/2,floor(npnts/2)+1);

% plot the data
figure('position', [300, 100, 800, 600]);
subplot(211)
h = plot(timevec,y,'Color','blue'); hold on;
plot(timevec,yOrig,'linew',2,'color','red');
xlabel('time (sec.)'), ylabel('power')
title('Time domain','FontSize',14,'FontWeight','bold')
legend({'Measured','Original'})

% plot its power spectrum
subplot(212)
plot(hz,yX(1:length(hz)),'k','linew',1)
xlabel('Frequency (Hz)'), ylabel('Power')
title('Frequency domain of Measurement Signal','FontSize',14,'FontWeight','bold')
set(gca,'yscale','log') % log y scale to see more details


%%
%for finding fcutoff we need FFT of Measurement signal 
...which will be filtered
    
signalX = fft(y)/npnts;
hz = linspace(0,fs/2,floor(npnts/2)+1);

% amplitude
ampl = abs(signalX);
ampl(2:length(hz)) = 2*ampl(2:length(hz));

figure('position', [300, 100, 500, 400]);
stem(hz,ampl(1:length(hz)),'ks-','linew',3,'markersize',10);

% make plot look a bit nicer
set(gca,'xlim',[0 fs/2])
xlabel('Frequency (Hz)'), ylabel('Amplitude (a.u.)')
title('Frequency Domain of Original Signal','FontSize',14,'FontWeight','bold')

%%
% lowpass filter parameters
fcutoff =3; % cutoff frequency in Hz
transw = .6; % transition width
order = round(9* fs / fcutoff); % filter order
shape = [1 1 0 0]; % desired frequency response shape
frex = [0 fcutoff fcutoff + fcutoff * transw fs / 2] / (fs / 2);

% create filter kernel using least-squares method
filtkern = firls(order, frex, shape);

% compute the power spectrum of the filter kernel
filtkernX = abs(fft(filtkern, npnts)).^2;
hz = linspace(0, fs / 2, floor(npnts / 2) + 1);

% plotting
figure('position', [300, 100, 800, 600]);

subplot(321)
plot((-order / 2 : order / 2) / fs, filtkern, 'k', 'linew', 3, 'Color', 'blue')
xlabel('Time (s)')
title('Filter kernel','FontSize',12,'FontWeight','bold')

subplot(322), hold on
plot(frex * fs / 2, shape, 'r', 'linew', 1, 'Color', 'blue')
plot(hz, filtkernX(1 : length(hz)), 'k', 'linew', 2, 'Color', 'red')
set(gca, 'xlim', [0 60])
xlabel('Frequency (Hz)'), ylabel('Gain')
title('Filter kernel spectrum','FontSize',12,'FontWeight','bold')
legend({'Ideal', 'Actual'})

%%% now apply the filter to the data
yFilt = filtfilt(filtkern,1,y);
subplot(312)
h = plot(timevec,y,'Color','blue'); hold on;
plot(timevec,yFilt,'linew',2,'Color','red');
legend({'Measurement Signal','Filtered'})
xlabel('Time (sec.)'), ylabel('Amplitude')
title('Measurement signal vs Filtering Measurement Signal','FontSize',11,'FontWeight','bold')

%%% power spectra of original and filtered signal
yOrigX = abs(fft(y)/npnts).^2;
yFiltX = abs(fft(yFilt)/npnts).^2;

subplot(313)
plot(hz,yOrigX(1:length(hz)),'Color','blue'); hold on;
plot(hz,yFiltX(1:length(hz)),'Color','red','linew',2);
set(gca,'xlim',[0 fs/5],'yscale','log')
legend({'Signal','Filtered'})
xlabel('Frequency (Hz)'), ylabel('Power (log)')
hold off

%%
% Obtain the FFT of the filtered signal
yFilt_fft = fft(yFilt); 

% Apply inverse Fourier transform to filtered data
yFilt_ifft = ifft(yFilt_fft, 'symmetric');


% Plot to compare original and inverse-transformed filtered data

% Create and position the figure window
figure('position', [300, 100, 600, 450]);
% Plot the original dataset with a thick red line
plot(timevec, yOrig, 'r', 'LineWidth', 2); 
hold on;
% Plot the inverse-transformed filtered dataset with blue circles
plot(timevec, real(yFilt_ifft), 'b.', 'LineWidth', 1.5);
xlabel('Time (s)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Amplitude', 'FontSize', 12, 'FontWeight', 'bold');
legend({'Original', 'Inverse-Transformed Filtered'}, 'FontSize', 9);
title('Comparison of Original and Inverse-Transformed Filtered Data', 'FontSize', 14, 'FontWeight', 'bold');
grid on;



