function result = MonteCarloExotic_1(r0,S10,T,h,K,sigma11,sigma12,alpha,beta,delta,NoofSim)
    result = zeros(3,1);
    payoff = zeros(NoofSim,1);
           
    for i = 1:NoofSim
        db1 = randn(T/h,1).*sqrt(h);
        db2 = randn(T/h,1).*sqrt(h);
        
        rt = IR(r0,alpha,beta,delta,db1,T,h);
        s1t = StockExotic1(rt,S10,sigma11,sigma12,T,h,db1,db2);
        payoff(i) = max(s1t(length(s1t))-K,0);
    end
    result(1:3) = MonteCarloResults(payoff,mean(rt),T);
end
