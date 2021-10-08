clear all

%algorithms used
x = categorical({'RSA 3072','Dilithium 2','Dilithium3','Dilithium5','Falcon512','Falcon1024'});
x = reordercats(x,{'RSA 3072','Dilithium 2','Dilithium3','Dilithium5','Falcon512','Falcon1024'});

%quic and tcp handshake times
y = [8.112297 15.0426962;
5.716916323 8.921268702;
6.404416 12.5220101;
6.75817 12.1575196;
8.39404 16.7149951;
13.34471 21.8567877
];

%verification time
v = [3.156641
3.39531
3.555486
3.717311
3.302495
3.577409];



bar(x,y)
gca.XAxis.FontSize = 18;
ylabel('Handshake Time (ms)','FontSize',18)
xlabel('Algorithms','FontSize',18)
legend({'QUIC','TCP'},'FontSize',18)
legend('Location','northwest')
grid on
grid minor
axis square