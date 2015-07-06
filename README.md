# ABTIN
Absolute Tissue density from NODDI (ABTIN) is described here:
>**Brain Tissue Compartment Density EstimatedUsing Diffusion-Weighted MRI Yields TissueParameters Consistent With Histology**
>*Farshid Sepehrband, Kristi A. Clark, Jeremy F.P. Ullmann, Nyoman D. Kurniawan, Gayeshika Leanage, David C. Reutens, and Zhengyi Yang*
>, Humman Brain Mapping, 2015. DOI: 10.1002/hbm.22872

## Implementation
Download ABTIN's reposiotry. 

### External softwares
In order to obtain ABTIN's measures, first the NODDI model should be fitted to the diffusion-weighted MR data.  

**NODDI MATLAB toolbox**: follow the instruction [here](http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab).

**MATLAB NIFTI toolbox**: [This](http://de.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image) toolbox is included in this repository. 

### setup paths in MATLAB
- ABTIN and NIFTI toolbox
`addpath(genpath('~/path_to_folder_containing_ABTIN.m'))`

### Initialization 
`InputFolder  = '~/path_to_folder_containing_noddi_outputs';`
`Mask         = '~/path_to_mask.nii'; % e.g. Mask = '~/home/noddi/mask.nii';`
`OutputFolder = '~/path_to_folder_containing_abtin_outputs';`

### ABTIN
`ABTIN(InputFolder,Mask,OutputFolder)`

"**Demo.m includes above steps**"
