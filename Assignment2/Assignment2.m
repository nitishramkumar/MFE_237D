%%
%
% *Assignment 1*
% *Nitish Ramkumar, Stephan Du Toit, Yvonne Tong Yi, Baihan Chen*
%
%% 1a
clear
clc
S0 = 100;%Initial stock price
T = 0.25;%Maturity years
K = 100;%Strike
r = 0.05; %IR
sigma=0.2; %SD
delta = 0;
h = 1/(360*96); %every 5 minutes, which is 1/96 of a day

randn('seed',0);

NoOfSim = 5;
stockPrices = zeros((T/h)+1,5);
for counter = 1:5
    stockPrices(:,counter) = GenerateStockPath(S0,r,T,h,sigma);
end
plot(stockPrices)
title('Stock path plots')
legend('1','2','3','4','5','Location','northwest')
%% 1b
S0 = 100;%Initial stock price
T = 0.25;%Maturity in days
K = 100;%Strike
r = 0.05; %IR
sigma=0.2; %SD
delta = 0;
h = 1/(360*96); %every 5 minutes, which is 1/96 of a day
c1 = BlackScholes(S0,K,r,sigma,T,'Call')
%% 1c
S0 = 100;%Initial stock price
T = 0.25;%Maturity in days
K = 100;%Strike
r = 0.05; %IR
sigma=0.2; %SD
delta = 0;

randn('seed',0);
%NoOfPaths = [100 1000 1000000 100000000];
NoOfPaths = [10 20];
N = length(NoOfPaths);
priceResult = zeros(N,3);
for count = 1:size(priceResult,1)
    priceResult(count,:) = MonteCarloSim(S0,r,T,K,sigma,NoOfPaths(count));
end    
priceResult

%The price approaches black scholes value
%The spread reduces.

%% 2a
S0 = 100;%Initial stock price
T = 0.25;%Maturity in days
K = 95;%Strike
r = 0.05; %IR
sigma=0.2; %SD
delta = 0;
Sb = 75;
h = 1/(360*96);
NoOfSim = 1000;

randn('seed',0);
MCResult = MonteCarloDownOut(S0,r,T,K,sigma,NoOfSim,h,Sb)
PutOption = BlackScholes(S0,K,r,sigma,T,'Put')

%% 2b
S0 = 100;%Initial stock price
T = 0.25;%Maturity in days
K = 95;%Strike
r = 0.05; %IR
delta = 0;
Sb = 75;
h = 1/(360*96);
NoOfSim = 1000;
sigma = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4];

randn('seed',0);
results = zeros(length(sigma),4);
for count = 1:length(sigma)
    results(count,:) = MonteCarloDownOut(S0,r,T,K,sigma(count),NoOfSim,h,Sb);
end

plot(sigma,results(:,4))
title('Plot of no. of outs wrt to volatility')
xlabel('Volatility')
ylabel('Number of outs')

%We can observe that the number of outs increases with volatility.
%This makes sense because with an increase in volatility, we have a higher
%change of going out of the cutoff.

%% 2c
S0 = 100;%Initial stock price
T = 0.25;%Maturity in days
K = 95;%Strike
r = 0.05; %IR
delta = 0;
Sb = 75;
h = 1/(360*96);
NoOfSim = 1000;
sigma = [0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4];

randn('seed',0);
results = zeros(length(sigma),4);
for count = 1:length(sigma)
    results(count,:) = MonteCarloDownOut(S0,r,T,K,sigma(count),NoOfSim,h,Sb);
end
bsPrice = BlackScholes(S0,K,r,sigma,T,'Put');
errorbar(sigma,results(:,1),results(:,3)-results(:,1))
title('Plot of Monte Carlo put price with error bar and black scholes price')
xlabel('Volatility')
ylabel('price of Put')
hold on
scatter(sigma,bsPrice)
hold off

%% 3a
r0 = 0.05;
beta = 0.05;
alpha = 0.6;
sigma11 = 0.1;
sigma12 = 0.2;
sigma21 = 0.3;
S10 = 10;
S20 = 10;
delta = 0.1;
T = 1;
h = 1/250;

randn('seed',0);
db1 = randn(T/h,1).*sqrt(h);
rt = IR(r0,alpha,beta,delta,db1,T,h);
histogram(rt)

%% 3b
r0 = 0.05;
beta = 0.05;
alpha = 0.6;
sigma11 = 0.1;
sigma12 = 0.2;
sigma21 = 0.3;
S10 = 10;   
S20 = 10;
delta = 0.1;
T = 100;
h = 1/52;
randn('seed',0);
db1 = randn(T/h,1).*sqrt(h);
rt = IR(r0,alpha,beta,delta,db1,T,h);
plot(rt)
%% 3c
r0 = 0.05;
beta = 0.05;
alpha = 0.6;
sigma11 = 0.1;
sigma12 = 0.2;
sigma21 = 0.3;
S10 = 10;
S20 = 10;
delta = 0.1;
T = 0.5;
h = 1/250;
K = 10;
NoofSim = 10000;

randn('seed',0);
results = MonteCarloExotic_1(r0,S10,T,h,K,sigma11,sigma12,alpha,beta,delta,NoofSim);
results(1)

%% 3d
r0 = 0.05;
beta = 0.05;
alpha = 0.6;
sigma11 = 0.1;
sigma12 = 0.2;
sigma21 = 0.3;
S10 = 10;
S20 = 10;
delta = 0.1;
T = 0.5;
h = 1/250;
K = 10;
NoofSim = 10000;

randn('seed',0);
results = MonteCarloMaxExotic(r0,S10,S20,T,h,K,sigma11,sigma12,sigma21,alpha,beta,delta,NoofSim);
results(1)

%% 4a
S0=100;
K = 100;
T=60/365;
h = 1/(96*365);
r = 0.05;
sigma = 0.3;
mu = 0.2;
delta = 0;
randn('seed',0);
stockPricesAll = GenerateStockPath(S0,mu,T,h,sigma);
periodsReq = (30/365)/h;
stockPrices = stockPricesAll(1:(periodsReq+1));
%% 4b
blackScholesPrices = BlackScholes(stockPrices,K,r,sigma,(T:-h:30/365)','Call');

%% 4c
deltas = BlackScholesDelta(stockPrices,K,r,sigma,(T:-h:30/365)','Call');
[replicatingPort,riskFree] = DeltaHedging(stockPrices,blackScholesPrices,deltas,r,h,0);

figure(1)
plot(stockPrices)
title('Underlying')

figure(2)
plot(blackScholesPrices)
hold on
plot(replicatingPort)
legend('Call Option','Replicating Portfolio','location','southwest')
title('Replicating portfolio and blackScholes')
hold off

figure(3)
plot(deltas)
title('Delta')


%% 4d
randn('seed',0);
stockJumpAll = GenerateStockPathWithJump(S0,mu,T,h,sigma,-0.1,0.5);
stockJump = stockJumpAll(1:(periodsReq+1));
BSJump= BlackScholes(stockJump,K,r,sigma,(T:-h:30/365)','Call');
deltasJump = BlackScholesDelta(stockJump,K,r,sigma,(T:-h:30/365)','Call');
[repPortJump,rfJump] = DeltaHedging(stockJump,BSJump,deltasJump,r,h,0);

figure(1)
plot(stockJump)
title('Underlying')

figure(2)
plot(BSJump)
hold on
plot(repPortJump)
legend('Call Option','Replicating Portfolio','location','southwest')
title('Replicating portfolio and blackScholes')
hold off

figure(3)
plot(deltasJump)
title('Delta')

%% 4e
randn('seed',0);
stockJumpAll1 = GenerateStockPathWithJump(S0,mu,T,h,sigma,0.1,0.5);
stockJump1 = stockJumpAll1(1:(periodsReq+1));
BSJump1= BlackScholes(stockJump1,K,r,sigma,(T:-h:30/365)','Call');
deltasJump1 = BlackScholesDelta(stockJump1,K,r,sigma,(T:-h:30/365)','Call');
[repPortJump1,rfJump1] = DeltaHedging(stockJump1,BSJump1,deltasJump1,r,h,0);

figure(1)
plot(stockJump1)
title('Underlying')

figure(2)
plot(BSJump1)
hold on
plot(repPortJump1)
legend('Call Option','Replicating Portfolio','location','southwest')
title('Replicating portfolio and blackScholes')
hold off

figure(3)
plot(deltasJump1)
title('Delta')

%% 4f
[repPortTrans,rfTrans] = DeltaHedging(stockPrices,blackScholesPrices,deltas,r,h,0.002);
figure(1)
plot(stockPrices)
title('Underlying')

figure(2)
plot(blackScholesPrices)
hold on
plot(repPortTrans)
legend('Call Option','Replicating Portfolio','location','southwest')
title('Replicating portfolio and blackScholes')
hold off

figure(3)
plot(deltas)
title('Delta')

%% 5
