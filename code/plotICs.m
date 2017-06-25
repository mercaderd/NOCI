function plotICs(ICs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure('Name','JADE recovered signals');
m=size(ICs,1);
for i=1:m
    subplot(m,1,i);
    plot(ICs(i,:));
    if (i<m) set(gca,'XTick',[]); end;
    if (i==1) title('JADE estimated sources'); end;
    if (i==m) xlabel('time'); end;
        
    ylabel(sprintf('S%d_{est}^{JADE}', i));
end
end

