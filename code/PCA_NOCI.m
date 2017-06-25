function  [autv, elapsedTime] = PCA_NOCI(X,random,verbose)
% PCA_NOCI Optimal Number of Independant Components 
% determination with PCA based method
%
%   Input parameters:
%       X: MxN matrix. N samples of M sensors.
%       maxICs: maximun ICs for calculations
%       verbose: 0 no verbose, 1 plot eigenvalues
%
%   Output parameters:
%       cautov:   Vector with eigenvalues
%       elapsedTime: For timing purpouses
% 
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%

if (nargin < 3) verbose = 0; end;

[nobs,n] = size(X);
if random == true
    irand = randperm(nobs);
    X=X(irand,:);
end;
tic;
 %X = X - mean(X,2)*ones(1,n);
[A,B,C]=svd(X,0);
autv=diag(B).^2;

elapsedTime=toc;

if verbose > 0 
    h=figure;
    plot(autv,'r');
    ylabel('eigenvalues');
    xlabel('# PC Index');
    title('PCA method');
    print(h,sprintf('PCA%d.png',nobs),'-dpng');
end;
end
