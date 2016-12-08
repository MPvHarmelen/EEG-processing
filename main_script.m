% Column number to use for data cutting (mostly 10)
CUT_COL = 10;

% Number of time steps to include in each cut
WINDOW_BEFORE = 52;
WINDOW_AFTER = 1280;

% Amplitude used to cut TTL
TTL_CUT_AMP = 4;

% Filename
FILENAME = '/media/windows/Users/Martin/Documents/repos/EEG-processing/EEG recorder_2015v2.5/data/01-12-2016_13.31_v1_ppn4_meting1.mat.mat';

% Get filename
if isempty(FILENAME)
    [filename, pathname] = uigetfile({'*.mat';},'Select a 2D array');
    fprintf('filename: %s\n', filename);
    fprintf('pathname: %s\n', pathname);
    FILENAME = strcat(pathname, filename);
end


% Load data
load(FILENAME); % data is saved in the variable `data`

% data must be saved in the variable `data`, so overwrite is necessary
data = cut_data(data, CUT_COL, WINDOW_BEFORE, WINDOW_AFTER, TTL_CUT_AMP);

% Save data
fprintf('%i\n', size(data));
uisave({'data'},'Name');




% TODO: fix the following code

% Fast Fourier Transform code
% chanfft = channels to show / use
% test2 = #channels to show / use
% fs = frames per second = sample rate
% y = data
function plot_fft_Callback(hObject, eventdata, handles)
global fs; global chanfft; global data2;y = data2;
disp 'plot_fft_Callback';
fs = str2double(get(handles.fs,'String'))
chanfft = get(handles.chanfft,'String');
chanfft = eval(chanfft);
test2 = length(chanfft);

% Regular plot
h5 = figure;
        dur = length(y(:,chanfft(1)))/fs;
        time = [0:dur/length(y(:,chanfft(1))):dur]';
        time = time(1:length(y(:,chanfft(1))),1);
for k = 1:test2
        ax(k) = subplot(test2,1,k);
        plot(time,y(:,chanfft(k)),'b')
        ylabel('Amplitude (V)')
        linkaxes(ax,'x')
        if k ==1
            title('{\bf EEG of selected channels in the time domain}')
        end
end
xlabel('time (s)')

% FFT plot
h5 = figure;
        m = length(y(:,chanfft(1)));
        n = pow2(nextpow2(m));
for k = 1:test2
        ax2(k) = subplot(test2,1,k); % create the subplot
        dfty1 = fft(y(:,chanfft(k)),n); % do the transform? >> find fft documentation
        f = (0:n-1)*(fs/n); % correct x-axis for sample rate?
        p = dfty1.*conj(dfty1)/n;   % >> find conj documentation
        plot(f(1:floor(n/2)),p(1:floor(n/2)),'b')
        ylabel('FFT (V)')
        linkaxes(ax2,'x')
        if k ==1
            title('{\bf EEG of selected channels in the frequency domain}')
        end
end
xlabel('Frequency (Hz)')

% %% Filter data code
% % l1 = low frequency
% % h1 = high frequency
% % stop_on = whether to use a band-stop filter
% % pass_on = whether to use a band-pass filter
% % plot_on = whether to plot the result
% % power = power spectrum of data?
% % filter_data = both input as output data

% global l1; global h1;
% global filter_data;
% global Fs; Fs = 256;
% global power;
% global stop_on; global pass_on; global plot_on;
% l1 = str2double(get(handles.l1,'String'));
% h1 = str2double(get(handles.h1,'String'));
% fprintf('l1: %i\n', l1);
% fprintf('h1: %i\n', h1);
% if (get(handles.stop_on,'Value') == get(handles.stop_on,'Max'))
%     stop_on = 1;
% else
%     stop_on = 0;
% end
% fprintf('stop_on: %i\n', stop_on);
% if (get(handles.pass_on,'Value') == get(handles.pass_on,'Max'))
%     pass_on = 1;
% else
%     pass_on = 0;
% end
% fprintf('pass_on: %i\n', pass_on);
% if (get(handles.plot_on,'Value') == get(handles.plot_on,'Max'))
%     plot_on = 1;
% else
%     plot_on = 0;
% end
% fprintf('plot_on: %i\n', plot_on);
% [a b c] = size(filter_data);

% if (get(handles.eight_chan, 'Value') == get(handles.eight_chan, 'Max')) && b>8
%     b = 8;
%     % If data contains digital input channels (triggers) only apply filter to analog input,
%     % Jonas
% end

% if c>1
%    errordlg('This function only accepts vectors or 2D arrays','File Error');
% else
%     lb = l1/2; hb = h1/2;
%     for k = 1:b
%         NFFT = 2^nextpow2(a); % Next power of 2 from length of y
%         Y = fft(filter_data(:,k),NFFT)/a;
%         f = Fs/2*linspace(0,1,NFFT/2+1);
%         Ylb_1 = round(2*lb*length(Y)/Fs)+1;
%         Ylb_2 = length(Y)-round(2*lb*length(Y)/Fs)+1;
%         Yhb_1 = round(2*hb*length(Y)/Fs)+1;
%         Yhb_2 = length(Y)-round(2*hb*length(Y)/Fs)+1;
%             if stop_on == 1
%                 Y(Ylb_1:Yhb_1)=0;
%                 Y(Yhb_2:Ylb_2)=0;
%             end
%             if pass_on == 1
%                 Y(1:Ylb_1)=0;
%                 Y(Ylb_2:length(Y))=0;
%                 Y(Yhb_1:length(Y)/2)=0;
%                 Y(length(Y)/2:Yhb_2)=0;
%             end
%             fY = ifft(Y)*a; % Jonas edit: added '*a' in order to maintain signal scale
%             fY = fY(1:length(filter_data));
%             t = 1:length(fY);
%                 if plot_on == 1
%                     max_y1 = max(filter_data(:,k));
%                     min_y1 = min(filter_data(:,k));
%                     max_y2 = max(fY);
%                     min_y2 = min(fY);
%                     max_y = max([max_y1 max_y2]);
%                     min_y = min([min_y1 min_y2]);
%                     figure
%                     subplot(2,1,1)
%                     plot(t./Fs,filter_data(:,k))
%                     title('Original signal f(t)')
%                     ylim([min_y max_y]);
%                     subplot(2,1,2)
%                     plot(t./Fs,fY)
%                     title('Filtered signal f(t)')
%                     ylim([min_y max_y]);
%                     suptitle(['Time domain  channel/trial: ' num2str(k)])

%                     figure
%                     subplot(2,1,1)
%                     [a b c] = size(filter_data);
%                     NFFT = 2^nextpow2(a);
%                     Y = fft(filter_data(:,k),NFFT)/a;
%                     f = Fs/2*linspace(0,1,NFFT/2+1);
%                     plot(f,2*abs(Y(1:NFFT/2+1)))
%                     title('Original signal F(t)')
%                     subplot(2,1,2)
%                     [a b c] = size(fY);
%                     NFFT = 2^nextpow2(a);
%                     Y2 = fft(fY,NFFT)/a;
%                     f = Fs/2*linspace(0,1,NFFT/2+1);
%                     plot(f,2*abs(Y2(1:NFFT/2+1)))
%                     title('Filtered signal F(t)')
%                     suptitle(['Frequency domain  channel/trial: ' num2str(k)])
%                 end
%                 Y2 = fft(fY,NFFT)/a;
%                 selection = find(f>l1 & f<h1);
%                 power(k)= mean(2*abs(Y2(selection)));
%                 filter_data(:,k)= fY;
%     end
% end
% msgbox('Data filtered')
