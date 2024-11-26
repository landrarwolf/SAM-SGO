function [output] = alpha_f(Alpha,fX)
    output = 0;
    
    for i = 1 : size(Alpha)
        output = output + Alpha(i) .* fX{i};
    end
end