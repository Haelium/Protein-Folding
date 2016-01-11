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
number_of_runs = 2000;

protein = generate_protein(protein_length);

% Choose a link at random and see if it can be moved
for step = 1:number_of_runs
    link_number = randi(protein_length);   % pick random monomer on chain
    direction = randi(8);   % pick direction denoted by number from 1 to 8
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
    % if chosen location not occupied, move the monomer
    if ~occupied && ~stretched
        protein(2, link_number) = x_new;
        protein(3, link_number) = y_new;
    end
    % display protein
    subplot(2,2,2);
    plot(protein(2,:), protein(3,:), '.-r', 'MarkerSize', 5);
    axis([0 30 0 30]);
    drawnow;
end
disp('Folding Complete');