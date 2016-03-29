clear;
close;


mex pro_energy.cpp  % Compile mex file

rng('shuffle');
% Initialisation block
% Temperature conditions in Kelvin
protein_length = 30;
number_of_runs = 500000;

protein = generate_protein(protein_length);

T = [4 3 2 1];
for step = 1:size(T,2)
    step
    [E(step,:), L(step,:), protein] = fold_protein(protein, T(step), number_of_runs);
end

E = [E(1,:), E(2,:), E(3,:), E(4,:)];
L = [L(1,:), L(2,:), L(3,:), L(4,:)];