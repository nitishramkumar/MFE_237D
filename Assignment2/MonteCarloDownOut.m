function result = MonteCarloDownOut(S0,r,T,K,sigma,NoofSim,h,Sb)
    result = zeros(4,1);
    payoff = zeros(NoofSim,1);
    outs = 0;
    for i = 1:NoofSim
        stockPrices = GenerateStockPath(S0,r,T,h,sigma);
        pos = find(stockPrices<Sb);
        if(any(pos))
            payoff(i) = 0;
            outs = outs + 1;
        else
            payoff(i) = max(K - stockPrices(length(stockPrices)),0);
        end
    end
    result(1:3) = MonteCarloResults(payoff,r,T);
    result(4) = outs;
end
