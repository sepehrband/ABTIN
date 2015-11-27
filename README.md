# ABTIN
Absolute Tissue density from NODDI (ABTIN) is described here:
>**Brain Tissue Compartment Density Estimated Using Diffusion-Weighted MRI Yields Tissue Parameters Consistent With Histology**
>*Farshid Sepehrband, Kristi A. Clark, Jeremy F.P. Ullmann, Nyoman D. Kurniawan, Gayeshika Leanage, David C. Reutens, and Zhengyi Yang*
>, Humman Brain Mapping, 2015. DOI: 10.1002/hbm.22872

## Implementation (in MATLAB)
**Download ABTIN's [reposiotry](https://github.com/sepehrband/ABTIN/archive/master.zip).** No additional download is required. The only dependency is MATLAB NIFTI [toolbox](http://www.mathworks.com/matlabcentral/fileexchange/8797-tools-for-nifti-and-analyze-image), which is included in the repository.

### 1. NODDI
In order to obtain ABTIN's measures, first the NODDI model should be fitted to the diffusion-weighted MR data.  To fit NODDI to your data, we suggest one of the following routines:

- **NODDI MATLAB toolbox:** follow the instruction [here](http://mig.cs.ucl.ac.uk/index.php?n=Tutorial.NODDImatlab).
- **AMICO:** follow the instruction [here](https://github.com/daducci/AMICO).

### 2. Setup the path
- **Add the path to this repostitory.** 

For example:

`addpath(genpath('~/code/matlab/ABTIN-master/'))`

### 3. Initialization 
- **Define the the path to the input folder of ABITN (folder contaning NODDI outputs)**
- **Define the the path to the output folder of ABITN**

For example:

`InputFolder='~/data/noddi/Sub-01';`

`OutputFolder = '~/data/abtin/Sub-01';`

### 4. ABTIN
`ABTIN(InputFolder,OutputFolder)`

At this stage, ABTIN's outputs are stored in the output folder.

### Script
"**Demo.m** includes the above steps."
