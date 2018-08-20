# Modded Photon Propagation Code for Gradient Descent Ice Model Optimization
This repository manages the modified Photon Propagation Code as needed for gradient descent optimization of ice model parameters. PPC was originally written by Dima Chirkrin. There are two modified versions in this repository. 

The ./no_abs directory contains the main version which is used to propagate photons without absorption while logging the traveled distance of each photon in each layer. This information enables us to later calculate the absorption probability without control statements and derive gradients on the absorption coefficients.

The ./real directory contains a version of PPC with unmodified propagation code. Only the program output has been modified so it has the format expected by the Python PPC Wrapper used for verifying the optimization method on simulation data. It is only needed for verification, not for fitting to real data.
