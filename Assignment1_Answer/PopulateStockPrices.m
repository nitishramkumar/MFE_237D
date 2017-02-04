function StockPrices = PopulateStockPrices(S0,u,d,T,delta,D)
StockPrices =cell(T+1,T+1);
% Fill in the initial value (lower left corner) 
StockPrices{T+1,1} = S0;

%Fill in the other values using the number of up moves N=k-1 as a 
%state variable 
for t = 1:T 
  for k = 1:t 
    StockPrices{T+2-k,t+1} = StockPrices{T+2-k,t}*d;
    StockPrices{T+1-k,t+1} = StockPrices{T+2-k,t}*u;
    if(any(D == t+1))    
      StockPrices{T+2-k,t+1} = (1-delta)*(StockPrices{T+2-k,t+1});
      StockPrices{T+1-k,t+1} = (1-delta)*(StockPrices{T+1-k,t+1});
    end
  end
end
end
