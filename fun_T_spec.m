function [] = fun_T_spec( length, T, steps )
    init_protein = generate_protein(length);
    [E, L, final_protein] = fold_protein(init_protein, T, steps);
	save(strcat(datestr(now, 'dd_mmm_yy_HHMM'),'-', mat2str(steps), '_steps_at_', mat2str(T), 'K_', mat2str(randi(9999))), 'E', 'L', 'final_protein');
end

