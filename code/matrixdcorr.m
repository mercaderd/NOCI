function C = matrixdcorr( S )
% matrixdcorr Distance Correlation Matrix
%
% matrixdcorr  Version 1  Oct 2016
%
% Usage: 
%   * If S is an NxT data matrix (N sensors, T samples) then 
%       C = matrixdcorr(S) is a NxN Distance Correlation Matrix 
%
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%
%

[m,n] = size(S);
    C=zeros(m);
    for i=1:m
        for j=1:m
            C(i,j)=dcorr(S(i,:)',S(j,:)');
        end
    end
end

