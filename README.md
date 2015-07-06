# ABTIN
Absolute Tissue density from NODDI (ABTIN) is described here:
>**Brain Tissue Compartment Density EstimatedUsing Diffusion-Weighted MRI Yields TissueParameters Consistent With Histology**
>*Farshid Sepehrband, Kristi A. Clark, Jeremy F.P. Ullmann, Nyoman D. Kurniawan, Gayeshika Leanage, David C. Reutens, and Zhengyi Yang*
>, Humman Brain Mapping, 2015. DOI: 10.1002/hbm.22872

## Implementation
Download ABTIN's [reposiotry](https://github.com/sepehrband/ABTIN/archive/master.zip). 

### NODDI
In order to obtain ABTIN's measures, first the NODDI model should be fitted to the diffusion-weighted MR data.  To fit NODDI to your data, we suggest one of the following routines:

- **NODDI MATLAB toolbox:** follow the instruction [here](http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab).
- **AMICO:** follow the instruction [here](https://github.com/daducci/AMICO).

### Setup the paths in MATLAB
- **Add the path to this repostitory.**
**e.g.**
`addpath(genpath('~/code/matlab/ABTIN/'))`

### Initialization 
- **Define the the path to the input folder of ABITN (folder contaning NODDI outputs)**
- **Define the the path the mask**
- **Define the the path to the output folder of ABITN**
**e.g.**
`InputFolder='~/data/noddi/Sub-01';`

`Mask = '~/data/noddi/Sub-01/mask.nii';`

`OutputFolder = '~/data/abtin/Sub-01';`

### ABTIN
`ABTIN(InputFolder,Mask,OutputFolder)`

## Script
"**Demo.m** includes the above steps."
