line_width = 2;
font_size = 18;
legend_pos = 'SouthEast'

f = figure;
f.Position = [100 100 1150 400];
hold on;

colors = {'#000000', '#13428F', '#68DBC4', '#0593A2', '#F2778D', '#F24B88'}

% QUIC California
y1 = [90.71897409
99.4038262
106.8660888
80.65418104
79.52564602
48.8415645]
c1 = cdfplot(y1);
set(c1,'LineWidth', line_width);
set(c1, 'LineStyle', '-', 'Color', colors{1});

% QUIC Mumbai
y2 = [482.7699473
485.5253372
497.2998788
344.877913
331.7134538
247.1066266]
c2 = cdfplot(y2);
set(c2,'LineWidth', line_width);
set(c2, 'LineStyle', '-', 'Color', colors{2});

% QUIC Paris
y3 = [289.1693447
295.3850166
295.5718119
257.0674112
258.8869463
139.760956]
c3 = cdfplot(y3);
set(c3,'LineWidth', line_width);
set(c3, 'LineStyle', '-', 'Color', colors{3});

% QUIC Sao Paulo
y4 = [327.9290586
329.4390386
334.9421619
182.7166307
178.5010998
166.6756681]
c4 = cdfplot(y4);
set(c4,'LineWidth', line_width);
set(c4, 'LineStyle', '-', 'Color', colors{4});

% QUIC Seoul
y5 = [350.042252
350.5011638
353.8913904
200.5917131
199.0782358
174.9666588]
c5 = cdfplot(y5);
set(c5,'LineWidth', line_width);
set(c5, 'LineStyle', '-', 'Color', colors{5});

% QUIC Sydney
y6 = [338.2464336
338.521256
357.0799551
203.878116
187.5000826
176.3685007]
c6 = cdfplot(y6);
set(c6,'LineWidth', line_width);
set(c6, 'LineStyle', '-', 'Color', colors{6});

% TCP/TLS California
y7 = [135.2158126
144.1270909
131.9799917
120.0519806
117.4066642
122.379169]
c7 = cdfplot(y7);
set(c7,'LineWidth', line_width);
set(c7, 'LineStyle', ':', 'Color', colors{1});

% TCP/TLS Mumbai
y8 = [518.4257721
512.1977009
510.0451182
510.9563134
507.9833788
515.9635735]
c8 = cdfplot(y8);
set(c8,'LineWidth', line_width);
set(c8, 'LineStyle', ':', 'Color', colors{2});

% TCP/TLS Paris
y9 = [311.0426342
322.4990327
312.6536183
297.0229267
294.6367004
297.3471411]
c9 = cdfplot(y9);
set(c9,'LineWidth', line_width);
set(c9, 'LineStyle', ':', 'Color', colors{3});

% TCP/TLS Sao Paulo
y10 = [380.6829971
382.7035224
383.2937117
368.1065948
362.3316403
373.7687778]
c10 = cdfplot(y10);
set(c10,'LineWidth', line_width);
set(c10, 'LineStyle', ':', 'Color', colors{4});

% TCP/TLS Seoul
y11 = [395.8113967
402.9860578
396.6267298
383.7672156
383.2759793
386.4140678]
c11 = cdfplot(y11);
set(c11,'LineWidth', line_width);
set(c11, 'LineStyle', ':', 'Color', colors{5});

% TCP/TLS Sydney
y12 = [387.1195414
391.9509259
394.1102777
386.7700467
376.3008459
388.1956899]
c12 = cdfplot(y12);
set(c12,'LineWidth', line_width);
set(c12, 'LineStyle', ':', 'Color', colors{6});


legend('California', 'Mumbai', 'Paris', 'Sao Paulo', 'Seoul', 'Sydney', 'Location', legend_pos, 'numColumns', 6)

title('');

% Draw the average
%avg = mean(y, 1, 'omitnan');
%xline(avg, 'LineWidth', line_width, 'LineStyle', '--', 'Color', 'black', 'HandleVisibility', 'off');
%text(avg + 1,0.2,'{\it x} = 32', 'FontSize' ,font_size);

% Some additional formatting
set(gca,'FontSize',font_size);
grid on;
box on;
%axis square;
xlabel('Handshake Duration');
ylabel('CDF');
%xlim([0, 81]);
set(gca, 'XMinorTick','on', 'XMinorGrid','on');
set(gca, 'YMinorTick','on', 'YMinorGrid','on');
yticks([0, 0.25, 0.5, 0.75, 1]);