clear all

% AWS TCP/TLS 10 Samples Results

%US TCP/TLS
x1 = [81.96078498	0.6316493
82.22701814	1.524338166
83.34518691	1.189182716];

%Mumbai TCP/TLS dilithium5 falcon 1024 and RSA
y1 = [482.3950717 4.708440349
482.0289082 7.892418847
487.1844588 4.752692556];

%paris TCP/TLS
z1 = [264.7936344	5.400873157
262.5837856	8.487308597
267.3918625	4.737065984];

%seoul TCP/TLS
a1 = [354.5339358	1.833329031
354.919778	2.533524004
357.2444011	1.993641634];

% AWS QUIC 10 Samples Results

%US  QUIC
x2 = [94.89466015	9.434164585
80.29929797	0.676950752
79.14461761	10.33005963];

%mumbai QUIC
y2 = [205.429554	72.13957988
158.3269144	82.83182969
176.3735909	51.51016645];

%paris QUIC
z2 = [301.0443637	29.95758078
259.5917914	9.24524917
245.2347032	35.32405245];

%seoul QUIC
a2 = [136.6102634	49.46912745
93.61179251	48.91756699
119.5987241	35.35906705];


x = categorical({'California','Mumbai','Paris','Seoul'});
x = reordercats(x,{'California','Mumbai','Paris','Seoul'});

% 1 for aws-tcp/tls 2 for aws-quic
selection = 2

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
end

