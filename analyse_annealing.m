rng('shuffle');
protein_length = 27;
number_of_runs = 500000;
J = J_gaussian(-3, 1);

protein = generate_protein(protein_length);

T = [4 3 2 1];
for step = 1:size(T,2)
    [E(step,:), S(step,:), L(step,:), ~, ~, protein] = fold_protein(protein, T(step), number_of_runs, J);
end

E = [E(1,:), E(2,:), E(3,:), E(4,:)];
S = [S(1,:), S(2,:), S(3,:), S(4,:)];
L = [L(1,:), L(2,:), L(3,:), L(4,:)];