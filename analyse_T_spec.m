%%
%   analyse_T_spec
%   Analyse protein for a specific T, should generate L and E values for 
%   each Monte Carlo step for a closer look at the folding process of a
%   protein. Also will display initial and final protein structure

clear;
close;

% Initialisation block
% Temperature conditions in Kelvin
T = 10;
protein_length = 15;
number_of_runs = 500000;
E = zeros(size(number_of_runs));
L = zeros(size(number_of_runs));

monomer_number = 20; % There are 20 monomers occuring in nature
high_interaction = -4;
low_interaction = -2;
% J is a 20x20 matrix of randomly assigned energy values to represent the
% interaction energies betweeen monomers
J = randi([high_interaction, low_interaction], monomer_number, monomer_number);

init_protein = generate_protein(protein_length, monomer_number);

[E, L, final_protein] = fold_protein(init_protein, T, J, number_of_runs);

disp('Folding Complete');