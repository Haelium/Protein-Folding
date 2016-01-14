# Protein-Folding

Version 0.1 - Generates a protein (modeled as a chain of monomers) and moves randomly selected amino acids (nodes of the protein chain) at random. The links between the node that is to be moved must not be "stretched" (made greater than one), and only one monomer may occupy a single point on the lattice at any one time. If these conditions cannot be met, the monomer will not be moved.

Version 0.2 - Decision on whether to fold is no longer completely random, Van der Waals forces and Hydrogen Bonds between neighbouring monomers are now implemented as a 20x20 matrix of interaction energies. Additional graphs for total energy of protein as well as distance from first to last monomer on protein have been added.

Version 0.3 - This version runs the simulation over an array of temperature values and calculates the average energy and length of the protein for each temperature value. The average energy and length for each value T are stored in 1D arrays which can be plotted against T. Once the script has run, these arrays can be plotted against T for useful data.
