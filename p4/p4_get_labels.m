function labels = p4_get_labels(num)
%GET_LABELS Summary of this function goes here
%   Detailed explanation goes here
    lbl1 = zeros(num, 3);
    for i = 1:num
        lbl1(i, :) = [0 0.4470 0.7410];
    end
    
    lbl2 = zeros(num, 3);
    for i = 1:num
        lbl2(i, :) = [0.8500 0.3250 0.0980];
    end
    
    lbl3 = zeros(num, 3);
    for i = 1:num
        lbl3(i, :) = [0.9290 0.6940 0.1250];
    end
    
    labels = [lbl1; lbl2; lbl3];
end

