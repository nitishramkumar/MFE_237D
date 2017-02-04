function price = LSLeastSquares(N,NoOfPaths)
    global T S0 r sigma K
    h = T/N;
    exercisePositions = zeros(NoOfPaths,1);
    AllPaths = zeros(NoOfPaths,N+1);
    discountFactor = exp(-r*h);
    
    for count = 1:size(AllPaths)
        AllPaths(count,:) = GenerateStockPath(S0,r,T,h,sigma);
    end
   
    exercisePositions(:) = N+1;
    AllPaths(:,N+1) = max(AllPaths(:,N+1)-K,0);
    for count = 1:N
        currentColumn = N+1-count;
        X = AllPaths(:,currentColumn);
        X(X<=K,:) = 0;
        EX = max(X-K,0);
        Y = zeros(NoOfPaths,1);
        
        validPos = find(X);
        for row = validPos'
            Y(row) = power(discountFactor,(exercisePositions(row)-currentColumn))*(AllPaths(row,exercisePositions(row)));
        end
        
        RegX = [ones(size(X)) X power(X,2)];
        betas = regress(Y,RegX);
        
        AllPaths(:,currentColumn) = zeros(NoOfPaths,1);
        for row = validPos'
            regressPredict = betas(1) + betas(2)*X(row) + betas(3)*power(X(row),2);
            if(EX(row) > regressPredict)
                AllPaths(row,currentColumn) = EX(row);
                AllPaths(row,exercisePositions(row)) = 0;
                exercisePositions(row) = currentColumn;
            end
        end    
    end
    
    totalCashFlow = 0;
    for row = 1:NoOfPaths
        totalDiscount = power(discountFactor,exercisePositions(row)-1);
        totalCashFlow = totalCashFlow + totalDiscount*AllPaths(row,exercisePositions(row));
    end
    
    price = totalCashFlow/NoOfPaths;
end

