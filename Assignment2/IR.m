function irs = IR(r0,alpha,beta,delta,db1,T,h)
   irs = zeros((T/h)+1,1);
   irs(1) = r0;
   for count = 2:length(irs)
        irs(count) = irs(count-1) + alpha *(beta-irs(count-1))*h ...
                     + delta*sqrt(irs(count-1))*db1(count-1);
   end   
end
