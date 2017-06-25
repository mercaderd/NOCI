% Test05.m
% Script for timing tests over observations created from 
% Set1 independant signals
%
% Author: Daniel Mercader (mercaderd@yahoo.es)
% Universidad Nacional de Educación a Distancia 
%
clear all;
close all;
n_samples_per_sec = 500;
n_secs = 4;
timeSet2 = linspace(0,n_secs,n_samples_per_sec*n_secs);
load('Set1.mat');
mixed_signals = [14 20 100 200];
max_iter = 50;
maxICs = 7;
Afor5 = cell(size(mixed_signals,2),max_iter);

timing_matrix = zeros(size(mixed_signals,2),5);
avg_timing_matrix = zeros(size(mixed_signals,2),5);

for j = 1:max_iter
    for i = 1:size(mixed_signals,2)
        Afor5{i,j} = rand(mixed_signals(i),5);
        X =  Afor5{i,j} * S;
        [DW,timing_matrix(i,1)]=DWCriterion(X, maxICs,0);
        [cData1, timing_matrix(i,2)] = ICA_by_two_blocks(X,maxICs,true,0);
        [cData2, timing_matrix(i,3)] = rv_ICA_by_two_blocks(X,maxICs,true,0);
        [autov, timing_matrix(i,4)] = PCA_NOCI(X,true,0);
        [ICs, noci ,timing_matrix(i,5)]=LCC_NOCI(X,0);
    end;
    avg_timing_matrix = avg_timing_matrix + (timing_matrix / max_iter);
end;

avg_timing_matrix