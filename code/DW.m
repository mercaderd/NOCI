function  dw = DW(R)
%   dw = DW(R) is an n*1 matrix with Durbin-Watson (DW) criterion for temporal
%   series in rows of nxT matrix R. Each row of R is consideres as a
%   temporal serie.
%
% Durbin-Criterion.  Version 1  Oct 2016
%
% Usage: 
%   * If R is an nxT data matrix (n sensors, T samples) then
%     dw=DW(R) is a nx1 matrix such that every element is the DW criterion
%      of each row in R.
%
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%
%

R1 = circshift(R,-1,2);
R2 = R1 - R;
R2 = R2(:,[1 : end-1]);
num = sum(R2.^2,2);
den = sum(R.^2,2);
dw=real(num./den)';
end

