clear all; close all; clc;
input = 'sample.wav';
g = 50;
transitionV = [1000, 1500, 2550, 5000];
Psat=100;
y = hearingAidF(input,g,Psat,transitionV,newfile);
