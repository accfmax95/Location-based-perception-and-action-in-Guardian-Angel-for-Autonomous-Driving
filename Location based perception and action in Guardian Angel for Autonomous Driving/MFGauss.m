function y = MFGauss(x, p)

        y = normpdf(x, p(1), p(2));
        y = y/max(normpdf(0:150,p(1),p(2)));
    
end