%%
%   analyse_T_spec
%   Analyse protein for a specific T, should generate L and E values for 
%   each Monte Carlo step for a closer look at the folding process of a
%   protein. Also will display initial and final protein structure

T = 1;
protein_length = 27;
%number_of_runs = 500000;
number_of_runs = 10^4;
init_protein = generate_protein(protein_length, 20);
[E, L, final_protein] = fold_protein(init_protein, T, number_of_runs);
save(strcat(datestr(now, 'dd_mmm_yy_HHMM'),'-', mat2str(number_of_runs), '_steps_at_', mat2str(T), 'K'), 'E', 'L', 'final_protein');