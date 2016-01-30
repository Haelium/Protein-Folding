%%
%   Protein folding program created using MATLAB
%   Based on Chapter 12 Computational Physics, N Giordano and  H Nakanishi,
%   Pearson, 2006 and
%   E Shaknovich, G Farztdinov, A Gutin and M Karplus, ""Protein folding bottlenecks:
%   A Lattice Monte Carlo Simulation", Phys. Rev. Lett., 67, 1665, (1991).

clear;
close;

rng('shuffle');
% Initialisation block
% Temperature conditions in Kelvin
T_range = 1:10;
protein_length = 100;
number_of_runs = 500000;
E_temp = zeros(size(number_of_runs));
L_temp = zeros(size(number_of_runs));
E_vs_T = zeros(size(T_range));
L_vs_T = zeros(size(T_range));

monomer_number = 20; % There are 20 monomers occuring in nature
high_interaction = -4;
low_interaction = -2;
% J is a 20x20 matrix of randomly assigned energy values to represent the
% interaction energies betweeen monomers
J = -4 + 2*rand(20,20);

protein = generate_protein(protein_length, monomer_number);

% This loop can be made parallel with changes to step
step = 0;
for T = T_range;
    step = step + 1;    % increment step counter
    % temporarily store results in variable
    [E_temp, L_temp, ~] = fold_protein(protein, T, J, number_of_runs);
    E_vs_T(step) = mean(E_temp);
    L_vs_T(step) = mean(L_temp);
    disp(T);
end

disp('Folding Complete');