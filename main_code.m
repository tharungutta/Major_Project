function main_code

clc; close all;

%% FIGURE
f = figure('Name','DWT-OFDM Image Transmission',...
    'Position',[100 50 1200 650],'Color',[0.95 0.95 0.95]);

%% AXES
handles.ax1 = axes('Parent',f,'Position',[0.05 0.55 0.2 0.35]); % Original
title('Original Image');
handles.ax2 = axes('Parent',f,'Position',[0.28 0.55 0.2 0.35]); % TX Signal
title('Transmitter Output');
handles.ax3 = axes('Parent',f,'Position',[0.51 0.55 0.2 0.35]); % Channel
title('Channel Output');
handles.ax4 = axes('Parent',f,'Position',[0.74 0.55 0.2 0.35]); % Received Image
title('Received Image');
handles.ax5 = axes('Parent',f,'Position',[0.3 0.1 0.4 0.3]); % Performance Graph
title('Performance Graph');

%% TITLE
uicontrol('Style','text','String','DWT-OFDM IMAGE TRANSMISSION SYSTEM',...
    'Units','normalized','Position',[0.3 0.95 0.4 0.05],...
    'FontSize',14,'FontWeight','bold','BackgroundColor',[0.23 0.4 0.15 0.06]);

%% BUTTONS
btn_color = [0.2 0.6 0.8];
uicontrol('Style','pushbutton','String','1. Load Image',...
    'Units','normalized','Position',[0.06 0.45 0.17 0.06],...
    'BackgroundColor',btn_color,'Callback',@loadImage);
uicontrol('Style','pushbutton','String','2. Transmitter',...
    'Units','normalized','Position',[0.3 0.45 0.17 0.06],...
    'BackgroundColor',btn_color,'Callback',@transmitter);
uicontrol('Style','pushbutton','String','3. Channel',...
    'Units','normalized','Position',[0.52 0.45 0.17 0.06],...
    'BackgroundColor',btn_color,'Callback',@channel);
uicontrol('Style','pushbutton','String','4. Receiver',...
    'Units','normalized','Position',[0.76 0.45 0.17 0.06],...
    'BackgroundColor',btn_color,'Callback',@receiver);
uicontrol('Style','pushbutton','String','5. Performance',...
    'Units','normalized','Position',[0.06 0.25 0.17 0.06],...
    'BackgroundColor',btn_color,'Callback',@performance);

%% STATUS
handles.status = uicontrol('Style','text','String','Status: Ready',...
    'Units','normalized','Position',[0.3 0.02 0.4 0.05],...
    'FontSize',12,'FontWeight','bold','BackgroundColor',[0.25 0.4 0.25 0.46]);
guidata(f,handles);
end

%% ================= FUNCTIONS =================

function loadImage(hObject,~)
handles = guidata(hObject);
[file,path] = uigetfile({'*.jpg;*.png;*.tif'});
img = imread(fullfile(path,file));
if size(img,3)==3
    img = rgb2gray(img);
end
img = imresize(img,[128 128]);
axes(handles.ax1); imshow(img);
handles.img = img;
handles.status.String = 'Image Loaded';
guidata(hObject,handles);
end

%% TRANSMITTER
function transmitter(hObject,~)
handles = guidata(hObject);
img = handles.img;
img_data = double(img(:));
bin_data = de2bi(img_data,8,'left-msb');
tx_bits = bin_data(:);
symbols = bi2de(reshape(tx_bits,[],2));
mod_data = pskmod(symbols,4,pi/4);
block_size = 64;
num_blocks = ceil(length(mod_data)/block_size);
pad_len = num_blocks*block_size - length(mod_data);
mod_data = [mod_data; zeros(pad_len,1)];
mod_blocks = reshape(mod_data,block_size,[]);
dwt_tx = [];
for k=1:size(mod_blocks,2)
    [cA,cD] = dwt(real(mod_blocks(:,k)),'haar');
    dwt_tx = [dwt_tx; cA; cD];
end
axes(handles.ax2);
plot(dwt_tx(1:200)); % show part of signal
title('Transmitter Output');
handles.tx_bits = tx_bits;
handles.dwt_tx = dwt_tx;
handles.status.String = 'Transmitter Done';
guidata(hObject,handles);
end

%% CHANNEL
function channel(hObject,~)
handles = guidata(hObject);
dwt_tx = handles.dwt_tx;
snr = 20;
rx_signal = awgn(dwt_tx,snr,'measured');
axes(handles.ax3);
plot(rx_signal(1:200));
title('Channel Output');
dwt_tx(abs(dwt_tx)<1e-6)=1e-6;
H_est = mean(rx_signal ./ dwt_tx);
eq_signal = rx_signal ./ H_est;
eq_signal(~isfinite(eq_signal))=0;
handles.eq_signal = eq_signal;
handles.status.String = 'Channel Done';
guidata(hObject,handles);
end

%% RECEIVER
function receiver(hObject,~)
handles = guidata(hObject);
eq_signal = handles.eq_signal;
tx_bits = handles.tx_bits;
img = handles.img;
block_size = 64;
rec_blocks = [];
idx = 1;
num_blocks = length(eq_signal)/block_size;
for k=1:num_blocks
    cA = eq_signal(idx:idx+(block_size/2-1));
    cD = eq_signal(idx+(block_size/2):idx+block_size-1);
    idx = idx + block_size;
    cA(~isfinite(cA))=0;
    cD(~isfinite(cD))=0;
    rec_block = idwt(cA,cD,'haar');
    rec_blocks = [rec_blocks; rec_block];
end
rec_signal = rec_blocks(:);
demod = pskdemod(rec_signal,4,pi/4);
rx_bits = de2bi(demod,2);
rx_bits = rx_bits(:);
rx_bits = rx_bits(1:length(tx_bits));
rx_pixels = bi2de(reshape(rx_bits,8,[]).','left-msb');
rx_img = reshape(uint8(rx_pixels),size(img));
axes(handles.ax4);
imshow(rx_img);
title('Recieved Image');
handles.rx_img = rx_img;
handles.status.String = 'Receiver Done';
guidata(hObject,handles);
end

%% PERFORMANCE
function performance(hObject,~)
handles = guidata(hObject);
img = handles.img;
rx_img = handles.rx_img;
mse_val = immse(img,rx_img);
psnr_val = psnr(rx_img,img);
% Show values
msgbox(sprintf('MSE: %.4f\nPSNR: %.2f dB',mse_val,psnr_val));
% Graph (SNR vs PSNR)
snr_range = 0:5:30;
psnr_vals = zeros(size(snr_range));
for i=1:length(snr_range)
    noisy = awgn(double(img),snr_range(i),'measured');
    psnr_vals(i) = psnr(uint8(noisy),img);
end
axes(handles.ax5);
plot(snr_range,psnr_vals,'-o');
xlabel('SNR');
ylabel('PSNR');
title('Performance Graph');
handles.status.String = 'Performance Displayed';
guidata(hObject,handles);
end