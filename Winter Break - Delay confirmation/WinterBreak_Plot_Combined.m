% Winter Break - Delay confirmation

global marker_size line_width font_size legend_pos
marker_size = 15;
line_width = 2;
font_size = 18;

% columnToPlot = 8 for handshake duration
% columnToPlot = 18 for number of handshake packets
% columnToPlot = 22 for number of handshake bytes
columnToPlot = 8

columnToPlotCI = columnToPlot + 1;

data1 = readmatrix('TCPTLS\fullyAutomatedLogs_tcp_delays_12_30_2021\COMPUTED_AVERAGES.csv');
datastr1 = readtable('TCPTLS\fullyAutomatedLogs_tcp_delays_12_30_2021\COMPUTED_AVERAGES.csv');

data2 = readmatrix('QUIC\fullyAutomatedLogs_quic_delays_12_28_2021\COMPUTED_AVERAGES.csv');
datastr2 = readtable('QUIC\fullyAutomatedLogs_quic_delays_12_28_2021\COMPUTED_AVERAGES.csv');

x = [0 100 200 25 50]
legend_pos = 'NorthWest';


durationDil21 = []
durationDil31 = []
durationDil51 = []
durationFal5121 = []
durationFal10241 = []
durationRsa1 = []

ciDil21 = []
ciDil31 = []
ciDil51 = []
ciFal5121 = []
ciFal10241 = []
ciRsa1 = []

durationDil22 = []
durationDil32 = []
durationDil52 = []
durationFal5122 = []
durationFal10242 = []
durationRsa2 = []

ciDil22 = []
ciDil32 = []
ciDil52 = []
ciFal5122 = []
ciFal10242 = []
ciRsa2 = []

for i=1:height(datastr1)
    disp(strcat('IT IS ', num2str(i)))
    algorithm = datastr1{i,10}{1}
    if strcmp(algorithm, "dilithium2")
        durationDil21(end+1) = data1(i,columnToPlot)
        ciDil21(end+1) = data1(i,columnToPlotCI)
        
    elseif strcmp(algorithm, "dilithium3")
        durationDil31(end+1) = data1(i,columnToPlot)
        ciDil31(end+1) = data1(i,columnToPlotCI)

    elseif strcmp(algorithm, "dilithium5")
        durationDil51(end+1) = data1(i,columnToPlot)
        ciDil51(end+1) = data1(i,columnToPlotCI)

    elseif strcmp(algorithm, "falcon512")
        durationFal5121(end+1) = data1(i,columnToPlot)
        ciFal5121(end+1) = data1(i,columnToPlotCI)

    elseif strcmp(algorithm, "falcon1024")
        durationFal10241(end+1) = data1(i,columnToPlot)
        ciFal10241(end+1) = data1(i,columnToPlotCI)

    elseif strcmp(algorithm, "rsa")
        durationRsa1(end+1) = data1(i,columnToPlot)
        ciRsa1(end+1) = data1(i,columnToPlotCI)
    else
        disp(strcat("!!!!!!!! UNKNOWN ALGORITHM: ", algorithm))
        disp(algorithm)
        disp(algorithm)
        disp(algorithm)
    end
end

for i=1:height(datastr2)
    disp(strcat('IT IS ', num2str(i)))
    algorithm = datastr2{i,10}{1}
    if strcmp(algorithm, "dilithium2")
        durationDil22(end+1) = data2(i,columnToPlot)
        ciDil22(end+1) = data2(i,columnToPlotCI)
        
    elseif strcmp(algorithm, "dilithium3")
        durationDil32(end+1) = data2(i,columnToPlot)
        ciDil32(end+1) = data2(i,columnToPlotCI)

    elseif strcmp(algorithm, "dilithium5")
        durationDil52(end+1) = data2(i,columnToPlot)
        ciDil52(end+1) = data2(i,columnToPlotCI)

    elseif strcmp(algorithm, "falcon512")
        durationFal5122(end+1) = data2(i,columnToPlot)
        ciFal5122(end+1) = data2(i,columnToPlotCI)

    elseif strcmp(algorithm, "falcon1024")
        durationFal10242(end+1) = data2(i,columnToPlot)
        ciFal10242(end+1) = data2(i,columnToPlotCI)

    elseif strcmp(algorithm, "rsa")
        durationRsa2(end+1) = data2(i,columnToPlot)
        ciRsa2(end+1) = data2(i,columnToPlotCI)
    else
        disp(strcat("!!!!!!!! UNKNOWN ALGORITHM: ", algorithm))
        disp(algorithm)
        disp(algorithm)
        disp(algorithm)
    end
end

% Get the 5% in its correct spot
[x,sortIdx] = sort(x,'ascend');
durationDil21 = durationDil21(sortIdx);
durationDil31 = durationDil31(sortIdx);
durationDil51 = durationDil51(sortIdx);
durationFal5121 = durationFal5121(sortIdx);
durationFal10241 = durationFal10241(sortIdx);
durationRsa1 = durationRsa1(sortIdx);

durationDil22 = durationDil22(sortIdx);
durationDil32 = durationDil32(sortIdx);
durationDil52 = durationDil52(sortIdx);
durationFal5122 = durationFal5122(sortIdx);
durationFal10242 = durationFal10242(sortIdx);
durationRsa2 = durationRsa2(sortIdx);


ciDil21 = ciDil21(sortIdx);
ciDil31 = ciDil31(sortIdx);
ciDil51 = ciDil51(sortIdx);
ciFal5121 = ciFal5121(sortIdx);
ciFal102411 = ciFal10241(sortIdx);
ciRsa1 = ciRsa1(sortIdx);

ciDil22 = ciDil22(sortIdx);
ciDil32 = ciDil32(sortIdx);
ciDil52 = ciDil52(sortIdx);
ciFal5122 = ciFal5122(sortIdx);
ciFal10242 = ciFal10242(sortIdx);
ciRsa2 = ciRsa2(sortIdx);

hold on;
plotData(x, durationDil21, ciDil21, 1)
plotData(x, durationDil31, ciDil31, 1)
plotData(x, durationDil51, ciDil51, 1)
plotData(x, durationFal5121, ciFal5121, 1)
plotData(x, durationFal10241, ciFal10241, 1)
plotData(x, durationRsa1, ciRsa1, 1)

plotData(x, durationDil22, ciDil22, 2)
plotData(x, durationDil32, ciDil32, 2)
plotData(x, durationDil52, ciDil52, 2)
plotData(x, durationFal5122, ciFal5122, 2)
plotData(x, durationFal10242, ciFal10242, 2)
plotData(x, durationRsa2, ciRsa2, 2)


l = linspace(0,200); plot(l, l, 'Color', 'Red'), xlabel('y'), ylabel('x')


grid on
axis square











if columnToPlot == 8
    ylabel('Handshake Duration (ms)', 'FontSize', font_size)
elseif columnToPlot == 18
    ylabel('Handshake Packets', 'FontSize', font_size)
elseif columnToPlot == 22
    ylabel('Handshake Size (B)', 'FontSize', font_size)
end



xlabel('Network Latency (ms)', 'FontSize', font_size)

yticks([0, 200, 400, 600, 800, 1000])
set(gca, 'YMinorTick','on', 'YMinorGrid','on')
set(gca, 'XMinorTick','on', 'XMinorGrid','on')
set(gca,'FontSize',font_size);
%set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');
set(gca, 'YGrid', 'on', 'YMinorGrid', 'on');

%legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)





function plotData(xarr, yarr, yciarr, id)
    global line_width
    
    if id == 2
        p = plot(xarr, yarr, 'o--', 'LineWidth', line_width)
    else
        p = plot(xarr, yarr, 'o-', 'LineWidth', line_width)
    end
    %return
    
    color = get(p, 'Color');
    hold on
    for i = 1:length(xarr)
        wid = 10
        x = xarr(i)
        y = yarr(i)
        yci = yciarr(i)
        plot([x - wid, x + wid], [y - yci, y - yci], 'Color', color, 'LineWidth', line_width-1, 'HandleVisibility','off');
        plot([x - wid, x + wid], [y + yci, y + yci], 'Color', color, 'LineWidth', line_width-1, 'HandleVisibility','off');
        plot([x, x], [y - yci, y + yci], 'Color', color, 'LineWidth', line_width-1, 'HandleVisibility','off');
        %plot(x, y, '.', 'Color', color, 'MarkerSize', line_width*10, 'HandleVisibility','off')
    end
end