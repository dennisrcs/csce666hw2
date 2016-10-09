function labels = p4_get_labels(num)
%GET_LABELS Summary of this function goes here
%   Detailed explanation goes here
    lbl1 = zeros(1, num);
    for i = 1:num
        lbl1(i) = 1;
    end
    
    lbl2 = zeros(1, num);
    for i = 1:num
        lbl2(i) = 2;
    end
    
    lbl3 = zeros(1, num);
    for i = 1:num
        lbl3(i) = 3;
    end
    
    labels = [lbl1, lbl2, lbl3];
end

