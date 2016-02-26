clear;
close;

rng('shuffle');
% Initialisation block
% Temperature conditions in Kelvin
protein_length = 30;
number_of_runs = 500000;
monomer_number = 20; % There are 20 monomers occuring in nature
% J is a 20x20 matrix of randomly assigned energy values to represent the
% interaction energies betweeen monomers
J = -4 + 2 * rand(20, 20);

protein = generate_protein(protein_length, monomer_number);

T = [4 3 2 1];
for step = 1:size(T,2)
    step
    [E(step,:), L(step,:), protein] = fold_protein(protein, T(step), J, number_of_runs);
end