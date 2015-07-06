# ABTIN
Absolute Tissue density from NODDI (ABTIN) is described here:
>**Brain Tissue Compartment Density EstimatedUsing Diffusion-Weighted MRI Yields TissueParameters Consistent With Histology**
>*Farshid Sepehrband, Kristi A. Clark, Jeremy F.P. Ullmann, Nyoman D. Kurniawan, Gayeshika Leanage, David C. Reutens, and Zhengyi Yang*
>, Humman Brain Mapping, 2015. DOI: 10.1002/hbm.22872

## Implementation
Download ABTIN's [reposiotry](https://github.com/sepehrband/ABTIN/archive/master.zip). 

### NODDI
In order to obtain ABTIN's measures, first the NODDI model should be fitted to the diffusion-weighted MR data.  

**NODDI MATLAB toolbox:** follow the instruction [here](http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab).

### Setup the paths in MATLAB
- ABTIN and NIFTI toolbox
`addpath(genpath('~/path_to_folder_containing_ABTIN.m'))`

### Initialization 
`InputFolder  = '~/path_to_folder_containing_noddi_outputs';` for example: `InputFolder='~/data/noddi/Sub-01';`
`Mask         = '~/path_to_mask.nii';`                        for example: `Mask = '~/data/noddi/Sub-01/mask.nii';`
`OutputFolder = '~/path_to_folder_containing_abtin_outputs';` for example: `OutputFolder = '~/data/abtin/Sub-01';`

### ABTIN
`ABTIN(InputFolder,Mask,OutputFolder)`

"**Demo.m includes above steps**"
