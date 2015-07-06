% Demo script to obtain tissue density using ABTIN model

% Sepehrband, F., Clark, K. A., Ullmann, J. F.P., Kurniawan, 
% N. D., Leanage, G., Reutens, D. C. and Yang, Z. (2015), 
% Brain tissue compartment density estimated using diffusion-weighted 
% MRI yields tissue parameters consistent with histology. 
% Hum. Brain Mapp.. doi: 10.1002/hbm.22872
% Link: http://onlinelibrary.wiley.com/doi/10.1002/hbm.22872/abstract

% Farshid Sepehrband - fsepehrband@gamil.com
% January 2015

%% Add path of matlab_nifti toolbox
addpath(genpath('~/path_to_folder/NIfTI_20140122'))

%% Add path to the folder containing ABTIN.m
addpath('~/path_to_folder_containing_ABTIN.m')

%% Run ABTIN
InputFolder  = '~/path_to_folder_containing_noddi_outputs';
Mask         = '~/path_to_mask.nii'; % e.g. Mask = '~/home/noddi/mask.nii';
OutputFolder = '~/path_to_folder_containing_abtin_outputs';

ABTIN(InputFolder,Mask,OutputFolder)