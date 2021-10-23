x = categorical({'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});
x = reordercats(x,{'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});

% 1 for aws-tcp/tls 2 for aws-quic 1000samples  
selection = 2

if selection == 1
    y = [122.379169 515.963573 297.347141 373.768778 386.414068 388.19569
        131.979992 510.045118 312.653618 383.293712 396.62673 394.110278
120.051981 510.956313 297.022927 399.549267 383.767216 386.770047
        ];
    bar(x,y)
    ylabel('TCP/TLS Handshake Time (ms)','FontSize',18)
    xlabel('AWS Server Location','FontSize',18)
    %set(gca, 'YScale', 'log')
    legend({'RSA3072','Dilithium5','Falcon1024'},'FontSize',14)
    legend('Location','northeast')
    grid on
    grid minor
    axis square

elseif selection == 2
    y = [48.8415645 247.106627 139.760956 166.675668 174.966659 176.368501
        106.8660888 497.299879 295.571812 334.942162 353.89139 357.079955
80.65418104 344.877913 257.067411 182.716631 200.591713 203.878116
        ];
    bar(x,y)
    ylim([0 600])
    ylabel('QUIC Handshake Time (ms)','FontSize',18)
    xlabel('AWS Server Location','FontSize',18)
    %set(gca, 'YScale', 'log')
    legend({'RSA3072','Dilithium5','Falcon1024'},'FontSize',14)
    legend('Location','northeast')
    grid on
    grid minor
    axis square
end