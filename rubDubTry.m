function [data,header] =runDubMult()
 clc
 close all

gnu = true;

fn = 'vDubTry.net';

[fDir,stem,ext] = fileparts(fn);

fOut = [fDir,stem,'.out'];


if gnu
cmd = ['gnucap -b ',fn]
else
 cmd = ['ngspice -b ',fn,'> ',fOut]
end
err = system(cmd)



fid = fopen(fOut);
header = textscan(fid,repmat('%s',1,5),1);
data = textscan(fid,repmat('%f',1,5),'headerlines',1,'delimiter',' ','multipledelimsasone',true,'collectoutput',false);



data=cell2mat(data);

fclose(fid);

%compute impedance
Z = (data(:,2) + 1j*data(:,3)) ./ (data(:,4) + 1j*data(:,5));

col = repmat(['b','g','r','m','k'],1,3);

figure(1)

plot(data(:,1),abs(Z)),hold on

grid on
legend('show','location','southwest')
ylabel('Impedance [ohms]'),xlabel('Freq. [Hz]')
title('Basic Voltage Doubler: Diode ')





if ~nargout
    data = [];
end

end
