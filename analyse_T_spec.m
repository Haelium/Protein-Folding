%%
%   analyse_T_spec
%   Analyse protein for a specific T, should generate L and E values for 
%   each Monte Carlo step for a closer look at the folding process of a
%   protein. Also will display initial and final protein structure

clear;
close;

rng('shuffle');
% Initialisation block
% Temperature conditions in Kelvin
T = 1;
protein_length = 15;
number_of_runs = 5000000;

monomer_number = 20; % There are 20 monomers occuring in nature
high_interaction = -4;
low_interaction = -2;
% J is a 20x20 matrix of randomly assigned energy values to represent the
% interaction energies betweeen monomers
%J = randi([high_interaction, low_interaction], monomer_number, monomer_number);
J = -4 + 2*rand(20,20);

init_protein = generate_protein(protein_length, monomer_number);

[E, L, final_protein] = fold_protein(init_protein, T, J, number_of_runs);

% Plot E vs T
%subplot(2,2,1)
figure
plot(1:number_of_runs, E);
xlabel('Monte Carlo steps');
ylabel('Energy');
legend('Energy vs time');
drawnow;
figure;
% Plot L vs T
%subplot(2,2,2)
plot(1:number_of_runs, L);
xlabel('Monte Carlo steps');
ylabel('End to end length');
legend('Length vs time');
drawnow;
figure;
% display initial protein shape
%subplot(2,2,3);
plot(init_protein(2,:), init_protein(3,:), '.-r', 'MarkerSize', 7);
legend('Initial protein structure');
drawnow;
figure;
% display final protein shape
%subplot(2,2,4);
plot(final_protein(2,:), final_protein(3,:), '.-r', 'MarkerSize', 7);
legend('Final protein structure');
drawnow;
figure

disp('Folding Complete');