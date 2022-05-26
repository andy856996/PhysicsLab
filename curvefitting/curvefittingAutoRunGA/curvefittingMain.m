clear;clc;close all;
path = 'C:\Users\tating\Desktop\NEWE_DAT\';
figSavePath = 'C:\Users\tating\Desktop\NEWE_DAT\saveFig\';
folderPath_list = dir(strcat(path,'*.mat'));
formula_GE = {'GGE' 'GEG' 'EGG' 'GEE' 'EGE' 'EEG' 'GGG' 'EEE' 'EG' 'GE' 'GG' 'EE'};
for i =1:length(formula_GE)
    writematrix(['----------' formula_GE{i} '-----------'],'dat.dat', "WriteMode" , "append" )
    for j = 1:length(folderPath_list)
        psf_name = [path folderPath_list(j).name];
        martial = erase(erase(psf_name,'C:\Users\tating\Desktop\NEWE_DAT\EUV_mask_'),'_100w_Dv500_500_200_PSF.mat');
        [save_min,save_error] = fminsearchEnergyLognsseLog(psf_name,figSavePath,AutoGeneratePointSpreadFunction(formula_GE{i}),formula_GE{i});
        writematrix(martial,'dat.dat', "WriteMode" , "append" )
        writematrix([save_min save_error],'dat.dat', "WriteMode" , "append" )
    end
end





