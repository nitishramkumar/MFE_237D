function stockprices = GenerateStockPathWithJump(S0,r,T,h,sigma,jump,when)
   %This generates a Geometric Brownian Motion
   stockprices = zeros((T/h)+1,1);
   stockprices(1) = S0;
   for count = 2:length(stockprices)
    stockprices(count) =stockprices(count-1)*(1+r*h + sigma*randn*sqrt(h));
    if((count-1)/(length(stockprices)-1) == when)
        stockprices(count) = stockprices(count) * (1+jump);
    end    
   end
end

        