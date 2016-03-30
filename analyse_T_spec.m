%%
%   analyse_T_spec
%   Analyse protein for a specific T, should generate L and E values for 
%   each Monte Carlo step for a closer look at the folding process of a
%   protein. Also will display initial and final protein structure

T = 1;
protein_length = 27;
%number_of_runs = 500000;
number_of_runs = 10^5;
init_protein = generate_protein(protein_length);
[E, S, L, MCS_T, min_protein, final_protein] = fold_protein(init_protein, T, number_of_runs);
save(strcat('S-', mat2str(protein_size(min_protein)), '_after_', mat2str(MCS_T), '_steps.mat'), 'E', 'S', 'L', 'min_protein');