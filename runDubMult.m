function [Z,data,header] =runDubMult()
 clc
 close all

gnu = true;

fn = 'vDubMult.net';

[fDir,stem,ext] = fileparts(fn);

fOut = [fDir,stem,'.out'];


if gnu
cmd = ['gnucap -b ',fn]
else
 cmd = ['ngspice -b ',fn,'> ',fOut]
end
err = system(cmd)



fid = fopen(fOut);
header = textscan(fid,repmat('%s',1,16),1);
data = textscan(fid,repmat('%f',1,16),'headerlines',1,'delimiter',' ','multipledelimsasone',true,'collectoutput',false);



data=cell2mat(data);

fclose(fid);

col = repmat(['b','g','r','m','k'],1,3);

figure(2)
subplot(2,1,1)
for i = 2:6
plot(data(:,1),data(:,i),'color',col(i-1),'displayname',header{i}),hold on
end
grid on
legend('show','location','southwest')
ylabel('Node Voltage [V]'),xlabel('Time [sec]')
title('Basic Voltage Doubler Voltages: Diode ')

subplot(2,1,2)
for i = 7:14
plot(data(:,1),data(:,i),'color',col(i-1),'displayname',header{i}),hold on
end
grid on
legend('show','location','southwest')
ylabel('Device Current [A]'),xlabel('Time [sec]')
title('Basic Voltage Doubler Currents: Diode ')
   

Zmag = data(:,15) ./ data(:,16);

figure 
plot(data(:,1),Zmag)
ylabel('|Zin|'),xlabel('time [sec]')
title('Input Impedance vs. time')



if ~nargout
    data = [];
end

end
