function labels = get_labels
%GET_LABELS Summary of this function goes here
%   Detailed explanation goes here
    lbl1 = {};
    for i = 1:250
        lbl1{i} = '1';
    end
    
    lbl2 = {};
    for i = 1:250
        lbl2{i} = '2';
    end
    
    lbl3 = {};
    letter = '3';
    for i = 1:250
        lbl3{i} = '3';
    end
    
    labels = [lbl1, lbl2, lbl3];

end

