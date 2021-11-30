global marker_size line_width font_size legend_pos
marker_size = 15;
line_width = 2;
font_size = 18;

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
experimentSet = 5

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
    if strcmp(algorithm, 'dilithium2')
        durationDil2(end+1) = data(i,8)
        ciDil2(end+1) = data(i,9)
        
    elseif strcmp(algorithm, 'dilithium3')
        durationDil3(end+1) = data(i,8)
        ciDil3(end+1) = data(i,9)

    elseif strcmp(algorithm, 'dilithium5')
        durationDil5(end+1) = data(i,8)
        ciDil5(end+1) = data(i,9)

    elseif strcmp(algorithm, 'falcon512')
        durationFal512(end+1) = data(i,8)
        ciFal512(end+1) = data(i,9)

    elseif strcmp(algorithm, 'falcon1024')
        durationFal1024(end+1) = data(i,8)
        ciFal1024(end+1) = data(i,9)

    elseif strcmp(algorithm, 'rsa')
        durationRsa(end+1) = data(i,8)
        ciRsa(end+1) = data(i,9)
    else
        disp(strcat('!!!!!!!! UNKNOWN ALGORITHM: ', algorithm))
    end
end

% Get the 5% in its correct spot
[x,sortIdx] = sort(x,'ascend');
durationDil2 = durationDil2(sortIdx);
durationDil3 = durationDil2(sortIdx);
durationDil5 = durationDil2(sortIdx);
durationFal512 = durationFal512(sortIdx);
durationFal1024 = durationFal1024(sortIdx);
durationRsa = durationRsa(sortIdx);

ciDil2 = ciDil2(sortIdx);
ciDil3 = ciDil2(sortIdx);
ciDil5 = ciDil2(sortIdx);
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















% 1 - the older 1000 samples
if experimentSet == 1

    xlabel('Network Drop Rate (%)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 10, 30, 40, 50, 60, 70, 80, 90, 100, 120, 140, 160])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 2 - TCP delay
elseif experimentSet == 2
    xlabel('Network Delay (ms)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 3 - QUIC delay
elseif experimentSet == 3
    xlabel('Network Delay (ms)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 4 - TCP drop
elseif experimentSet == 4
    xlabel('Network Drop Rate (%)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 5 - QUIC drop
elseif experimentSet == 5
    xlabel('Network Drop Rate (%)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 6 - TCP corrupt
elseif experimentSet == 6
    xlabel('Network Corruption Rate (%)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 7 - QUIC corrupt
elseif experimentSet == 7
    xlabel('Network Corruption Rate (%)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 8 - TCP duplicate
elseif experimentSet == 8
    xlabel('Network Duplication Rate (%)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 9 - QUIC duplicate
elseif experimentSet == 9
    xlabel('Network Duplication Rate (%)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 10 - TCP smaller delay steps
elseif experimentSet == 10
    xlabel('Network Delay (ms)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

    legend('TCP/TLS Dilithium 2', 'TCP/TLS Dilithium 3', 'TCP/TLS Dilithium 5', 'TCP/TLS Falcon 512', 'TCP/TLS Falcon 1024', 'TCP/TLS RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)

% 11 - QUIC smaller delay steps
elseif experimentSet == 11
    xlabel('Network Delay (ms)', 'FontSize', font_size)
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)

    yticks([0, 1, 10, 100, 1000])
    set(gca, 'YMinorTick','on', 'YMinorGrid','on')
    set(gca, 'XMinorTick','on', 'XMinorGrid','on')
    set(gca,'FontSize',font_size);
    set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

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