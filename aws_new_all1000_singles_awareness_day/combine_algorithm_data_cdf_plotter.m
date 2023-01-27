plotNum = 6

if plotNum == 1
    location = 'California'
elseif plotNum == 2
    location = 'Mumbai'
elseif plotNum == 3
    location = 'Paris'
elseif plotNum == 4
    location = 'Sao_Paulo'
elseif plotNum == 5
    location = 'Seoul'
elseif plotNum == 6
    location = 'Sydney'
end

drawAverages = 0 % 1 for true

data_quic = readmatrix(strcat('Combined_Algorithms_QUIC_', location, '.csv'));
data_tcp = readmatrix(strcat('Combined_Algorithms_TCPTLS_', location, '.csv'));

colors = ["#45788C", "#DAEAAD", "#A7C4AB", "#40372F", "#F57153", "#BF5841"]

line_width = 3;
font_size = 18;
legend_pos = 'SouthEast'

f = figure;
f.Position = [100 100 1150 400];
hold on;


% TCP/TLS RSA
y1 = data_tcp(:, 1)
c1 = cdfplot(y1);
set(c1,'LineWidth', line_width);
set(c1, 'LineStyle', '--', 'Color', colors{1});
if drawAverages == 1
	avg = mean(y1, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{1}, 'HandleVisibility', 'off');
end

% TCP/TLS Dilithium 2
y2 = data_tcp(:, 2)
c2 = cdfplot(y2);
set(c2,'LineWidth', line_width);
set(c2, 'LineStyle', '--', 'Color', colors{2});
if drawAverages == 1
	avg = mean(y2, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{2}, 'HandleVisibility', 'off');
end

% TCP/TLS Dilithium 3
y3 = data_tcp(:, 3)
c3 = cdfplot(y3);
set(c3,'LineWidth', line_width);
set(c3, 'LineStyle', '--', 'Color', colors{3});
if drawAverages == 1
	avg = mean(y3, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{3}, 'HandleVisibility', 'off');
end

% TCP/TLS Dilithium 5
y4 = data_tcp(:, 4)
c4 = cdfplot(y4);
set(c4,'LineWidth', line_width);
set(c4, 'LineStyle', '--', 'Color', colors{4});
if drawAverages == 1
	avg = mean(y4, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{4}, 'HandleVisibility', 'off');
end

% TCP/TLS Falcon 512
y5 = data_tcp(:, 5)
c5 = cdfplot(y5);
set(c5,'LineWidth', line_width);
set(c5, 'LineStyle', '--', 'Color', colors{5});
if drawAverages == 1
	avg = mean(y5, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{5}, 'HandleVisibility', 'off');
end

% TCP/TLS Falcon 1024
y6 = data_tcp(:, 6)
c6 = cdfplot(y6);
set(c6,'LineWidth', line_width);
set(c6, 'LineStyle', '--', 'Color', colors{6});
if drawAverages == 1
	avg = mean(y6, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{6}, 'HandleVisibility', 'off');
end



% QUIC RSA
y1 = data_quic(:, 1)
c1 = cdfplot(y1);
set(c1,'LineWidth', line_width);
set(c1, 'LineStyle', '-', 'Color', colors{1});
if drawAverages == 1
	avg = mean(y1, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{1}, 'HandleVisibility', 'off');
end

% QUIC Dilithium 2
y2 = data_quic(:, 2)
c2 = cdfplot(y2);
set(c2,'LineWidth', line_width);
set(c2, 'LineStyle', '-', 'Color', colors{2});
if drawAverages == 1
	avg = mean(y2, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{2}, 'HandleVisibility', 'off');
end

% QUIC Dilithium 3
y3 = data_quic(:, 3)
c3 = cdfplot(y3);
set(c3,'LineWidth', line_width);
set(c3, 'LineStyle', '-', 'Color', colors{3});
if drawAverages == 1
	avg = mean(y3, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{3}, 'HandleVisibility', 'off');
end

% QUIC Dilithium 5
y4 = data_quic(:, 4)
c4 = cdfplot(y4);
set(c4,'LineWidth', line_width);
set(c4, 'LineStyle', '-', 'Color', colors{4});
if drawAverages == 1
	avg = mean(y4, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{4}, 'HandleVisibility', 'off');
end

% QUIC Falcon 512
y5 = data_quic(:, 5)
c5 = cdfplot(y5);
set(c5,'LineWidth', line_width);
set(c5, 'LineStyle', '-', 'Color', colors{5});
if drawAverages == 1
	avg = mean(y5, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{5}, 'HandleVisibility', 'off');
end

% QUIC Falcon 1024
y6 = data_quic(:, 6)
c6 = cdfplot(y6);
set(c6,'LineWidth', line_width);
set(c6, 'LineStyle', '-', 'Color', colors{6});
if drawAverages == 1
	avg = mean(y6, 1, 'omitnan');
	xline(avg, 'LineWidth', line_width, 'LineStyle', ':', 'Color', colors{6}, 'HandleVisibility', 'off');
end





legend([c1, c2, c3, c4, c5, c6], 'RSA 3072','Dilithium 2','Dilithium 3','Dilithium 5','Falcon 512','Falcon 1024', 'Location', legend_pos, 'numColumns', 1)

title('');



% Some additional formatting
set(gca,'FontSize',font_size);
grid on;
box on;
%axis square;
xlabel('Handshake Duration (ms)');
ylabel('CDF');
if location == "California"
    xlim([40, 180]);
elseif location == "Mumbai"
    xlim([220, 630]);
elseif location == "Paris"
    xlim([120, 430]);
elseif location == "Sao_Paulo"
    xlim([150, 460]);
elseif location == "Seoul"
    xlim([160, 480]);
elseif location == "Sydney"
    xlim([150, 480]);
end
%set(gca, 'XScale', 'log');
set(gca, 'XMinorTick','on', 'XMinorGrid','on');
set(gca, 'YMinorTick','on', 'YMinorGrid','on');
yticks([0, 0.25, 0.5, 0.75, 1]);