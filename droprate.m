x = [0 10 40];
y = [8.63 7.18 8.03
    2319.69 2364.36 2264.67
    10929.97 6103.18 6028.09];
plot(x,y)
set(gca, 'YScale', 'log')
ylabel('Handshake Time (ms)','FontSize',18)
xlabel('packet drop rate (%)','FontSize',18)
legend({'RSA 3072','Dilithium 2','Dilithium 3'},'FontSize',18)
legend('Location','southeast')
