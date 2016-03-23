function [] = par_fold_fixed( cores, length, T, steps)
    parfor i = 1:cores
        fun_T_spec(length, T, steps)
    end
end

