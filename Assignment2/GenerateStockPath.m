function stockprices = GenerateStockPath(S0,r,T,h,sigma)
   %This generates a Geometric Brownian Motion
   stockprices = zeros((T/h)+1,1);
   stockprices(1) = S0;
   for count = 2:length(stockprices)
    stockprices(count) =stockprices(count-1)*(1+r*h + sigma*randn*sqrt(h));
   end
end

        