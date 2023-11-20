function y = MFS(x, p)
    
    y = normcdf(x, p(1), p(2));

    if (p(3) == -1)
        y = 1-y;
    end

end