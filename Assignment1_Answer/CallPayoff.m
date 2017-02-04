function callPayoff = CallPayoff(stockPrice)
    global K
    callPayoff = max(stockPrice-K,0);
end
