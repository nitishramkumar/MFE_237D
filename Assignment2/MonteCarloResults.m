function MCResult = MonteCarloResults(payoff,r,T)
    MCResult = zeros(3,1);
    MCSd = std(payoff * exp(-r * T))/sqrt(length(payoff));
    MCPrice = mean(payoff) * exp(-r*T);
    confidenceInt1 = MCPrice - (1.96*MCSd);
    confidenceInt2 = MCPrice + (1.96*MCSd);
    MCResult(1) = MCPrice;
    MCResult(2) = confidenceInt1;
    MCResult(3) = confidenceInt2;
end

