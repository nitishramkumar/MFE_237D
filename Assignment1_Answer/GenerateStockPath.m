function stockprices = GenerateStockPath(S0,r,T,h,sigma)
   %Discount = exp(-r*h);
   %prob=(Discount^(-1)-d)/(u - d);
   %stockprices = zeros((T/h)+1,1);
   %stockprices(1) = S0;

   %randomBinoms = binornd(1,prob,T/h,1); 
   %for count = 1:length(randomBinoms)
    %    stockprices(count+1) = stockprices(count) * (u*randomBinoms(count) + d*(1-randomBinoms(count))); 
   %end
   
   stockprices = zeros((T/h)+1,1);
   stockprices(1) = S0;
   for count = 2:length(stockprices)
    stockprices(count) =stockprices(count-1)*(1+r*h + sigma*randn*sqrt(h));
   end
   

end

