x = categorical({'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});
x = reordercats(x,{'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});

% 1 for aws-tcp/tls 2 for aws-quic 1000samples  
selection = 2

if selection == 1
    y = [135.2158126 518.4257721 311.0426342 380.683 395.8113967 387.1195414
        144.1270909 512.1977009 322.4990327 382.7035 402.9860578 391.9509259
        117.4066642 507.9833788 294.6367004 362.3316 383.2759793 376.3008459
        ];
    bar(x,y)
    ylabel('TCP/TLS Handshake Time (ms)','FontSize',18)
    xlabel('AWS Server Location','FontSize',18)
    %set(gca, 'YScale', 'log')
    legend({'Dilithium2','Dilithium3','Falcon512'},'FontSize',14)
    legend('Location','northeast')
    grid on
    grid minor
    axis square

elseif selection == 2
    y = [90.71897409 482.7699 289.1693 327.9291 350.0423 338.2464
         99.4038262 485.5253 295.385 329.439 350.5012 338.5213
         79.52564602 331.7135 258.8869 178.5011 199.0782 187.5001
        ];
    bar(x,y)
    ylim([0 600])
    ylabel('QUIC Handshake Time (ms)','FontSize',18)
    xlabel('AWS Server Location','FontSize',18)
    %set(gca, 'YScale', 'log')
    legend({'Dilithium2','Dilithium3','Falcon512'},'FontSize',14)
    legend('Location','northeast')
    grid on
    grid minor
    axis square
end