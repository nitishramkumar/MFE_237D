function result = HestonIntegration(u,St,vt,r,tau,K,rho,sigma,lambda,k,theta,j)
    xt = log(St);
    b = [k+lambda-(rho*sigma) k+lambda];
    uVal = [0.5 -0.5];

    d = sqrt((complex(-b(j),(rho*sigma).*u)).^2 - sigma^2.*complex(-u.^2,u.*(2*uVal(j))));
    g = (b(j)+d-complex(0,(-rho*sigma).*u))./(b(j)-d-complex(0,(-rho*sigma).*u));
   
    A_1 = complex(0,(r * tau) .* u);
    A_2 = (b(j) + d - complex(0,(rho*sigma).*u)).*(tau*k*theta/(sigma)^2);
    A_3 = (-2*k*theta/(sigma)^2)*log((1-g.*exp(d.*tau))./(1-g));
    A = A_1 + A_2 + A_3;

    B_1 = (b(j) - complex(0,(rho*sigma).*u) + d)./(sigma)^2;
    B_2 = (1 - exp(d.*tau))./(1-(g.*exp(d.*tau)));
    B = B_1.*B_2;
        
    phi = exp(A + B.*vt + complex(0,u.*xt));
    result = real(exp(complex(0,-u.*log(K))).*phi./complex(0,u));

end

