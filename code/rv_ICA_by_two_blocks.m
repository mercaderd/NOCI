function [correlation_data, elapsedTime] = rv_ICA_by_two_blocks(X,maxICs,random,verbose)
%rv_ICA_by_two_blocks Optimal Number of Independant Components determination
%with Rv ICA by blocks method
%
%   Input parameters:
%       X: MxN matrix. N samples of M sensors.
%       maxICs: maximun ICs for calculations
%       random: true or false to apply random order to sensor data for
%          block creation
%       verbose: 0 no verbose, 1 plot RV correlation_data
%
%   Output parameters:
%       correlation_data:  mxICs x 1 Vector with RV coeffs
%       elapsedTime: For timing purpouses
% 
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%

if (nargin < 4) verbose = 0; end;

[nobs,t] = size(X);
if random == true
    irand = randperm(nobs);
    X=X(irand,:);
end
blocks = 2;
block_length = floor(nobs./blocks);
if maxICs > block_length
    error('maxICs can not be greather than number of observations div num blocks');
    return;
end
if blocks < 2
    error('Minimum number of blocks is 2');
    return;
end

block = Inf(block_length,t,blocks);
tic;
parfor i = 1:blocks
    block(:,:,i)=X(((i-1)*block_length+1):(i*block_length),:);
end

correlation_data = zeros(maxICs,1);
block1 = block(:,:,1);
block2 = block(:,:,2);
parfor nICs=1:maxICs
    [A1, ICs1] = jade(block1,nICs);
    [A2, ICs2] = jade(block2,nICs);
    correlation_data(nICs) = RV_coeff(ICs1,ICs2);
end
elapsedTime = toc;

if verbose > 0
    h = figure;
    plot(correlation_data','-x');
    ylabel('RV coeff');
    xlabel('# ICs');
    title('RV ICA by two Blocks');
    ylimits=ylim;
    ylimits(2) = 1.1;
    ylim(ylimits);
    print(h,sprintf('rvICA%d.png',nobs),'-dpng');
end;
end
