% Test02.m
% Script for tests over observations created from 
% Set1 independant signals
%
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%
clear all;
close all;
n_samples_per_sec = 256;
n_secs = 5;
timeSet1 = linspace(0,n_secs,n_samples_per_sec*n_secs);
load('Set1.mat');
maxICs = 10;
load('Afor5.mat');

timing_matrix = zeros(size(Afor5,1),5);
noci=zeros(size(Afor5,1),1);
ref = zeros(size(Afor5,1),1);

for i = 1:size(Afor5,1)
    X =  Afor5{i} * S;
    [DW,timing_matrix(i,1)]=DWCriterion(X, maxICs,1);
    [cData1, timing_matrix(i,2)] = ICA_by_two_blocks(X,maxICs,true,1);
    [cData2, timing_matrix(i,3)] = rv_ICA_by_two_blocks(X,maxICs,true,1);
    [autov, timing_matrix(i,4)] = PCA_NOCI(X,true,1);
    [ICs, noci(i,1) ,timing_matrix(i,5)]=LCC_NOCI(X,1);
    ref(i,1)= size(Afor5{i},1);
end;

h=figure;
plot(ref',noci','-x');
ylabel('NOCI');
xlabel('# ICs');
title('LCC METHOD FOR TEST02');
print(h,'LCC.png','-dpng');