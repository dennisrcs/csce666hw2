function dist = euclidian_distance(u, v)
%EUCLIDIAN_DISTANCE Computes the Euclidian distance between vectors x and v
    
    size_x = size(u, 2);
    size_v = size(v, 2);
    
    if size_x ~= size_v
        disp('dimensons do not match'); 
        dist = -1;
    else
        dist = sqrt(sum((u - v) .^ 2));
    end

end

