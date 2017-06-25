function [ICs, NOCI, elapsedTime] = LCC_NOCI(X,verbose)
% LCC_NOCI Optimal Number of Independant Components 
% determination with Linear Component Correlation method
%
%   Input parameters:
%       X: MxN matrix. N samples of M sensors.
%       verbose: 0 no verbose, 2 plot sucesive estimated ICs
%
%   Output parameters:
%       ICs: Independant Components Extracted
%       NOCI: Optimal Number of Independant Components
%       elapsedTime: For timing purpouses
% 
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%

if (nargin == 1) verbose = 0; end;

[nobs,t] = size(X);

ICs = 0;
NOCI = 0;
tic;
for nICs=2:nobs
     [A,S] = jade(X,nICs); 
     aux = corr(S');
     c = aux - diag(diag(aux));
     if verbose > 1
         % Solo para pruebas
         figure('Name','Independent Components');
         title(sprintf('Independent components for NCI=%d', nICs));
         m = size(S,1);

         for i=1:m
            subplot(m,1,i);
            plot(S(i,:));
            if (i==1) 
                title(sprintf('True sources for NCI=%d, Max |Corr(p,m)|=%.4f', nICs, max(abs(c(:))))); 
            end; 
            if (i==m) xlabel('samples'); end;
            ylabel(sprintf('S%d', i));
         end
        %Solo para pruebas
     end;
     
     if (max(abs(c(:))) > 0.1) break; end;
     ICs = S;
     NOCI = nICs;
end
elapsedTime = toc;

end

