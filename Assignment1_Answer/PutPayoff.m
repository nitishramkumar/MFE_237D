function putPayoff = PutPayoff(stockPrice)
    global K
    putPayoff = max(K-stockPrice,0);
end
