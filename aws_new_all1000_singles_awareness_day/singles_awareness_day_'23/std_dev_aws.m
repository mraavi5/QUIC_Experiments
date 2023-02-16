font_size = 28;
legend_font_size = 28

x = categorical({'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});
x = reordercats(x,{'California','Mumbai','Paris','Sao Paulo','Seoul','Sydney'});


% 1 for aws-tcp/tls std dev
% 2 for aws-quic std dev  
selection = 2

if selection == 1
    y = [6.141927469	8.543357089	9.684368759	7.703517642	7.691748029	6.975900611
13.71917808	17.87862092	17.83307556	16.03739527	12.17313734	14.10818472
12.61125269	13.42704055	14.92551938	14.35450894	12.52514853	13.77803734
10.43153417	12.46845539	15.58928961	15.55347365	9.450474171	11.51721639
8.328114424	12.85927373	16.3146987	15.23076491	9.419245247	10.97074863
8.997325813	14.40380426	17.48228759	15.36499502	11.80420271	11.24668566
        ];

    y_ci = [6.783343555	7.226791667	0.825305998	0.674733633	0.624640521	0.587541553
9.515287767	9.172624421	1.331700629	9.206039349	9.106749175	13.13124195
1.103221895	8.236149757	8.108308805	8.242096377	1.069692922	1.107475826
8.237811643	8.721927401	1.228522193	11.58648751	0.901797586 1.023126121
0.651529246	0.979648081	1.680087749	8.743387175	0.724458066	0.822916848
0.680319972	8.655111012	1.335299727	1.100953279	8.755446411	0.835552135
        ];

    b = bar(x,y, 'FaceColor','flat')
    ylabel('Standard Deviation (ms)','FontSize',font_size)
    %xlabel('AWS Server Location','FontSize',fontsize)
    %set(gca, 'YScale', 'log')
    legend({'RSA 3072','Dilithium 2','Dilithium 3','Dilithium 5','Falcon 512','Falcon 1024'},'FontSize',legend_font_size)
    legend('Location','northwest')
    grid on
    grid minor
    %axis square

elseif selection == 2
    y = [0.391852637	16.57036144	19.02012775	17.44754546	0.6431283	0.743569322
1.29534974	10.39419532	12.08386758	21.18132489	10.90396808	3.25814047
5.686299059	48.06755646	53.5753545	54.24161685	10.54188434	11.37852133
3.917898674	2.335940488	2.549825347	8.785846354	3.0370682	7.222303063
1.570824219	3.244550464	3.284920813	6.367988895	3.782791807	3.732705042
1.921386668	10.00516789	9.940144441	7.487845612	9.871192547	4.101326513];

    y_ci = [0.115565239	1.072512611	1.196779129	1.117127398	0.100710862	0.244301053
0.089256573	0.795259339	1.258621913	2.376294031	0.886094397	0.809847102
0.996571398	3.475029183	3.714829281	3.887455357	1.093402732	1.932627831
0.442286389	1.151665457	0.816129719	1.208656434	0.837844381	0.749003733
0.120280162	0.523028631	0.450877807	0.547691409	0.417337557	0.662295073
0.161982488	1.106466575	0.709511335	0.717731852	0.731866789	0.769623209
        ];

    b = bar(x,y, 'FaceColor','flat')
    ylabel('Standard Deviation (ms)','FontSize',font_size)
    %xlabel('AWS Server Location','FontSize',fontsize)
    %set(gca, 'YScale', 'log')
    legend({'RSA 3072','Dilithium 2','Dilithium 3','Dilithium 5','Falcon 512','Falcon 1024'},'FontSize',legend_font_size)
    legend('Location','northwest')
    grid on
    grid minor
    %axis square
end


b(1).CData = hex2rgb("45788C");
b(2).CData = hex2rgb("DAEAAD");
b(3).CData = hex2rgb("A7C4AB");
b(4).CData = hex2rgb("40372F");
b(5).CData = hex2rgb("F57153");
b(6).CData = hex2rgb("BF5841");

hold on
line_width = 2;
for awslocation = 1:length(y)
    for i = 1:length(y)
        wid = 0.05
        index = awslocation + (i - 1) * length(y)
        px = (i + 0.25) / (length(y) + 1.5) + (floor(awslocation)) - 3/length(y) %i - (awslocation - length(y) / 2 - 0.5)/(length(y_ci) + 1.5)
        disp(strcat("INDEX: ", num2str(index)))
        py = y(index)
        yci = y_ci(index)
        %plot([px - wid, px + wid], [py - yci, py - yci], 'Color', 'black', 'LineWidth', line_width-1, 'HandleVisibility','off');
        %plot([px - wid, px + wid], [py + yci, py + yci], 'Color', 'black', 'LineWidth', line_width-1, 'HandleVisibility','off');
        %plot([px, px], [py - yci, py + yci], 'Color', 'black', 'LineWidth', line_width-1, 'HandleVisibility','off');
    end
end

xlim(["California" "Sydney"])
ylim([0 60])

set(gcf, 'Position', [100 100 1480 450])
ax = gca
ax.FontSize = font_size;
ax.XAxis.FontSize = 34
ax.YAxis.FontSize = 34



















function [ rgb ] = hex2rgb(hex,range)
% hex2rgb converts hex color values to rgb arrays on the range 0 to 1. 
% 
% 
% * * * * * * * * * * * * * * * * * * * * 
% SYNTAX:
% rgb = hex2rgb(hex) returns rgb color values in an n x 3 array. Values are
%                    scaled from 0 to 1 by default. 
%                    
% rgb = hex2rgb(hex,256) returns RGB values scaled from 0 to 255. 
% 
% 
% * * * * * * * * * * * * * * * * * * * * 
% EXAMPLES: 
% 
% myrgbvalue = hex2rgb('#334D66')
%    = 0.2000    0.3020    0.4000
% 
% 
% myrgbvalue = hex2rgb('334D66')  % <-the # sign is optional 
%    = 0.2000    0.3020    0.4000
% 
%
% myRGBvalue = hex2rgb('#334D66',256)
%    = 51    77   102
% 
% 
% myhexvalues = ['#334D66';'#8099B3';'#CC9933';'#3333E6'];
% myrgbvalues = hex2rgb(myhexvalues)
%    =   0.2000    0.3020    0.4000
%        0.5020    0.6000    0.7020
%        0.8000    0.6000    0.2000
%        0.2000    0.2000    0.9020
% 
% 
% myhexvalues = ['#334D66';'#8099B3';'#CC9933';'#3333E6'];
% myRGBvalues = hex2rgb(myhexvalues,256)
%    =   51    77   102
%       128   153   179
%       204   153    51
%        51    51   230
% 
% HexValsAsACharacterArray = {'#334D66';'#8099B3';'#CC9933';'#3333E6'}; 
% rgbvals = hex2rgb(HexValsAsACharacterArray)
% 
% * * * * * * * * * * * * * * * * * * * * 
% Chad A. Greene, April 2014
%
% Updated August 2014: Functionality remains exactly the same, but it's a
% little more efficient and more robust. Thanks to Stephen Cobeldick for
% the improvement tips. In this update, the documentation now shows that
% the range may be set to 256. This is more intuitive than the previous
% style, which scaled values from 0 to 255 with range set to 255.  Now you
% can enter 256 or 255 for the range, and the answer will be the same--rgb
% values scaled from 0 to 255. Function now also accepts character arrays
% as input. 
% 
% * * * * * * * * * * * * * * * * * * * * 
% See also rgb2hex, dec2hex, hex2num, and ColorSpec. 
% 
%% Input checks:
assert(nargin>0&nargin<3,'hex2rgb function must have one or two inputs.') 
if nargin==2
    assert(isscalar(range)==1,'Range must be a scalar, either "1" to scale from 0 to 1 or "256" to scale from 0 to 255.')
end
%% Tweak inputs if necessary: 
if iscell(hex)
    assert(isvector(hex)==1,'Unexpected dimensions of input hex values.')
    
    % In case cell array elements are separated by a comma instead of a
    % semicolon, reshape hex:
    if isrow(hex)
        hex = hex'; 
    end
    
    % If input is cell, convert to matrix: 
    hex = cell2mat(hex);
end
if strcmpi(hex(1,1),'#')
    hex(:,1) = [];
end
if nargin == 1
    range = 1; 
end
%% Convert from hex to rgb: 
switch range
    case 1
        rgb = reshape(sscanf(hex.','%2x'),3,[]).'/255;
    case {255,256}
        rgb = reshape(sscanf(hex.','%2x'),3,[]).';
    
    otherwise
        error('Range must be either "1" to scale from 0 to 1 or "256" to scale from 0 to 255.')
end
end