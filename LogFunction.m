function h = LogFunction(n, sigma)
    for i = 1 : n  
        for j = 1 : n 
            x = double(i-(n+1)/2);
            y = double(j-(n+1)/2);
            sigma = double(sigma);
            
            h(i,j) = (-1/(pi * sigma^4)) * (1 - (x^2 + y^2) / (2 * sigma^2)) * exp(-(x^2 + y^2) / (2 * sigma^2)); 
        end 
    end 
end

