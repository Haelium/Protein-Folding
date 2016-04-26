protein_length = 100;
number_of_runs = 500000;
E_vs_T = zeros(size(21));
S_vs_L = zeros(size(21));
L_vs_T = zeros(size(21));

J = J_gaussian(-3,1);

protein = generate_protein(protein_length);

T = [ 10, 9.5, 9, 8.5, 8, 7.5, 7, 6.5, 6, 5.5, 5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1, 0.5 0]
% This loop can be made parallel with changes to step
for step = 1:size(T, 2);
    T(step)
    % temporarily store results in variable
    [E_temp, S_temp, L_temp, ~, ~, protein] = fold_protein(protein, T(step), number_of_runs, J);
    E_vs_T(step) = mean(E_temp)
    S_vs_T(step) = mean(S_temp)
    L_vs_T(step) = mean(L_temp)
end