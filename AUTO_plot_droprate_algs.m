global marker_size line_width font_size legend_pos
marker_size = 15;
line_width = 2;
font_size = 18;
legend_pos = 'NorthWest';

isQUIC = 1;

if isQUIC
    data = readmatrix('QUIC\COMPUTED_AVERAGES_QUIC_1000_SAMPLES.csv');
    datastr = readtable('QUIC\COMPUTED_AVERAGES_QUIC_1000_SAMPLES.csv');
else
    %data = readmatrix('QUIC\COMPUTED_AVERAGES_QUIC_1000_SAMPLES.csv');
end


x = [0 10 15 20 25 30 35 40 5]


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

xlabel('Packet Drop Rate (%)', 'FontSize', font_size)
ylabel('Handshake Duration (ms)', 'FontSize', font_size)

yticks([0, 10, 30, 40, 50, 60, 70, 80, 90, 100, 120, 140, 160])
set(gca, 'YMinorTick','on', 'YMinorGrid','on')
set(gca, 'XMinorTick','on', 'XMinorGrid','on')
set(gca,'FontSize',font_size);
set(gca, 'YScale', 'log', 'YGrid', 'on', 'YMinorGrid', 'on');

legend('QUIC Dilithium 2', 'QUIC Dilithium 3', 'QUIC Dilithium 5', 'QUIC Falcon 512', 'QUIC Falcon 1024', 'QUIC RSA 3072', 'Location', legend_pos, 'FontSize', font_size - 4)


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