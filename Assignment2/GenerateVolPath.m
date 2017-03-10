function stockprices = GenerateVolPath(k,theta,v0,h,sigma,T)
   %This generates a Geometric Brownian Motion
   volvalues = zeros((T/h)+1,1);
   stockprices(1) = S0;
   for count = 2:length(stockprices)
    stockprices(count) =stockprices(count-1)*(1+r*h + sigma*randn*sqrt(h));
   end
end

        