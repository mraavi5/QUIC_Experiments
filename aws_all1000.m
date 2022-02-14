fontsize = 20

x = categorical({'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});
x = reordercats(x,{'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});

% 1 for aws-tcp/tls
% 2 for aws-quic 1000samples  
selection = 1

if selection == 1
    y = [122.379169	135.2158126	144.1270909	131.9799917	117.4066642	120.0519806
515.9635735	518.4257721	512.1977009	510.0451182	507.9833788	510.9563134
297.3471411	311.0426342	322.4990327	312.6536183	294.6367004	297.0229267
373.7688	380.683	382.7035	383.2937	362.3316	399.5493
386.4140678	395.8113967	402.9860578	396.6267298	383.2759793	383.7672156
388.1956899	387.1195414	391.9509259	394.1102777	376.3008459	386.7700467
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
    bar(x,y)
    ylim([0 600])
    ylabel('Handshake Time (ms)','FontSize',fontsize)
    %xlabel('AWS Server Location','FontSize',fontsize)
    %set(gca, 'YScale', 'log')
    legend({'RSA3072','Dilithium2','Dilithium3','Dilithium5','Falcon512','Falcon1024'},'FontSize',fontsize)
    legend('Location','northwest')
    grid on
    grid minor
    %axis square
end

set(gcf, 'Position', [100 100 1480 450])
ax = gca
ax.FontSize = fontsize
ax.XAxis.FontSize = fontsize