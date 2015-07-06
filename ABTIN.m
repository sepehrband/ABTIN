% ABsolute TIssue density from NODDI (ABTIN)

% Sepehrband, F., Clark, K. A., Ullmann, J. F.P., Kurniawan, 
% N. D., Leanage, G., Reutens, D. C. and Yang, Z. (2015), 
% Brain tissue compartment density estimated using diffusion-weighted 
% MRI yields tissue parameters consistent with histology. 
% Hum. Brain Mapp.. doi: 10.1002/hbm.22872
% Link: http://onlinelibrary.wiley.com/doi/10.1002/hbm.22872/abstract

% Farshid Sepehrband - fsepehrband@gmail.com
% January 2015

function ABTIN(InputFolder,Mask,OutputFolder)
% InputFolder: path to the folder where *fiso.nii and *ficvf.nii are stored
% Mask: path to the mask, e.g. Mask='~/data/noddi/mask_brain.nii'
% OutputFolder: path to the desired output folder

%% Read stuff

% Read ficvf
InFile = dir([InputFolder '/*ficvf.nii']);
fic = load_untouch_nii([InputFolder '/' InFile.name]); 
Fic = fic.img;

% Read fiso
InFile = dir([InputFolder '/*fiso.nii']);
fiso = load_untouch_nii([InputFolder '/' InFile.name]);
Fiso = fiso.img;

% Read Mask
MASK = load_untouch_nii(Mask);
mask = reshape(logical(MASK.img),[],1);

%% ABTIN

startTime = cputime;

% Parameter initialization
alpha   = 25;   % see "Theory Section" of the above paper for more detail 
g_ratio = 0.7;  % can be between 0.6 to 0.8
beta    = 1/((1/g_ratio^2)-1); 

% intra-neurite and extra-neurite from ficvf and fiso
Fin  = reshape(( (1-Fiso).*Fic ),[],1) ;
Fen  = reshape(( (1-Fiso).*(1-Fic) ),[],1) ;
Fcsf = reshape(( 1-(Fin+Fen) ),[],1) ;

% initialization
Vn   = zeros(size(Fin));
Vm   = zeros(size(Fin));
Vc   = zeros(size(Fin));
Vbc  = zeros(size(Fin));
Vcsf = zeros(size(Fin));

% Fit ABTIN model to the data
for i = 1:length(Fin)
    if mask(i) == 1
        A = [beta+Fin(i) Fin(i) 0
            Fen(i) alpha+Fen(i) 0
            Fcsf(i) Fcsf(i) 1];
        b = [Fin(i); Fen(i); Fcsf(i)];
        V     = A\b;
        Vm(i)    = V(1);
        Vbc(i)   = V(2);
        Vcsf(i)  = V(3);
        Vn(i) = beta.*Vm(i);
        Vc(i) = alpha.*Vbc(i);
    end
end

% Prepare outputs
Vm   = reshape(Vm,size(Fiso,1),size(Fiso,2),size(Fiso,3));
Vn   = reshape(Vn,size(Fiso,1),size(Fiso,2),size(Fiso,3));
Vcel = reshape(Vc+Vbc,size(Fiso,1),size(Fiso,2),size(Fiso,3));
Vcsf = reshape(Vcsf,size(Fiso,1),size(Fiso,2),size(Fiso,3));

processTime = cputime - startTime;
sprintf(['CPU time to process ' InFile.name(1:end-9) ' = %5.5f second'], processTime)

%% Write Stuff

% Output Myelin Density
MyelinDenisty = fic; 
MyelinDenisty.img = Vm;
save_untouch_nii(MyelinDenisty,[OutputFolder '/' InFile.name(1:end-9) '_MylDen.nii']);

% Output Neurite Density
MyelinDenisty = fic;        % to copy the header information
MyelinDenisty.img = Vn;
save_untouch_nii(MyelinDenisty,[OutputFolder '/' InFile.name(1:end-9) '_NeuDen.nii']);

% Output Fibre Density (Myelin + Neurite)
FibreDenisty = fic;         % to copy the header information
FibreDenisty.img = Vn+Vm;
save_untouch_nii(FibreDenisty,[OutputFolder '/' InFile.name(1:end-9) '_FibDen.nii']);

% Output Cell density
CellularDenisty = fic;      % to copy the header information
CellularDenisty.img = Vcel;
save_untouch_nii(CellularDenisty,[OutputFolder '/' InFile.name(1:end-9) '_CelDen.nii']);

% Output CSF density
CSFDenisty = fic;           % to copy the header information
CSFDenisty.img = Vcsf;
save_untouch_nii(CSFDenisty,[OutputFolder '/' InFile.name(1:end-9) '_CSFDen.nii']);

end