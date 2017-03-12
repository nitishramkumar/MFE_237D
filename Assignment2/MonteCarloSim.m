function result = MonteCarloSim(S0,r,T,K,sigma,NoofSim)
    payoff = zeros(NoofSim,1);
    for i = 1:NoofSim
        stockP = S0*(exp((r-(sigma*sigma/2))*T + sigma*randn*sqrt(T)));
        payoff(i) = max(stockP-K,0);
    end
    
    result = MonteCarloResults(payoff,r,T);
end

