function colors = map_into_color(clab)
%MAP_INTO_COLOR Summary of this function goes here
%   Detailed explanation goes here
    clab_size = size(clab, 1);
    colors = zeros(clab_size, 3);
    for i = 1:clab_size
        if clab(i) == 1
        	colors(i, :) = [0 0.4470 0.7410];
        elseif clab(i) == 2
            colors(i, :) = [0.8500 0.3250 0.0980];
        else
            colors(i, :) = [0.9290 0.6940 0.1250];
        end
    end
end

