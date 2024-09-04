clear all; close all; clc;
%
%% --- Setup --------------------------------------------------------------
% 
    Config.Test_Name = 'PhD_LAB_Damaged';
    Config.Test_Date = 05052022; 
    % 
    % --- Input channels
    NI_DAQ = daq('ni');
    CH_01 = addinput(NI_DAQ,'Dev1','ai1','Accelerometer');
    CH_02 = addinput(NI_DAQ,'Dev1','ai2','Accelerometer');
    CH_03 = addinput(NI_DAQ,'Dev1','ai3','Accelerometer');
    NI_DAQ.Rate = 51200;
    %
    % --- Transducer sensitivity (check in "the excel file")
    CH_01.Sensitivity = 9.59969; % PCB393B12 #16906 
    CH_02.Sensitivity = 9.52562; % PCB393B12 #16910
    CH_03.Sensitivity = 9.69932; % PCB393B12 #32170
    % 
    % --- Records
    Config.Number_of_records = 42;
    Config.Recording_Time    = 600;  
    Config.Setting_Pause     = 60;
%
%% --- Record -------------------------------------------------------------
%
    Config.Filter_Order = 5;
    Data_100 = zeros(Config.Number_of_records,100*Config.Recording_Time,numel(NI_DAQ.Channels));
    Data_RAW = zeros(Config.Number_of_records,NI_DAQ.Rate*Config.Recording_Time,numel(NI_DAQ.Channels));
    disp('Waiting for starting time...');
    pause(Config.Setting_Pause);
    disp('Recording started...');
    for k = 1:Config.Number_of_records
        disp(' ');
        disp(['Recording measurement Nº',num2str(k),', please wait...']);
        Data_RAW(k,:,:) = read(NI_DAQ,seconds(Config.Recording_Time),"OutputFormat","Matrix"); 
        for j = 1:numel(NI_DAQ.Channels)
            Data_25600_TEMP = decimate(Data_RAW(k,:,j),2,Config.Filter_Order); 
            Data_12800_TEMP = decimate(Data_25600_TEMP,2,Config.Filter_Order); 
            Data_6400_TEMP  = decimate(Data_12800_TEMP,2,Config.Filter_Order); 
            Data_3200_TEMP  = decimate(Data_6400_TEMP ,2,Config.Filter_Order); 
            Data_1600_TEMP  = decimate(Data_3200_TEMP ,2,Config.Filter_Order); 
            Data_800_TEMP   = decimate(Data_1600_TEMP ,2,Config.Filter_Order); 
            Data_400_TEMP   = decimate(Data_800_TEMP  ,2,Config.Filter_Order); 
            Data_200(k,:,j) = decimate(Data_400_TEMP  ,2,Config.Filter_Order); 
            Data_100(k,:,j) = decimate(Data_200(k,:,j),2,Config.Filter_Order); % DEFAULT OUTPUT [Fs = 100 Hz]
        end
        if k < 10 
            writematrix(squeeze(Data_100(k,:,:)),[Config.Test_Name,'_',...
                num2str(Config.Test_Date),'_M0',num2str(k),'_100Hz.dat']); 
        else
            writematrix(squeeze(Data_100(k,:,:)),[Config.Test_Name,'_',...
                num2str(Config.Test_Date),'_M',num2str(k),'_100Hz.dat']); 
        end
        disp(['Measurement Nº',num2str(k),', completed.']);
    end
    disp(' ');
    disp(['All data adquisitions completed.']);
    clear k j CH_NUM Filter_Order Data_25600_TEMP Data_12800_TEMP Data_6400_TEMP...
        Data_3200_TEMP Data_1600_TEMP Data_800_TEMP Data_400_TEMP Data_200_TEMP
%
