function [DWMatrix, elapsedTime] = DWCriterion(X,maxICs,verbose)
% DWCriterion Optimal Number of Independant Components determination by
% Durbin-Watson Criteria
% 
%   Input parameters:
%       X: MxN matrix. N samples of M sensors.
%       maxICs: maximun ICs for calculations
%       verbose: 0 No verbose, 1 plot DWMatrix, 2 plot residual matrices
%
%   Output parameters:
%       DWMatrix: M x maxICs matrix with Durbin Watson of residual
%       matrices
%       elapsedTime: For timing purpouses
% 
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%
if (nargin < 3) verbose = 0; end;
[nobs,t] = size(X);
if maxICs > nobs
    error('maxICs can not be greather than number of observations');
    DWMatrix = 0;
    return;
end
DWMatrix = Inf(maxICs,nobs);
tic;
for nICs=1:maxICs
    [A,S] = jade(X,nICs);
    Xest = A*S;
    Xr = X - Xest;
    DWMatrix(nICs,:)=DW(Xr);
    if verbose > 1
         % Solo para pruebas
         figure('Name','Residuals');
         title(sprintf('Mixed Matrix Residuals for NCI=%d', nICs));
         m = size(Xr,1);

         for i=1:m
            subplot(m,1,i);
            plot(Xr(i,:));
            if (i==1) 
                title(sprintf('Mixed Matrix Residuals for NCI=%d', nICs)); 
            end; 
            if (i==m) xlabel('samples'); end;
            ylabel(sprintf('X_r_%d', i));
         end
        %Solo para pruebas
    end;
end;
elapsedTime = toc;


if verbose > 0
    h=figure; 
    clims = [0 2];
    imagesc(DWMatrix,clims);
    xlabel('Mixed Signals Index');
    ylabel('# ICs');
    colorbar;
    title('Durbin-Watson Criterion');
    print(h,sprintf('DW%d.png',nobs),'-dpng');
end

