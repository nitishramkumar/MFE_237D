function binaryPayoff = BinaryPayoff(stockPrice)
    global K
    if(stockPrice >= K)
        binaryPayoff = K;
    else
        binaryPayoff = 0;
    end
end

