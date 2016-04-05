function [] = par_fold_fixed( simulations, length, T, steps)
    min_E = zeros(1,simulations);
    min_S = zeros(1,simulations);
    min_L = zeros(1,simulations);
    steps_to_min = zeros(1,simulations);
    parfor i = 1:simulations
        [min_E(i), min_S(i), min_L(i), steps_to_min(i)] = find_minimum(length, T, steps)
    end
    save(strcat(mat2str(simulations),'_simulations_at_', datestr(now, 'mm-dd-yy_HH-MM-SS')), 'min_E', 'min_S', 'min_L', 'steps_to_min');
end

