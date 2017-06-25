function [correlation_data, elapsedTime] = ICA_by_two_blocks(X,maxICs,random,verbose)
%ICA_by_two_blocks Optimal Number of Independant Components determination
%with ICA by blocks method
%
%   Input parameters:
%       X: MxN matrix. N samples of M sensors.
%       maxICs: maximun ICs for calculations
%       random: true or false to apply random order to sensor data for
%          block creation
%       verbose: 0 no verbose, 1 plot correlation_data
%
%   Output parameters:
%       correlation_data: Cell Array with correlation data
%       elapsedTime: For timing purpouses
% 
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%
if (nargin < 4) verbose = 1; end;

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

correlation_data = cell(maxICs,1);
block1 = block(:,:,1);
block2 = block(:,:,2);
parfor nICs=1:maxICs
    [A1, ICs1] = jade(block1,nICs);
    [A2, ICs2] = jade(block2,nICs);
    correlation_data{nICs} = sort(max(abs(corr(ICs1',ICs2')),[],2),'descend');
end
elapsedTime = toc;
if verbose > 0
    h = figure;
    hold all;
    leyendas = cell(maxICs,1);
    for i=1:length(correlation_data)
            plot(correlation_data{i},'-x');
            leyendas{i}=sprintf('#%i maxICs', i);
    end;
    legend(leyendas);
    ylabel('absolute correlation value |r|');
    xlabel('# IC');
    title('ICA by two blocks');
    ylimits=ylim;
    ylimits(2) = 1.1;
    ylim(ylimits);
    print(h,sprintf('ICA%d.png',nobs),'-dpng');
end;
end
