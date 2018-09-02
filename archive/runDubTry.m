function [data,header] =runDubMult()

fn = 'vDubTry.net';

[fDir,stem,ext] = fileparts(fn);

fOut = [fDir,stem,'.out'];


try
  err = system(['gnucap -b ',fn]);
catch
  err = system(['ngspice -b ',fn,'> ',fOut]);
end


%% parse output
fid = fopen(fOut);
header = textscan(fid,repmat('%s',1,5),1);
data = textscan(fid,repmat('%f',1,5),'headerlines',1,'delimiter',' ','multipledelimsasone',true,'collectoutput',false);
fclose(fid);

data=cell2mat(data);

%% compute impedance
Z = (data(:,2) + 1j*data(:,3)) ./ (data(:,4) + 1j*data(:,5));

col = repmat(['b','g','r','m','k'],1,3);

figure(1)

plot(data(:,1),abs(Z)),hold on

grid on
legend('show','location','southwest')
ylabel('Impedance [ohms]'),xlabel('Freq. [Hz]')
title('Basic Voltage Doubler: Diode ')





if ~nargout
    clear
end

end
