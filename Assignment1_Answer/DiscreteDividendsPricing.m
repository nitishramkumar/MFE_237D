function [stockprice,optionprice,hedgeportfoliostock,...
    hedgeportfolioriskfree,exerciseDates]=DiscreteDividendsPricing(S0,Payoff,EorA,r,h,u,d,DivDate,delta,T)

% For European, after getting the results, just populate exercise dates
% with 'Dont Exercise'
if(EorA == 'European')
    [stockprice,optionprice,hedgeportfoliostock,...
    hedgeportfolioriskfree] = EuropeanPricing(S0,Payoff,r,h,u,d,T,delta,DivDate);
    exerciseDates = cell(T,T);
    for tau=1:T
        for k=1:T+1-tau
            exerciseDates{k,tau} = 'Don''t Exercise' 
        end
    end

else
    % For American, the results just populate exercise dates
    % with 'Dont Exercise'
    if(EorA == 'American')
        [stockprice,optionprice,hedgeportfoliostock,...
        hedgeportfolioriskfree,exerciseDates] = AmericanPricing(S0,Payoff,r,h,u,d,T,delta,DivDate);
    end
end

