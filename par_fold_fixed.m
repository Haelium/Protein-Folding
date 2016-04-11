function [] = par_fold_fixed( simulations, length, T, steps, J_mu, J_sigma)
    J = J_gaussian(J_mu, J_sigma);
    min_E = zeros(1,simulations);
    min_S = zeros(1,simulations);
    min_L = zeros(1,simulations);
    steps_to_min = zeros(1,simulations);
    parfor i = 1:simulations
        [min_E(i), min_S(i), min_L(i), steps_to_min(i)] = find_minimum(length, T, steps, J)
    end
    save(strcat(mat2str(simulations),'_sims_time-', datestr(now, 'mm-dd-yy_HH-MM-SS'), '_T-', mat2str(T), '_Jmu_', mat2str(J_mu), '_J_sigma-', mat2str(J_sigma)), 'min_E', 'min_S', 'min_L', 'steps_to_min');
end

