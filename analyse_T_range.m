%%
%   Protein folding program created using MATLAB
%   Based on Chapter 12 Computational Physics, N Giordano and  H Nakanishi,
%   Pearson, 2006 and
%   E Shaknovich, G Farztdinov, A Gutin and M Karplus, ""Protein folding bottlenecks:
%   A Lattice Monte Carlo Simulation", Phys. Rev. Lett., 67, 1665, (1991).

clear;
close;

mex pro_energy.cpp  % Compile mex file

rng('shuffle');
% Initialisation block
% Temperature conditions in Kelvin
protein_length = 100;
number_of_runs = 500000;
E_vs_T = zeros(size(100));
L_vs_T = zeros(size(100));

monomer_number = 20; % There are 20 monomers occuring in nature
% J is a 20x20 matrix of randomly assigned energy values to represent the
% interaction energies betweeen monomers
J = -4 + 2 * rand(20, 20);

protein = generate_protein(protein_length, monomer_number);


T = [ 10, 9.5, 9, 8.5, 8, 7.5, 7, 6.5, 6, 5.5, 5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1, 0.5, 0]
% This loop can be made parallel with changes to step
for step = 1:size(T, 2);
    T(step)
    % temporarily store results in variable
    [E_temp, L_temp, protein] = fold_protein(protein, T(step), number_of_runs);
    E_vs_T(step) = mean(E_temp);
    L_vs_T(step) = mean(L_temp);
end

disp('Folding Complete');