function [data,header] =runMos()
 
gnucap = true;

fn = 'mos.net';

[fDir,stem,ext] = fileparts(fn);

fOut = [fDir,stem,'.out'];


if gnucap
 cmd = ['gnucap -b ',fn];
else
 cmd = ['ngspice -b ',fn,'> ',fOut];
end
err = system(cmd);

if err, error('simulator error'), end

Nvar = 2;

fid = fopen(fOut);
header = textscan(fid,repmat('%s ',1,Nvar+1),1);
data = textscan(fid,repmat('%f ',1,Nvar+1),'headerlines',1,'delimiter',' ','multipledelimsasone',true,'collectoutput',false);


data=cell2mat(data);

fclose(fid);

col = ['b','g','r','b','g','r','k'];

figure(2)
subplot(2,1,1)
for i = 2:3
plot(data(:,1),data(:,i),'color',col(i-1),'displayname',header{i}{1}),hold on
end
grid on
legend('show','location','southwest')
ylabel('Node Voltage [V]'),xlabel('Time [sec]')
%title('Basic Voltage Doubler Voltages: Diode ')

%{
subplot(2,1,2)
for i = 5:8
plot(data(:,1),data(:,i),'color',col(i-1),'displayname',header{i}{1}),hold on
end
grid on
legend('show','location','southwest')
ylabel('Device Current [A]'),xlabel('Time [sec]')
title('Basic Voltage Doubler Currents: Diode ')
  %} 



if ~nargout
  clear
end

end
