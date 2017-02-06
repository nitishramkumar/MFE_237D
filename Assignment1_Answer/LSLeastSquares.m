function price = LSLeastSquares(N,NoOfPaths)
    global T S0 r sigma K
    h = T/N;
    exercisePositions = zeros(NoOfPaths,1);
    AllPaths = zeros(NoOfPaths,N+1);
    discountFactor = exp(-r*h);
    
    %Construct all paths
    for count = 1:size(AllPaths)
        AllPaths(count,:) = GenerateStockPath(S0,r,T,h,sigma);
    end
   
    exercisePositions(:) = N+1;
    AllPaths(:,N+1) = max(K-AllPaths(:,N+1),0);
    %Loop through all time periods from the back
    for count = 1:N
        currentColumn = N+1-count;
        X = AllPaths(:,currentColumn);
        %Set all the nodes which have greater than K as 0 for this time
        %period (as it is put)
        EX = max(K-X,0);
        X(X>=K,:) = 0;
        Y = zeros(NoOfPaths,1);
        
        validPos = find(X);
        for row = validPos'
            %Discounted value from previous loops
            Y(row) = power(discountFactor,(exercisePositions(row)-currentColumn))*(AllPaths(row,exercisePositions(row)));
        end
        
        %Construct independent variable for the regression.Y = A + BX + BCX2
        RegX = [ones(size(X)) X power(X,2)];
        betas = Y\RegX;
        
        %If value of Exercise at this node is greater than value of Y
        %Then set value as the option value at this node
        %and populate exercise positions accordingly
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
    
    %Calculate discounted value of each path
    totalCashFlow = 0;
    for row = 1:NoOfPaths
        totalDiscount = power(discountFactor,exercisePositions(row)-1);
        totalCashFlow = totalCashFlow + totalDiscount*AllPaths(row,exercisePositions(row));
    end
    
    %Average price
    price = totalCashFlow/NoOfPaths;
end

