clear all

% AWS Ping Results

%{
Paris 
135.871871871872 ± 0.03418481232986
Seoul
172.042042042042 ± 0.0283112254294076
Mumbai
236.089089089089 ± 0.0185161606494656
USA
38.1655655655656 ± 0.0458131946804873
%}

x = categorical({'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});
x = reordercats(x,{'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});

y = [37.6351 236.524 123.537 176.099 163.028 178.046];

bar(x,y)
    ylabel('Round Trip Time (ms)','FontSize',18)
    xlabel('AWS Server Location','FontSize',18)
    grid on
    grid minor
    axis square