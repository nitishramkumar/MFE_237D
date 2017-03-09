function deltas = BlackScholesDelta(S0,K,r,sigma,T,type)
    d1 = (log(S0./K) + (r + (sigma.^2)/2).*T)./(sigma.*sqrt(T));
    if(strcmp(type,'Call'))
        deltas = normcdf(d1);
    else
        deltas = normcdf(-d1);
    end

end

