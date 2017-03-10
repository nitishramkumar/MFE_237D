function price = HestonModel(St,vt,r,T,t,K,rho,sigma,lambda,k,theta)
    result = heston(r,k,theta,sigma);

    tau = T-t;
   
    %P1 =  0.5+ (1/pi).*integral(@(u)HestonIntegration(u,St,vt,r,tau,K,rho,sigma,lambda,k,theta,1),0,100);
    %P2 =  0.5+ (1/pi).*integral(@(u)HestonIntegration(u,St,vt,r,tau,K,rho,sigma,lambda,k,theta,2),0,100);
    
    P1 =  0.5+ (1/pi).*quadgk(@(u)HestonIntegration(u,St,vt,r,tau,K,rho,sigma,lambda,k,theta,1),0,Inf);
    P2 =  0.5+ (1/pi).*quadgk(@(u)HestonIntegration(u,St,vt,r,tau,K,rho,sigma,lambda,k,theta,2),0,Inf);
    
    
    price = St*P1 - K*exp(-r*tau)*P2;
 
end

