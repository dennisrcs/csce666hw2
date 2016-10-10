% Running code for parts a, b and c
p5_parts_abc;

% Running code for parts d, e, f and g
p5_parts_defg;

% Running code for parts h, i, j and k
p5_parts_hijk;

% Plotting accuracy for different k's
figure;
semilogx(ks, accs_parts_abc, 'LineWidth', 2);
hold on;
semilogx(ks, accs_parts_defg, 'LineWidth', 2);
hold on;
semilogx(ks, accs_parts_hijk, 'LineWidth', 2);
hold off;
xlabel('k'); ylabel('average accuracy');
legend('High-Dimensional Data', 'PCA projection', 'LDA projection');
axis([0 500 0.3 0.75]);