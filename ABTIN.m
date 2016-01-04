% ABsolute TIssue density from NODDI (ABTIN)

% Sepehrband, F., Clark, K. A., Ullmann, J. F.P., Kurniawan,
% N. D., Leanage, G., Reutens, D. C. and Yang, Z. (2015),
% Brain tissue compartment density estimated using diffusion-weighted
% MRI yields tissue parameters consistent with histology.
% Hum. Brain Mapp.. doi: 10.1002/hbm.22872
% Link: http://onlinelibrary.wiley.com/doi/10.1002/hbm.22872/abstract

% Farshid Sepehrband - fsepehrband@gmail.com
% January 2015

function ABTIN(InputFolder,OutputFolder)
% InputFolder: path to the folder where *fiso.nii and *ficvf.nii are stored
% There should be nifti files, finishing with *fiso.nii and *ficvf.nii in
% the input folder

% OutputFolder: path to the desired output folder


%% Read stuff

Files = dir([InputFolder '/*_ficvf*']);
if isempty(Files)
    error('no ficvf.nii was found')
end

for i = 1:length(Files)
    nameInd = strfind(Files(i).name,'_ficvf.nii');
    Name = Files(i).name(1:nameInd-1);
    
    sprintf(['Processing ....' Name])
    % Read ficvf
    fic = load_untouch_nii([InputFolder '/' Name '_ficvf.nii']);
    Fic = fic.img;
    
    % Read fiso
    fiso = load_untouch_nii([InputFolder '/' Name '_fiso.nii']);
    Fiso = fiso.img;
    
    % Read Mask
    mask = logical(Fic);
    
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
    sprintf(['CPU time to process ' Name ' = %5.5f seconds'], processTime)
    
    %% Write Stuff
    
    % Output Fibre Density (Myelin + Neurite)
    FibreDenisty = fic;         % to copy the header information
    FibreDenisty.img = Vn+Vm;
    save_untouch_nii(FibreDenisty,[OutputFolder '/' Name '_FibDen.nii']);
    
    % Output Cell density
    CellularDenisty = fic;      % to copy the header information
    CellularDenisty.img = Vcel;
    save_untouch_nii(CellularDenisty,[OutputFolder '/' Name '_CelDen.nii']);
    
    % Output CSF density
    CSFDenisty = fic;           % to copy the header information
    CSFDenisty.img = Vcsf;
    save_untouch_nii(CSFDenisty,[OutputFolder '/' Name '_CSFDen.nii']);
    
    % Output Myelin Density
    MyelinDenisty = fic;
    MyelinDenisty.img = Vm;
    save_untouch_nii(MyelinDenisty,[OutputFolder '/' Name '_MylDen.nii']);
    %
    % % Output Neurite Density
    % MyelinDenisty = fic;        % to copy the header information
    % MyelinDenisty.img = Vn;
    % save_untouch_nii(MyelinDenisty,[OutputFolder '/' Name '_NeuDen.nii']);
end
end
