%%
%   Protein folding program created using MATLAB
%   Based on Chapter 12 Computational Physics, N Giordano and  H Nakanishi,
%   Pearson, 2006 and
%   E Shaknovich, G Farztdinov, A Gutin and M Karplus, ""Protein folding bottlenecks:
%   A Lattice Monte Carlo Simulation", Phys. Rev. Lett., 67, 1665, (1991).

clear;
close;

% Initialisation block
% Temperature conditions in Kelvin
T_range = 1:0.2:10;
protein_length = 15;
number_of_runs = 500000;
E = zeros(size(T_range));
L = zeros(size(T_range));

monomer_number = 20; % There are 20 monomers occuring in nature
high_interaction = -4;
low_interaction = -2;
% J is a 20x20 matrix of randomly assigned energy values to represent the
% interaction energies betweeen monomers
J = randi([high_interaction, low_interaction], monomer_number, monomer_number);

protein = generate_protein(protein_length, monomer_number);

step = 0;
for T = T_range;
    step = step + 1;    % increment step counter
    % temporarily store results in variable
    [E(step), L(step), ~] = fold_protein(protein, T, J, number_of_runs);
    disp(step);
end

disp('Folding Complete');