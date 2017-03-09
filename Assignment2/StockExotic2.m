function stockPrices = StockExotic2(rt,S20,sigma21,stock1,T,h,db1)
   stockPrices = zeros((T/h)+1,1);
   stockPrices(1) = S20;
   for count = 2:length(stockPrices)
        stockPrices(count) = stockPrices(count-1) + rt(count-1)*stockPrices(count-1)*h...
                            +sigma21*(stock1(count-1) - stockPrices(count-1))*db1(count-1);
   end   
end
