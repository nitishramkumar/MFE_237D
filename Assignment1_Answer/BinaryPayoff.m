function binaryPayoff = BinaryPayoff(stockPrice)
    global K
    if(stockPrice >= K)
        binaryPayoff = 100;
    else
        binaryPayoff = 0;
    end
end

