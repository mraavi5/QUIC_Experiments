global marker_size line_width font_size legend_pos
marker_size = 15;
line_width = 3;
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
experimentSet = 15

% Our paper uses experimentSet = [14, 15, 16, 17]

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
    %data = readmatrix('QUIC\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_drop_QUIC\COMPUTED_AVERAGES.csv');
    %datastr = readtable('QUIC\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_drop_QUIC\COMPUTED_AVERAGES.csv');
    data = readmatrix('QUIC\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_drop_QUIC\COMPUTED_AVERAGES_95.csv');
    datastr = readtable('QUIC\12-06-21_Droprate_Delay_FullyAutomatedLogs\fullyAutomatedLogs_drop_QUIC\COMPUTED_AVERAGES_95.csv');
    x = [0 10 20 40 5]
    legend_pos = 'NorthWest';


% 16 - Winter break delay TCPTLS 1000 samples
elseif experimentSet == 16
    data = readmatrix('Winter Break - Delay confirmation\TCPTLS\fullyAutomatedLogs_tcp_delays_12_30_2021\COMPUTED_AVERAGES_TCP.csv');
    datastr = readtable('Winter Break - Delay confirmation\TCPTLS\fullyAutomatedLogs_tcp_delays_12_30_2021\COMPUTED_AVERAGES_TCP.csv');
    x = [0 100 200 25 50]
    legend_pos = 'NorthWest';


% 17 - Winter break delay QUIC 1000 samples
elseif experimentSet == 17
    data = readmatrix('Winter Break - Delay confirmation\QUIC\fullyAutomatedLogs_quic_delays_12_28_2021\COMPUTED_AVERAGES_QUIC.csv');
    datastr = readtable('Winter Break - Delay confirmation\QUIC\fullyAutomatedLogs_quic_delays_12_28_2021\COMPUTED_AVERAGES_QUIC.csv');
    x = [0 100 200 25 50]
    legend_pos = 'NorthWest';
end


durationRsa = []
durationDil2 = []
durationDil3 = []
durationDil5 = []
durationFal512 = []
durationFal1024 = []

ciRsa = []
ciDil2 = []
ciDil3 = []
ciDil5 = []
ciFal512 = []
ciFal1024 = []

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
durationRsa = durationRsa(sortIdx);
durationDil2 = durationDil2(sortIdx);
durationDil3 = durationDil3(sortIdx);
durationDil5 = durationDil5(sortIdx);
durationFal512 = durationFal512(sortIdx);
durationFal1024 = durationFal1024(sortIdx);


ciRsa = ciRsa(sortIdx);
ciDil2 = ciDil2(sortIdx);
ciDil3 = ciDil3(sortIdx);
ciDil5 = ciDil5(sortIdx);
ciFal512 = ciFal512(sortIdx);
ciFal1024 = ciFal1024(sortIdx);


hold on;
plotData(x, durationRsa, ciRsa, "#45788C")
plotData(x, durationDil2, ciDil2, "#DAEAAD")
plotData(x, durationDil3, ciDil3, "#A7C4AB")
plotData(x, durationDil5, ciDil5, "#40372F")
plotData(x, durationFal512, ciFal512, "#F57153")
plotData(x, durationFal1024, ciFal1024, "#BF5841")

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

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 2 - TCP delay
elseif experimentSet == 2
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 3 - QUIC delay
elseif experimentSet == 3
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 4 - TCP drop
elseif experimentSet == 4
    xlabel('Network Drop Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 5 - QUIC drop
elseif experimentSet == 5
    xlabel('Network Drop Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 6 - TCP corrupt
elseif experimentSet == 6
    xlabel('Network Corruption Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 7 - QUIC corrupt
elseif experimentSet == 7
    xlabel('Network Corruption Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 8 - TCP duplicate
elseif experimentSet == 8
    xlabel('Network Duplication Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 9 - QUIC duplicate
elseif experimentSet == 9
    xlabel('Network Duplication Rate (%)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 10 - TCP smaller delay steps
elseif experimentSet == 10
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 11 - QUIC smaller delay steps
elseif experimentSet == 11
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  


% 12 - TCP 12-06-21 delay 100 samples
elseif experimentSet == 12
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 13 - QUIC 12-06-21 delay 100 samples
elseif experimentSet == 13
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

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

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

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

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 16 - Winter break delay TCPTLS 1000 samples
elseif experimentSet == 16
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 200, 400, 600, 800, 1000, 1200])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');
    
    ylim([0, 1350])

    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  

% 17 - Winter break delay QUIC 1000 samples
elseif experimentSet == 17
    xlabel('Network Delay (ms)', 'FontSize', font_size)

    yticks([0, 200, 400, 600, 800, 1000, 1200])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    %set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
    set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');

    ylim([0, 1350])
    
    legend('RSA 3072', 'Dilithium 2', 'Dilithium 3', 'Dilithium 5', 'Falcon 512', 'Falcon 1024', 'Location', legend_pos, 'FontSize', font_size - 4)  
end





% DRAW CONFIDENCE INTERVALS

xlimit = xlim()
wid = (xlimit(2) - xlimit(1)) / 30
    
hold on;
plotDataCI(x, durationRsa, ciRsa, wid, "#45788C")
plotDataCI(x, durationDil2, ciDil2, wid, "#DAEAAD")
plotDataCI(x, durationDil3, ciDil3, wid, "#A7C4AB")
plotDataCI(x, durationDil5, ciDil5, wid, "#40372F")
plotDataCI(x, durationFal512, ciFal512, wid, "#F57153")
plotDataCI(x, durationFal1024, ciFal1024, wid, "#BF5841")






function plotData(xarr, yarr, yciarr, color)
    global line_width
    
    p = plot(xarr, yarr, '-', "Color", color, 'LineWidth', line_width)
end

function plotDataCI(xarr, yarr, yciarr, wid, color)
    global line_width
    ci_line_width = 1
    
    %color = get(p, 'Color');
    hold on
    for i = 1:length(xarr)
        x = xarr(i)
        y = yarr(i)
        yci = yciarr(i)
        plot([x - wid, x + wid], [y - yci, y - yci], 'Color', color, 'LineWidth', ci_line_width, 'HandleVisibility','off');
        plot([x - wid, x + wid], [y + yci, y + yci], 'Color', color, 'LineWidth', ci_line_width, 'HandleVisibility','off');
        plot([x, x], [y - yci, y + yci], 'Color', color, 'LineWidth', ci_line_width, 'HandleVisibility','off');
        %plot(x, y, '.', 'Color', color, 'MarkerSize', line_width*10, 'HandleVisibility','off')
    end
end






















function [ rgb ] = hex2rgb(hex,range)
% hex2rgb converts hex color values to rgb arrays on the range 0 to 1. 
% 
% 
% * * * * * * * * * * * * * * * * * * * * 
% SYNTAX:
% rgb = hex2rgb(hex) returns rgb color values in an n x 3 array. Values are
%                    scaled from 0 to 1 by default. 
%                    
% rgb = hex2rgb(hex,256) returns RGB values scaled from 0 to 255. 
% 
% 
% * * * * * * * * * * * * * * * * * * * * 
% EXAMPLES: 
% 
% myrgbvalue = hex2rgb('#334D66')
%    = 0.2000    0.3020    0.4000
% 
% 
% myrgbvalue = hex2rgb('334D66')  % <-the # sign is optional 
%    = 0.2000    0.3020    0.4000
% 
%
% myRGBvalue = hex2rgb('#334D66',256)
%    = 51    77   102
% 
% 
% myhexvalues = ['#334D66';'#8099B3';'#CC9933';'#3333E6'];
% myrgbvalues = hex2rgb(myhexvalues)
%    =   0.2000    0.3020    0.4000
%        0.5020    0.6000    0.7020
%        0.8000    0.6000    0.2000
%        0.2000    0.2000    0.9020
% 
% 
% myhexvalues = ['#334D66';'#8099B3';'#CC9933';'#3333E6'];
% myRGBvalues = hex2rgb(myhexvalues,256)
%    =   51    77   102
%       128   153   179
%       204   153    51
%        51    51   230
% 
% HexValsAsACharacterArray = {'#334D66';'#8099B3';'#CC9933';'#3333E6'}; 
% rgbvals = hex2rgb(HexValsAsACharacterArray)
% 
% * * * * * * * * * * * * * * * * * * * * 
% Chad A. Greene, April 2014
%
% Updated August 2014: Functionality remains exactly the same, but it's a
% little more efficient and more robust. Thanks to Stephen Cobeldick for
% the improvement tips. In this update, the documentation now shows that
% the range may be set to 256. This is more intuitive than the previous
% style, which scaled values from 0 to 255 with range set to 255.  Now you
% can enter 256 or 255 for the range, and the answer will be the same--rgb
% values scaled from 0 to 255. Function now also accepts character arrays
% as input. 
% 
% * * * * * * * * * * * * * * * * * * * * 
% See also rgb2hex, dec2hex, hex2num, and ColorSpec. 
% 
%% Input checks:
assert(nargin>0&nargin<3,'hex2rgb function must have one or two inputs.') 
if nargin==2
    assert(isscalar(range)==1,'Range must be a scalar, either "1" to scale from 0 to 1 or "256" to scale from 0 to 255.')
end
%% Tweak inputs if necessary: 
if iscell(hex)
    assert(isvector(hex)==1,'Unexpected dimensions of input hex values.')
    
    % In case cell array elements are separated by a comma instead of a
    % semicolon, reshape hex:
    if isrow(hex)
        hex = hex'; 
    end
    
    % If input is cell, convert to matrix: 
    hex = cell2mat(hex);
end
if strcmpi(hex(1,1),'#')
    hex(:,1) = [];
end
if nargin == 1
    range = 1; 
end
%% Convert from hex to rgb: 
switch range
    case 1
        rgb = reshape(sscanf(hex.','%2x'),3,[]).'/255;
    case {255,256}
        rgb = reshape(sscanf(hex.','%2x'),3,[]).';
    
    otherwise
        error('Range must be either "1" to scale from 0 to 1 or "256" to scale from 0 to 255.')
end
end