clear all

%{
selections

1: quic and tls data with 9 drop rates and 10 samples
2: tls data with 9 drop rates and 1000 samples
3: tls data with 5 drop rates and 1000 samples
4: tls data with 4 drop rates (0,5,10,20) and 1000 samples
%}


selection = 4;

if selection == 1
    %quic data with 9 drop rates and 10 samples
    x = [0 5 10 15 20 25 30 35 40];
    y = [8.695173262 8.629846566 8.047533035 7.985806469 13.41795922 9.529900555 32.79318808 434.2783217 11.45131588
    6.544303894	4.749417305	5.830097199	8.260846139	7.25710392	11.15381718	8.411431313	8.185744284	58.37039947
    6.024575233	6.209206583	6.171250343	6.540107724	7.969975479	6.545281407	8.18490982	8.599925037	642.0085433
    7.767415046	9.21881199	8.655285837	7.955455784	7.859110837	8.120965955	6.669807441	8.744978899	7.5855732
    9.316611286	8.12036991	7.867288588	8.124160765	7.496333121	80.16850948	7.86240101	8.583188053	17.31464864
    12.76328563	12.97330857	13.36572171	16.45607951	15.16993046	12.76195048	16.63460732	15.88089464	12.12100982];
    %tls data with 9 drop rates and 10 samples
    z = [23.01409244	35.65008642	13.09833527	37.69719601	127.9998779	146.6828584	302.5813103	234.7188234	33.95493029
   7.411003109	49.11291604	51.29601957	202.8107169	50.38070679	10.59389114	252.6901721	195.0881006	378.4813408
   13.25833798	8.059072486	35.78243254	9.368848804	165.7651663	118.4631824	116.2591695	727.8258088	123.0562209
   17.88449289	11.97397709	36.81724066	32.15746881	73.45192434	104.3663741	197.8394509	529.9631361	96.21708396
   14.59240914	12.15834618	36.16075515	11.07621193	162.0191812	100.8547307	163.4907962	210.3712558	269.5790534
   20.28882502	29.95557786	18.58947277	155.9488773	77.5407553	208.4122179	560.8622784	278.8308619	5.90250492];
    plot(x,y,x,z,'--')
    set(gca, 'YScale', 'log')
    ylabel('Handshake Time (ms)','FontSize',18)
    xlabel('Packet Drop Rate (%)','FontSize',18)
    legend({'RSA 3072','Dilithium 2','Dilithium 3','Dilithium 5','Falcon 512','Falcon 1024','TCP'},'FontSize',14)
    legend('Location','northwest')
    grid on
    grid minor
    axis square

elseif selection == 2
    %tls data with 9 drop rates and 1000 samples
    x = [0 5 10 15 20 25 30 35 40];
    y = [15.0426962	31.6143265	48.6450293	77.5969443	112.87435	166.224248	235.283324	281.156161	293.386755
    8.921268702	19.89830756	44.4141269	72.5677059	114.044445	155.08949	200.654529	298.879165	281.98114
    12.5220101	24.59621024	43.8976784	69.1551957	109.362925	153.992878	223.01962	299.708437	338.370623
    12.1575196	23.5603874	46.5200851	74.8022897	97.5426736	145.775265	229.175172	303.994443	320.754321
    16.7149951	31.4340405	45.7379036	76.9947426	113.022259	147.440938	203.375823	286.888195	318.560271
    21.8567877	36.667181	57.2596824	86.9759176	114.232093	173.056225	221.405254	287.782331	302.872536];
    %quic data with 9 drop rates and 1000 samples    
     z = [8.112297	8.37153	9.110029	13.23372	16.82594	26.27992	93.79313	165.6946	388.3478
    5.716916323	6.441332	6.646052	8.019722	15.68176	32.42768	30.83452	73.99368	78.78724
    6.404416	6.886349	7.718261	8.249979	45.93917	20.29497	20.67745	78.17918	130.6784
    6.75817	7.720164	8.599003	7.953617	30.65121	32.73516	46.63744	59.30492	125.9837
    8.39404	8.991255	9.782846	11.18416	11.28093	16.06902	36.20807	36.92629	54.77914
    13.34471	14.90665	15.26271	34.44567	17.59507	22.80638	22.03492	35.8588	162.3324];
    plot(x,y,'-o',x,z,'-*')
    set(gca, 'YScale', 'log')
    ylabel('Handshake Time (ms)','FontSize',18)
    xlabel('Packet Drop Rate (%)','FontSize',18)
    legend({'TCP/TLS RSA3072','TCP/TLS Dilithium2','TCP/TLS Dilithium3','TCP/TLS Dilithium5','TCP/TLS Falcon512','TCP/TLS Falcon1024','QUIC RSA3072','QUIC Dilithium2','QUIC Dilithium3','QUIC Dilithium5','QUIC Falcon512','QUIC Falcon1024'},'FontSize',9)
    %legend({'TCP/TLS','','','','','','QUIC'},'FontSize',14)
    legend('Location','northwest')
    grid on
    grid minor
    axis square
 elseif selection == 3
    %tls data with 5 drop rates and 1000 samples
    x = [0 5 10 20 40];
    y = [15.0426962	31.6143265	48.6450293	112.87435	293.386755
    8.921268702	19.89830756	44.4141269	114.044445	281.98114
    12.5220101	24.59621024	43.8976784	109.362925	338.370623
    12.1575196	23.5603874	46.5200851	97.5426736	320.754321
    16.7149951	31.4340405	45.7379036	113.022259	318.560271
    21.8567877	36.667181	57.2596824	114.232093	302.872536];
    %quic data with 5 drop rates and 1000 samples    
     z = [8.112297	8.37153	9.110029	16.82594	388.3478
    5.716916323	6.441332	6.646052	15.68176	78.78724
    6.404416	6.886349	7.718261	45.93917	130.6784
    6.75817	7.720164	8.59900	30.65121	125.9837
    8.39404	8.991255	9.782846	11.28093	54.77914
    13.34471	14.90665	15.26271	17.59507	162.3324];
    plot(x,y,'-o',x,z,'-*')
    set(gca, 'YScale', 'log')
    ylabel('Handshake Time (ms)','FontSize',18)
    xlabel('Packet Drop Rate (%)','FontSize',18)
    legend({'TCP/TLS RSA3072','TCP/TLS Dilithium2','TCP/TLS Dilithium3','TCP/TLS Dilithium5','TCP/TLS Falcon512','TCP/TLS Falcon1024','QUIC RSA3072','QUIC Dilithium2','QUIC Dilithium3','QUIC Dilithium5','QUIC Falcon512','QUIC Falcon1024'},'FontSize',9)
    %legend({'TCP/TLS','','','','','','QUIC'},'FontSize',14)
    legend('Location','northwest')
    grid on
    grid minor
    axis square
  elseif selection == 4
    %tls data with 4 drop rates and 1000 samples
    x = [0 5 10 20];
    y = [15.0426962	31.6143265	48.6450293	112.87435
    8.921268702	19.89830756	44.4141269	114.044445
    12.5220101	24.59621024	43.8976784	109.362925
    12.1575196	23.5603874	46.5200851	97.5426736
    16.7149951	31.4340405	45.7379036	113.022259
    21.8567877	36.667181	57.2596824	114.232093];
    %quic data with 4 drop rates and 1000 samples    
     z = [8.112297	8.37153	9.110029	16.82594
    5.716916323	6.441332	6.646052	15.68176
    6.404416	6.886349	7.718261	45.93917
    6.75817	7.720164	8.59900	30.65121
    8.39404	8.991255	9.782846	11.28093
    13.34471	14.90665	15.26271	17.59507];
    plot(x,y,'-o',x,z,'-*')
    set(gca, 'YScale', 'log')
    ylabel('Handshake Time (ms)','FontSize',18)
    xlabel('Packet Drop Rate (%)','FontSize',18)
    legend({'TCP/TLS RSA3072','TCP/TLS Dilithium2','TCP/TLS Dilithium3','TCP/TLS Dilithium5','TCP/TLS Falcon512','TCP/TLS Falcon1024','QUIC RSA3072','QUIC Dilithium2','QUIC Dilithium3','QUIC Dilithium5','QUIC Falcon512','QUIC Falcon1024'},'FontSize',9)
    %legend({'TCP/TLS','','','','','','QUIC'},'FontSize',14)
    legend('Location','northwest')
    grid on
    grid minor
    axis square
    
end