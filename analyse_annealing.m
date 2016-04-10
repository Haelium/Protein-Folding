rng('shuffle');
protein_length = 27;
number_of_runs = 500000;
J = -4 + 2 * rand(20,20);

protein = generate_protein(protein_length);

T = [6 5 4 3 2];
for step = 1:size(T,2)
    [E(step,:), S(step,:), L(step,:), ~, ~, protein] = fold_protein(protein, T(step), number_of_runs, J);
end

E = [E(1,:), E(2,:), E(3,:), E(4,:), E(5,:)];
S = [S(1,:), S(2,:), S(3,:), S(4,:), S(5,:)];
L = [L(1,:), L(2,:), L(3,:), L(4,:), L(5,:)];