% Test04.m
% Script for tests over observations created from 
% Set3 independant signals
%
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%
clear all;
close all;
n_samples_per_sec = 256;
n_secs = 5;
timeSet1 = linspace(0,n_secs,n_samples_per_sec*n_secs);
load('Set3.mat');
%S=S(1:4,1:20000);
maxICs = 10;
load('Afor4.mat');

timing_matrix = zeros(size(Afor4,1),5);
noci=zeros(size(Afor4,1),1);
ref = zeros(size(Afor4,1),1);

for i = 1:size(Afor4,1)
    X =  Afor4{i} * S;
    [DW,timing_matrix(i,1)]=DWCriterionR(X, maxICs,1);
    [cData1, timing_matrix(i,2)] = ICA_by_two_blocksR(X,maxICs,true,1);
    %[cData2, timing_matrix(i,3)] = rv_ICA_by_two_blocks(X,maxICs,true,1);
    %[autov, timing_matrix(i,4)] = PCA_NOCI(X,true,1);
    [ICs, noci(i,1) ,timing_matrix(i,5)]=LCC_NOCIR(X,1);
    ref(i,1)= size(Afor4{i},1);
end;

h=figure;
plot(ref',noci','-x');
ylabel('NOCI');
xlabel('# ICs');
title('LCC METHOD FOR TEST04');
print(h,'LCC.png','-dpng');
