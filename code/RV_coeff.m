function RV=RV_coeff(X,Y)
%   RV = RV_coeff(X,Y) is a matrix with RV coefficients for X and Y matrices
%
% RV_coeffs.  Version 1  Oct 2016
%
% Usage: 
%   * If X is an NxT data matrix (N sensors, T samples) and Y is other data matrix
%   (M sensors, T samples) then RV=RV_coeff(X,Y) is a NxM matrix with RV coeffs. 
%
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 

AA=X'*X;
BB=Y'*Y;
AAAA=AA*AA;
BBBB=BB*BB;
RV = abs(trace(AA*BB)/sqrt(trace(AAAA)*trace(BBBB)));

