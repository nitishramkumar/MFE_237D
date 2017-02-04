function straddlePayoff = StraddlePayoff(stockPrice)
    global K
    straddlePayoff = 0;
    if(stockPrice > K)
       straddlePayoff = stockPrice - K;
    else
        if(stockPrice < K)
            straddlePayoff = K - stockPrice;
        end
    end
end
