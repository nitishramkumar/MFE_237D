function [stockprice,optionprice,hedgeportfoliostock,...
    hedgeportfolioriskfree,exerciseDates]=AmericanPricing(S0,Payoff,r,h,u,d,T,delta,DivDates)

Discount = exp(-r*h);
%Risk-neutral measure
q=(Discount^(-1)-d)/(u - d);

StockPrices = PopulateStockPrices(S0,u,d,T,delta,DivDates);

OptionPrices=cell(T+1,T+1);

%Fill the terminal values using the given payoff function
for k=1:T+1
    OptionPrices{T+2-k,T+1}=Payoff(StockPrices{T+2-k,T+1});
end
% 

ExerciseDates = cell(T,T);
%Fill in the other values backwards using the martingale property
for tau=1:T
    for k=1:T+1-tau
        valueIfExercised = Payoff(StockPrices{T+2-k,T+1-tau});
        valueIfNotExercised = Discount*(q*OptionPrices{T+1-k,T+2-tau}+(1-q)*...
            OptionPrices{T+2-k,T+2-tau});
        OptionPrices{T+2-k,T+1-tau}= max(valueIfExercised,valueIfNotExercised);
        
        %Check if the exercise should happen at this node
        if(valueIfExercised > valueIfNotExercised)
            ExerciseDates{T+2-k,T+1-tau} = 'Exercise';
        else
            ExerciseDates{T+2-k,T+1-tau} = 'Don''t Exercise';
        end
    end
end

%Compute the hedging portfolio at each node of the tree 
%Define two matrices : one for riskless amounts and one for units of the stock 
pi0=cell(T+1,T+1);
pi=cell(T+1,T+1);

%Compute the hedge and put it together in a single matrix
for tau=1:T
    for k=1:T+1-tau
        pi{T+2-k,T+1-tau}=(OptionPrices{T+1-k,T+2-tau}-OptionPrices{T+2-k,T+2-tau})/...
            (StockPrices{T+1-k,T+2-tau}-StockPrices{T+2-k,T+2-tau});
        pi0{T+2-k,T+1-tau}=exp(-r*h)*(OptionPrices{T+1-k,T+2-tau}-...
            pi{T+2-k,T+1-tau}*StockPrices{T+1-k,T+2-tau});
    end
end

stockprice=StockPrices;
optionprice=OptionPrices;
hedgeportfoliostock=pi;
hedgeportfolioriskfree=pi0;
exerciseDates = ExerciseDates;
end