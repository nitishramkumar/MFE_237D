function price = BlackScholes(S0,K,r,sigma,T,type)
    d1 = (log(S0./K) + (r + (sigma.^2)/2).*T)./(sigma.*sqrt(T));
    d2 = d1 - sigma.*sqrt(T);
    if(strcmp(type,'Call'))
        price = normcdf(d1).* S0  - normcdf(d2).* (K .*(exp(-r.*T)));
    else
        price = normcdf(-d2) .* (K.*exp(-r.*T)) - normcdf(-d1) .* S0;
    end

end

