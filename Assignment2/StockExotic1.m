
function stockPrices = StockExotic1(rt,S10,sigma11,sigma12,T,h,db1,db2)
   stockPrices = zeros((T/h)+1,1);
   stockPrices(1) = S10;
   for count = 2:length(stockPrices)
        stockPrices(count) = stockPrices(count-1) + rt(count-1)*stockPrices(count-1)*h...
                            +sigma11*sqrt(stockPrices(count-1))*db1(count-1)...
                            +sigma12*stockPrices(count-1)*db2(count-1);
   end   
end

