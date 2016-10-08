k = [1, 2, 5, 10, 20, 50];

for i = 1:size(k, 2)
    disp(strcat('Running for k = ', num2str(k(i))));
    
    % Running code for parts a, b and c
    p5_parts_abc;

    % Running code for parts d, e, f and g
    p5_parts_defg;

    % Running code for parts h, i, j and k
    p5_parts_hijk;
end