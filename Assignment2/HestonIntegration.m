function result = HestonIntegration(u,St,vt,r,tau,K,rho,sigma,lambda,k,theta,j)
    xt = log(St);
    b = [k+lambda-(rho*sigma) k+lambda];
    uVal = [0.5 -0.5];
    %d = sqrt((complex(-b(j),(rho*sigma).*u)).^2 - sigma^2.*complex(-u.^2,u.*(2*uVal(j))));
    d_1 = (-b(j) + rho*sigma*1i.*u).^2;
    d_2 = sigma^2.*(-u.^2 + u.*(2*uVal(j)*1i));
    d = sqrt(d_1-d_2);
    
    g_1 = b(j)+d-((rho*sigma).*u*(1i));
    g_2 = b(j)-d-((rho*sigma).*u*(1i));
    g = g_1./g_2;
    
    A_1 = (r * tau*1i) .* u;
    A_2 = (b(j) + d - (rho*sigma*1i).*u).*(tau*k*theta/(sigma)^2);
    A_3 = (-2*k*theta/(sigma)^2)*log((1-g.*exp(d.*tau))./(1-g));
    A = A_1 + A_2 + A_3;

    B_1 = (b(j) - complex(0,(rho*sigma).*u) + d)./(sigma)^2;
    B_2 = (1 - exp(d.*tau))./(1-(g.*exp(d.*tau)));
    B = B_1.*B_2;
        
    phi = exp(A + B.*vt + complex(0,u.*xt));
    result = real(exp(complex(0,-u.*log(K))).*phi./complex(0,u));

end

