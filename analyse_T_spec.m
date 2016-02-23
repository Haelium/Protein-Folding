%%
%   analyse_T_spec
%   Analyse protein for a specific T, should generate L and E values for 
%   each Monte Carlo step for a closer look at the folding process of a
%   protein. Also will display initial and final protein structure

clear;
close;
figure
rng('shuffle');
% Initialisation block
% Temperature conditions in Kelvin
T = 1;
protein_length = 30;
number_of_runs = 2000000;

monomer_number = 20; % There are 20 monomers occuring in nature
high_interaction = -4;
low_interaction = -2;
% J is a 20x20 matrix of randomly assigned energy values to represent the
% interaction energies betweeen monomers
J = -4 + 2 * rand(20, 20);

init_protein = generate_protein(protein_length, monomer_number);
newprotein = init_protein;

[E, L, final_protein] = fold_protein(init_protein, T, J, number_of_runs);
[E2, L2, newprotein] = fold_protein(newprotein, T, J, number_of_runs);

disp('Folding Complete');