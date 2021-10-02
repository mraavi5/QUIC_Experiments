x = categorical({'RSA 3072','Dilithium 2','Dilithium3','Dilithium5','Falcon512','Falcon1024'});
x = reordercats(x,{'RSA 3072','Dilithium 2','Dilithium3','Dilithium5','Falcon512','Falcon1024'});

errhigh = [0.0555325375681583
0.0579130359509992
0.0664043865866357
0.0777806113357947
0.0926448260372474
0.155074183935658];


y = [8.704957523 11.84353995;
8.745854859 11.55008407;
8.784838804 12.2824625;
8.87419981 13.73126245;
8.86615981 16.28936297;
8.917140148 20.47025525
];
bar(x,y)
gca.XAxis.FontSize = 18;
ylabel('Handshake Time (ms)','FontSize',18)
xlabel('Algorithms','FontSize',18)
legend({'QUIC','TLS 1.3'},'FontSize',18)
legend('Location','northwest')