function [lambda,mu] = matForStress(E,nu)

mu = E/(2*(1+nu));   %剪切模量
nu = nu/(1+nu);
lambda = (2*mu*nu)/(1-2*nu);
