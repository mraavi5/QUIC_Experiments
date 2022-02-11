global marker_size line_width font_size legend_pos
marker_size = 15;
line_width = 2;
font_size = 18;

% columnToPlot = 8 for handshake duration
% columnToPlot = 18 for number of handshake packets
% columnToPlot = 22 for number of handshake bytes
columnToPlot = 8

columnToPlotCI = columnToPlot + 1;

% 1 - the older 1000 samples
% 2 - TCP delay
% 3 - QUIC delay
% 4 - TCP drop
% 5 - QUIC drop
% 6 - TCP corrupt
% 7 - QUIC corrupt
% 8 - TCP duplicate
% 9 - QUIC duplicate
% 10 - TCP smaller delay steps
% 11 - QUIC smaller delay steps
% 12 - TCP 12-06-21 delay 100 samples
% 13 - QUIC 12-06-21 delay 100 samples
% 14 - TCP 12-06-21 drop 1000 samples
% 15 - QUIC 12-06-21 drop 1000 samples
% 16 - Winter break delay TCPTLS 1000 samples
% 17 - Winter break delay QUIC 1000 samples
experimentSet = 14

% 1 - the older 1000 samples
if experimentSet == 1
    data = readmatrix('QUIC\COMPUTED_AVERAGES_QUIC_1000_SAMPLES.csv');
    datastr = readtable('QUIC\COMPUTED_AVERAGES_QUIC_1000_SAMPLES.csv');
    x = [0 10 15 20 25 30 35 40 5]
    legend_pos = 'NorthWest';
    
% 2 - TCP delay
elseif experimentSet == 2
    data = readmatrix('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_delay\COMPUTED_AVERAGES.csv');
    datastr = readtable('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_delay\COMPUTED_AVERAGES.csv');
    x = [0 100 200 300 400 50]
    legend_pos = 'SouthEast';
    
% 3 - QUIC delay
elseif experimentSet == 3
    data = readmatrix('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_delay\COMPUTED_AVERAGES.csv');
    datastr = readtable('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_delay\COMPUTED_AVERAGES.csv');
    x = [0 100 200 300 400]
    legend_pos = 'SouthEast';

% 4 - TCP drop
elseif experimentSet == 4
    data = readmatrix('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_drop\COMPUTED_AVERAGES.csv');
    datastr = readtable('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_drop\COMPUTED_AVERAGES.csv');
    x = [0 10 20 40 5]
    legend_pos = 'SouthEast';
    
% 5 - QUIC drop
elseif experimentSet == 5
    data = readmatrix('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_drop\COMPUTED_AVERAGES.csv');
    datastr = readtable('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_drop\COMPUTED_AVERAGES.csv');
    x = [0 10 20 40 5]
    legend_pos = 'SouthEast';
    
% 6 - TCP corrupt
elseif experimentSet == 6
    data = readmatrix('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_corrupt\COMPUTED_AVERAGES.csv');
    datastr = readtable('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_corrupt\COMPUTED_AVERAGES.csv');
    x = [0 10 20 40 5]
    legend_pos = 'SouthEast';
    
% 7 - QUIC corrupt
elseif experimentSet == 7
    data = readmatrix('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_corrupt\COMPUTED_AVERAGES.csv');
    datastr = readtable('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_corrupt\COMPUTED_AVERAGES.csv');
    x = [0 10 20 40 5]
    legend_pos = 'SouthEast';
    
% 8 - TCP duplicate
elseif experimentSet == 8
    data = readmatrix('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_duplicate\COMPUTED_AVERAGES.csv');
    datastr = readtable('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_duplicate\COMPUTED_AVERAGES.csv');
    x = [0 10 20 40 5]
    legend_pos = 'SouthEast';
    
% 9 - QUIC duplicate
elseif experimentSet == 9
    data = readmatrix('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_duplicate\COMPUTED_AVERAGES.csv');
    datastr = readtable('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_duplicate\COMPUTED_AVERAGES.csv');
    x = [0 10 20 40 5]
    legend_pos = 'SouthEast';
    
% 10 - TCP smaller delay steps
elseif experimentSet == 10
    data = readmatrix('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_extra_delay\COMPUTED_AVERAGES.csv');
    datastr = readtable('TCPTLS\11-19-21_tcp_Local_Experiments\fullyAutomatedLogs_10_tcp_extra_delay\COMPUTED_AVERAGES.csv');
    x = [0 10 20 30 40 50]
    legend_pos = 'SouthEast';
    
% 11 - QUIC smaller delay steps
elseif experimentSet == 11
    data = readmatrix('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_extra_delay\COMPUTED_AVERAGES.csv');
    datastr = readtable('QUIC\11-19-21_quic_Local_Experiments\fullyAutomatedLogs_10_quic_extra_delay\COMPUTED_AVERAGES.csv');
    x = [0 10 20 30 40 50]
    legend_pos = 'SouthEast';

% 12 - TCP 12-06-21 delay 1000 samples
elseif experimentSet == 12
    data = readmatrix('TCPTLS\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_delay_TCPTLS\COMPUTED_AVERAGES.csv');
    datastr = readtable('TCPTLS\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_delay_TCPTLS\COMPUTED_AVERAGES.csv');
    x = [0 100 200 400 50]
    legend_pos = 'SouthEast';


% 13 - QUIC 12-06-21 delay 1000 samples
elseif experimentSet == 13
    data = readmatrix('QUIC\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_delay_QUIC\COMPUTED_AVERAGES.csv');
    datastr = readtable('QUIC\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_delay_QUIC\COMPUTED_AVERAGES.csv');
    x = [0 100 200 400 50]
    legend_pos = 'SouthEast';

% 14 - TCP 12-06-21 drop 1000 samples
elseif experimentSet == 14
    data = readmatrix('TCPTLS\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_drop_TCPTLS\COMPUTED_AVERAGES.csv');
    datastr = readtable('TCPTLS\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_drop_TCPTLS\COMPUTED_AVERAGES.csv');
    x = [0 10 20 40 5]
    legend_pos = 'NorthWest';


% 15 - QUIC 12-06-21 drop 1000 samples
elseif experimentSet == 15
    data = readmatrix('QUIC\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_drop_QUIC\COMPUTED_AVERAGES.csv');
    datastr = readtable('QUIC\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_drop_QUIC\COMPUTED_AVERAGES.csv');
    x = [0 10 20 40 5]
    legend_pos = 'NorthWest';


% 16 - Winter break delay TCPTLS 1000 samples
elseif experimentSet == 16
    data = readmatrix('Winter Break - Delay confirmation\TCPTLS\fullyAutomatedLogs_tcp_delays_12_30_2021\COMPUTED_AVERAGES.csv');
    datastr = readtable('Winter Break - Delay confirmation\TCPTLS\fullyAutomatedLogs_tcp_delays_12_30_2021\COMPUTED_AVERAGES.csv');
    x = [0 100 200 25 50]
    legend_pos = 'NorthWest';


% 17 - Winter break delay QUIC 1000 samples
elseif experimentSet == 17
    data = readmatrix('Winter Break - Delay confirmation\QUIC\fullyAutomatedLogs_quic_delays_12_28_2021\COMPUTED_AVERAGES.csv');
    datastr = readtable('Winter Break - Delay confirmation\QUIC\fullyAutomatedLogs_quic_delays_12_28_2021\COMPUTED_AVERAGES.csv');
    x = [0 100 200 25 50]
    legend_pos = 'NorthWest';
end


durationDil2 = []
durationDil3 = []
durationDil5 = []
durationFal512 = []
durationFal1024 = []
durationRsa = []

ciDil2 = []
ciDil3 = []
ciDil5 = []
ciFal512 = []
ciFal1024 = []
ciRsa = []

for i=1:height(datastr)
    disp(strcat('IT IS ', num2str(i)))
    algorithm = datastr{i,10}{1}
    if strcmp(algorithm, "dilithium2")
        durationDil2(end+1) = data(i,columnToPlot)
        ciDil2(end+1) = data(i,columnToPlotCI)
        
    elseif strcmp(algorithm, "dilithium3")
        durationDil3(end+1) = data(i,columnToPlot)
        ciDil3(end+1) = data(i,columnToPlotCI)

    elseif strcmp(algorithm, "dilithium5")
        durationDil5(end+1) = data(i,columnToPlot)
        ciDil5(end+1) = data(i,columnToPlotCI)

    elseif strcmp(algorithm, "falcon512")
        durationFal512(end+1) = data(i,columnToPlot)
        ciFal512(end+1) = data(i,columnToPlotCI)

    elseif strcmp(algorithm, "falcon1024")
        durationFal1024(end+1) = data(i,columnToPlot)
        ciFal1024(end+1) = data(i,columnToPlotCI)

    elseif strcmp(algorithm, "rsa")
        durationRsa(end+1) = data(i,columnToPlot)
        ciRsa(end+1) = data(i,columnToPlotCI)
    else
        disp(strcat("!!!!!!!! UNKNOWN ALGORITHM: ", algorithm))
        disp(algorithm)
        disp(algorithm)
        disp(algorithm)
    end
end

% Get the 5% in its correct spot
[x,sortIdx] = sort(x,'ascend');
durationDil2 = durationDil2(sortIdx);
durationDil3 = durationDil3(sortIdx);
durationDil5 = durationDil5(sortIdx);
durationFal512 = durationFal512(sortIdx);
durationFal1024 = durationFal1024(sortIdx);
durationRsa = durationRsa(sortIdx);


ciDil2 = ciDil2(sortIdx);
ciDil3 = ciDil3(sortIdx);
ciDil5 = ciDil5(sortIdx);
ciFal512 = ciFal512(sortIdx);
ciFal1024 = ciFal1024(sortIdx);
ciRsa = ciRsa(sortIdx);

hold on;
plotData(x, durationDil2, ciDil2)
plotData(x, durationDil3, ciDil3)
plotData(x, durationDil5, ciDil5)
plotData(x, durationFal512, ciFal512)
plotData(x, durationFal1024, ciFal1024)
plotData(x, durationRsa, ciRsa)

grid on
axis square











if columnToPlot == 8
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)
elseif columnToPlot == 18
    ylabel('Handshake Packets', 'FontSize', font_size)
elseif columnToPlot == 22
    ylabel('Handshake Size (B)', 'FontSize', font_size)
end




% 1 - the older 1000 samples
if experimentSet == 1

    xlabel('Network Drop Rate (%)', 'FontSize', font_size)

    yticks([0, 10, 30, 40, 50, 60, 70, 80, 90, 100, 120, 140, 160])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 2 - TCP delay
elseif experimentSet == 2
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 3 - QUIC delay
elseif experimentSet == 3
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 4 - TCP drop
elseif experimentSet == 4
    xlabel('Network Drop Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 5 - QUIC drop
elseif experimentSet == 5
    xlabel('Network Drop Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 6 - TCP corrupt
elseif experimentSet == 6
    xlabel('Network Corruption Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 7 - QUIC corrupt
elseif experimentSet == 7
    xlabel('Network Corruption Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 8 - TCP duplicate
elseif experimentSet == 8
    xlabel('Network Duplication Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 9 - QUIC duplicate
elseif experimentSet == 9
    xlabel('Network Duplication Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 10 - TCP smaller delay steps
elseif experimentSet == 10
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 11 - QUIC smaller delay steps
elseif experimentSet == 11
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)


% 12 - TCP 12-06-21 delay 100 samples
elseif experimentSet == 12
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 13 - QUIC 12-06-21 delay 100 samples
elseif experimentSet == 13
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 14 - TCP 12-06-21 drop 1000 samples
elseif experimentSet == 14
    xlabel('Network Drop Rate (%)', 'FontSize', font_size)

    yticks([0, 100, 200, 300, 400, 500, 600, 800, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');
    
    ylim([0, 500])

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 15 - QUIC 12-06-21 drop 1000 samples
elseif experimentSet == 15
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 100, 200, 300, 400, 500, 600, 800, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');
    
    ylim([0, 500])

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 16 - Winter break delay TCPTLS 1000 samples
elseif experimentSet == 16
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 200, 400, 600, 800, 1000, 1200])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');
    
    ylim([0, 1200])

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 17 - Winter break delay QUIC 1000 samples
elseif experimentSet == 17
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 200, 400, 600, 800, 1000, 1200])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');

    ylim([0, 1200])
    
    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)
end






function plotData(xarr, yarr, yciarr)
    global line_width
    
    p = plot(xarr, yarr, 'o-', 'LineWidth', line_width)
    return
    
    color = get(p, 'Color');
    hold on
    for i = 1:length(xarr)
        wid = 1
        x = xarr(i)
        y = yarr(i)
        yci = yciarr(i)
        %plot([x - wid, x + wid], [y - yci, y - yci], 'Color', color, 'LineWidth', line_width-1, 'HandleVisibility','off');
        %plot([x - wid, x + wid], [y + yci, y + yci], 'Color', color, 'LineWidth', line_width-1, 'HandleVisibility','off');
        %plot([x, x], [y - yci, y + yci], 'Color', color, 'LineWidth', line_width-1, 'HandleVisibility','off');
        plot(x, y, '.', 'Color', color, 'MarkerSize', line_width*10, 'HandleVisibility','off')
    end
end