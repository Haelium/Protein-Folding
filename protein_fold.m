%%
%   Protein folding program created using MATLAB
%   Based on Chapter 12 Computational Physics, N Giordano and  H Nakanishi,
%   Pearson, 2006 and
%   E Shaknovich, G Farztdinov, A Gutin and M Karplus, ""Protein folding bottlenecks:
%   A Lattice Monte Carlo Simulation", Phys. Rev. Lett., 67, 1665, (1991).

clear;
close;

% Initialisation block
protein_length = 15;
number_of_runs = 100000;
monomer_number = 20; % There are 20 monomers occuring in nature
T = 10;    % temperature in kelvin
high_interaction = -4;
low_interaction = -2;
E_current = 0;
E_average = 0;
E_sum = 0;
% J is a 20x20 matrix of randomly assigned energy values to represent the
% interaction energies betweeen monomers
J = randi([high_interaction, low_interaction], monomer_number, monomer_number);

protein = generate_protein(protein_length, monomer_number);

% Choose a link at random and see if it can be moved
for step = 1:number_of_runs
    link_number = randi(protein_length);   % pick random monomer on chain
    direction = ceil(rand()*8);   % pick direction denoted by number from 1 to 8
        switch direction
        case 1          % RIGHT and UP
            x_new = protein(2, link_number)+1;
            y_new = protein(3, link_number)+1;
        case 2          % RIGHT and STATIC
            x_new = protein(2, link_number)+1;
            y_new = protein(3, link_number);
        case 3          % RIGHT and DOWN
            x_new = protein(2, link_number)+1;
            y_new = protein(3, link_number)-1;
        case 4          % STATIC and DOWN
            x_new = protein(2, link_number);
            y_new = protein(3, link_number)-1;
        case 5          % LEFT and DOWN
            x_new = protein(2, link_number)-1;
            y_new = protein(3, link_number)-1;
        case 6          % LEFT and STATIC
            x_new = protein(2, link_number)-1;
            y_new = protein(3, link_number);
        case 7          % LEFT and UP
            x_new = protein(2, link_number)-1;
            y_new = protein(3, link_number)+1;
            otherwise	% STATIC and UP
            x_new = protein(2, link_number);
            y_new = protein(3, link_number)+1;
        end
    % check if chosen location is occupied
    occupied = site_occupied(x_new, y_new, protein);
    % check if chosen location causes "stretch"
    stretched = check_stretch(protein, protein_length, link_number, x_new, y_new);
    % if chosen location not occupied, create copy of protein with new
    % shape
    if ~occupied && ~stretched
        copy_protein = protein;
        copy_protein(2, link_number) = x_new;
        copy_protein(3, link_number) = y_new;
        % Compare energy value of new protein shape with the old shape
        E_after_move = protein_energy(copy_protein, J, protein_length);
        E_current = protein_energy(protein, J, protein_length);
        delta_E = E_current - E_after_move;
    
        if delta_E <= 0  % If energy decreases, always move
            protein = copy_protein;
            E_current = E_after_move;
        else    % If delta_E is positive, the change will cost energy, is only 
                % made if the following statistical condition is met
            boltzmann_factor = exp(-delta_E / T);
            if boltzmann_factor > rand
                protein = copy_protein;
                E_current = E_after_move;
            end
        end
    end
    
    % display protein lattice
    subplot(2,2,2);
    plot(protein(2,:), protein(3,:), '.-r', 'MarkerSize', 5);
    axis([0 30 0 30]);
    legend('Protein Lattice');
    drawnow;
    
    % display energy of protein at each step
    subplot(2,2,1);
    plot(step, E_current, '-*r', 'MarkerSize', 2);
    axis([0 step -30 5]);
    xlabel('Monte Carlo steps');
    ylabel('Energy');
    legend ('Energy vs time');         
    hold on;
    drawnow;
    
    % calculate and display average energy of protein
    E_sum = E_sum + E_current;
    E_average = E_average / step;
    subplot(2,2,3);
    plot(step, E_average, '*g', 'MarkerSize', 2);
    axis([0 step -0.25 0])
    xlabel('Monte Carlo steps');
    ylabel('Energy');
    legend ('Average Energy over time');
    hold on;
    drawnow;
    
    % display "end to end" length of protein
    subplot(2,2,4);
    plot(step, length_end_to_end(protein, protein_length), '-*b', 'MarkerSize', 2);
    axis([0 step 0 15]);
    xlabel('Monte Carlo steps');
    ylabel('Length');
    legend ('End to end length');
    hold on;
    drawnow;
end
disp('Folding Complete');
