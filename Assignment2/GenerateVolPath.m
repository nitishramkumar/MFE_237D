function volvalues = GenerateVolPath(k,theta,v0,h,sigma,T)
   %This generates a Geometric Brownian Motion
   volvalues = zeros((T/h)+1,1);
   volvalues(1) = v0;
   for count = 2:length(volvalues)
    volvalues(count) = volvalues(count-1) + k*(theta-volvalues(count-1))*h + sigma*(sqrt(volvalues(count-1)))*sqrt(h)*randn;
   end
end

        