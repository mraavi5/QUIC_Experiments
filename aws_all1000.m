fontsize = 20

x = categorical({'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});
x = reordercats(x,{'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});

% 1 for aws-tcp/tls
% 2 for aws-quic 1000samples  
selection = 2

if selection == 1
    y = [122.379169	135.2158126	144.1270909	131.9799917	117.4066642	120.0519806
515.9635735	518.4257721	512.1977009	510.0451182	507.9833788	510.9563134
297.3471411	311.0426342	322.4990327	312.6536183	294.6367004	297.0229267
373.7688	380.683	382.7035	383.2937	362.3316	399.5493
386.4140678	395.8113967	402.9860578	396.6267298	383.2759793	383.7672156
388.1956899	387.1195414	391.9509259	394.1102777	376.3008459	386.7700467
        ];

    y_ci = [6.783343555	7.226791667	0.825305998	0.674733633	0.624640521	0.587541553
9.515287767	9.172624421	1.331700629	9.206039349	9.106749175	13.13124195
1.103221895	8.236149757	8.108308805	8.242096377	1.069692922	1.107475826
8.237811643	8.721927401	1.228522193	11.58648751	0.901797586 61.70987523
0.651529246	0.979648081	1.680087749	8.743387175	0.724458066	0.822916848
0.680319972	8.655111012	1.335299727	1.100953279	8.755446411	0.835552135
        ];

    bar(x,y)
    ylabel('Handshake Time (ms)','FontSize',fontsize)
    %xlabel('AWS Server Location','FontSize',fontsize)
    %set(gca, 'YScale', 'log')
    legend({'RSA3072','Dilithium2','Dilithium3','Dilithium5','Falcon512','Falcon1024'},'FontSize',fontsize)
    legend('Location','northwest')
    grid on
    grid minor
    %axis square

elseif selection == 2
    y = [48.8415645	90.71897409	99.4038262	106.8660888	79.52564602	80.65418104
247.1066	482.7699	485.5253	497.2999	331.7135	344.8779
139.761	289.1693	295.385	295.5718	258.8869	257.0674
166.6757	327.9291	329.439	334.9422	178.5011	182.7166
174.9667	350.0423	350.5012	353.8914	199.0782	200.5917
176.3685	338.2464	338.5213	357.08	187.5001	203.8781
        ];

    y_ci = [0.115565239	1.072512611	1.196779129	1.117127398	0.100710862	0.244301053
0.089256573	0.795259339	1.258621913	2.376294031	0.886094397	0.809847102
0.996571398	3.475029183	3.714829281	3.887455357	1.093402732	1.932627831
0.442286389	1.151665457	0.816129719	1.208656434	0.837844381	0.749003733
0.120280162	0.523028631	0.450877807	0.547691409	0.417337557	0.662295073
0.161982488	1.106466575	0.709511335	0.717731852	0.731866789	0.769623209
        ];

    bar(x,y)

    hold on
    line_width = 2;
    for awslocation = 1:length(y)
        for i = 1:length(y)
            wid = 0.05
            index = awslocation + (i - 1) * length(y)
            px = (i) / length(y) + int(awslocation) %i - (awslocation - length(y) / 2 - 0.5)/(length(y_ci) + 1.5)
            disp(strcat("INDEX: ", num2str(index)))
            py = y(index)
            yci = y_ci(index)
            plot([px - wid, px + wid], [py - yci, py - yci], 'Color', 'black', 'LineWidth', line_width-1, 'HandleVisibility','off');
            plot([px - wid, px + wid], [py + yci, py + yci], 'Color', 'black', 'LineWidth', line_width-1, 'HandleVisibility','off');
            plot([px, px], [py - yci, py + yci], 'Color', 'black', 'LineWidth', line_width-1, 'HandleVisibility','off');
        end
    end

    xlim(["California" "Sydney"])
    ylim([0 600])
    ylabel('Handshake Time (ms)','FontSize',fontsize)
    %xlabel('AWS Server Location','FontSize',fontsize)
    %set(gca, 'YScale', 'log')
    legend({'RSA 3072','Dilithium 2','Dilithium 3','Dilithium 5','Falcon 512','Falcon 1024'},'FontSize',fontsize)
    legend('Location','northwest')
    grid on
    grid minor
    %axis square
end

set(gcf, 'Position', [100 100 1480 450])
ax = gca
ax.FontSize = fontsize;
ax.XAxis.FontSize = fontsize