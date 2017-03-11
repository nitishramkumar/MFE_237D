function price = HestonModel(St,vt,r,T,t,K,rho,sigma,lambda,k,theta)

    tau = T-t;
    %volPath = GenerateVolPath(k,theta,vt,tau,sigma,tau);
    %stockPath = GenerateStockPath_Heston(St,r,tau,sigma);
    P1 =  0.5+ (1/pi).*integral(@(u)HestonIntegration(u,St,vt,r,tau,K,rho,sigma,lambda,k,theta,1),0,5000);
    P2 =  0.5+ (1/pi).*integral(@(u)HestonIntegration(u,St,vt,r,tau,K,rho,sigma,lambda,k,theta,2),0,5000);

    price = St*P1 - K*exp(-r*tau)*P2;
 
end

