clc;clear all;
load('.\EUV_mask_Cr_100w_Dv500_500_200_PSF');
numTimeStepsTrain = floor(0.9*numel(x_w_norm_tzo));
%% X Y data
dataTrain_X = x_w_norm_tzo(1:numTimeStepsTrain+1)';
dataTest_X = x_w_norm_tzo(numTimeStepsTrain+1:end)';
dataTrain_Y = y_w_norm_tzo(1:numTimeStepsTrain+1)';
dataTest_Y = y_w_norm_tzo(numTimeStepsTrain+1:end)';
%% Norm. Data
max_X = max(x_w_norm_tzo);
dataTrainStandardized_X = dataTrain_X / max_X;

max_Y = max(y_w_norm_tzo);
dataTrainStandardized_Y = dataTrain_Y / max_Y;

XTrain = dataTrainStandardized_X(1:numTimeStepsTrain);
YTrain = dataTrainStandardized_Y(1:numTimeStepsTrain);
%% create layers and train Neural Network
layers = [ ...
    sequenceInputLayer(1)
    fullyConnectedLayer(20)
    fullyConnectedLayer(20)
    fullyConnectedLayer(50)
    fullyConnectedLayer(50)
    fullyConnectedLayer(1)
    regressionLayer
    ]
options = trainingOptions('adam', ...
    'MaxEpochs',28000, ...%     
    'GradientThreshold',0.5, ...
    'InitialLearnRate',1, ...
    'LearnRateSchedule','none', ...
    'ExecutionEnvironment','gpu', ...
    'LearnRateDropPeriod',100, ...
    'LearnRateDropFactor',0.2, ...%'MiniBatchSize',10,...
    'Verbose',0, ...
    'Plots','training-progress');
net = trainNetwork(XTrain,YTrain,layers,options);
%% generate X Y Test data
XTest = dataTest_X / max_X;
YTest = dataTest_Y / max_Y;
%% pridiction
YPred = predict(net,XTest);
sum = 0;
for i = 1:length(YPred)
    sum = sum + abs(YPred(i) - YTest(i));
end

figure;semilogy([dataTrainStandardized_X XTest],[dataTrainStandardized_Y YTest]);
title('Origin DATA');xlabel('radius(nm)');ylabel('Norm. energy');
hold on;semilogy(XTest,YPred);

x_prid = (0.0001:0.00001:1);
Y_Pred = predict(net,x_prid);
hold on;semilogy(x_prid,Y_Pred);
title('After Neural Network DATA');xlabel('radius(nm)');ylabel('Norm. energy');










