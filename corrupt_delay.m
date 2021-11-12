clear all

%{
selections
1: quic and tls data with 9 drop rates and 10 samples
2: tls data with 9 drop rates and 1000 samples
3: tls data with 5 drop rates and 1000 samples
4: tls data with 4 drop rates (0,5,10,20) and 1000 samples
%}


selection = 3;

if selection == 1
    %Delay 10 samples
    x = [0 100 200];
    y = [222.9795091	226.2785559	228.594496
        239.3449326	243.6817922	244.6722957
        235.401619	240.7253205	241.6629592
        225.0115864	231.8817067	232.5799565
        197.3418885	206.387983	210.7695611
        195.1284671	213.4475443	213.9304408
        ];
    plot(x,y,'-o')
    ylim([0 300])
    set(gca, 'YScale', 'log')
    ylabel('Handshake Time (ms)','FontSize',18)
    xlabel('Packet Delay (ms)','FontSize',18)
    legend({'RSA 3072','Dilithium 2','Dilithium 3','Dilithium 5','Falcon 512','Falcon 1024','TCP'},'FontSize',14)
    legend('Location','northwest')
    grid on
    grid minor
    axis square
  elseif selection == 2
    %10 samples corrupt
    x = [0 5 10 20];
    y = [14.59992676	14.68539975	14.81133485	15.06384805
         8.802880321	8.866483399	8.906601557	9.04156361
        9.447542481	9.524171617	9.631178645	9.773013689
        10.40940038	10.509941	10.63411462	11.06817223
        12.79957357	12.97818849	13.0778425	13.43498359
        15.7693373	15.92305453	16.1640403	16.80635003];
    plot(x,y,'-o')
    ylim([0 25])
    set(gca, 'YScale', 'log')
    ylabel('Handshake Time (ms)','FontSize',18)
    xlabel('Packet Corruption Rate (%)','FontSize',18)
    legend({'RSA 3072','Dilithium 2','Dilithium 3','Dilithium 5','Falcon 512','Falcon 1024'},'FontSize',9)
    legend('Location','northwest')
    grid on
    grid minor
    axis square
  elseif selection == 3
    %10 samples duplicate
    x = [0 5 10 20];
    y = [6.934000696	6.90279354	6.902629435	6.870565812
         6.979764404	7.019228405	7.051139895	7.122553199
         7.438493836	7.471595165	7.48441026	7.548856489
         7.936449226	7.974354627	7.977065697	8.104687445
         8.791842219	8.839949318	8.858838057	8.986467634
         10.89683649	10.68191676	10.38472132	9.817261249
    ];
    plot(x,y,'-o')
    ylim([0 25])
    set(gca, 'YScale', 'log')
    ylabel('Handshake Time (ms)','FontSize',18)
    xlabel('Packet Duplicate Rate (%)','FontSize',18)
    legend({'RSA 3072','Dilithium 2','Dilithium 3','Dilithium 5','Falcon 512','Falcon 1024'},'FontSize',9)
    legend('Location','northwest')
    grid on
    grid minor
    axis square 
end