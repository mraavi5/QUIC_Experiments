clear all

% AWS TCP/TLS 100 Samples Results
%dilithium5
%falcon1024
%rsa

%US TCP/TLS
x1 = [119.7528563	1.793415901
113.617438	1.415422503
111.0002668	1.324489159];

%Mumbai TCP/TLS dilithium5 falcon 1024 and RSA
y1 = [497.7086619	2.969827027
499.017477	3.075794272
501.6945362	2.463180174];

%paris TCP/TLS
z1 = [297.1406987	3.330125805
286.9512553	2.791793216
286.1589407	2.787988197];

%seoul TCP/TLS
a1 = [384.369677	2.245800106
376.8391381	1.887575863
379.8868179	1.556182627];

% AWS QUIC 100 Samples Results

%US  QUIC
x2 = [111.705248	3.139557506
80.43127311	0.162469017
48.58675409	0.08671618];

%mumbai QUIC
y2 = [232.5124565	50.34476282
154.4235556	33.36124349
113.3797997	24.48586264];

%paris QUIC
z2 = [333.9946697	12.60894652
254.6498926	4.355557575
132.6296304	5.002401295];

%seoul QUIC
a2 = [166.7796085	36.01295442
94.14596558	20.337695
82.67475178	17.84833757];


x = categorical({'California','Mumbai','Paris','Seoul'});
x = reordercats(x,{'California','Mumbai','Paris','Seoul'});

% 1 for aws-tcp/tls 2 for aws-quic 10  samples
% 3 for aws-tcp/tls 4 for aws-quic 100 samples (0.95%)
selection = 3

if selection == 1
    y = [83.34518691	487.1844588 267.3918625 357.2444011
    81.96078498 482.3950717 264.7936344 354.5339358
    82.22701814	482.0289082 262.5837856 354.919778];
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
    y = [79.14461761	176.3735909 245.2347032 119.5987241
        94.89466015	205.429554 301.0443637 136.6102634
    80.29929797 158.3269144 259.5917914 93.61179251
    ];
    bar(x,y)
    ylim([0 500])
    ylabel('QUIC Handshake Time (ms)','FontSize',18)
    xlabel('AWS Server Location','FontSize',18)
    %set(gca, 'YScale', 'log')
    legend({'RSA3072','Dilithium5','Falcon1024'},'FontSize',14)
    legend('Location','northeast')
    grid on
    grid minor
    axis square

elseif selection == 3
    y = [111.0002668 501.6945362 286.1589407 379.8868179
        119.7528563	497.7086619 297.1406987 384.369677
        113.617438	499.017477 286.9512553 376.8391381
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

elseif selection == 4
    y = [48.58675409 113.3797997 132.6296304 82.67475178
        111.705248	232.5124565 333.9946697 166.7796085
        80.43127311	154.4235556 254.6498926 94.14596558
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

