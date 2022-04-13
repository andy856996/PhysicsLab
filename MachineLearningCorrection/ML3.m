clc;clear all;
load('.\sever2\2_error');
shift_array = [];
Eer_array = [];
Ier_array = [];
[p,q]=size(shift);
for i=1:p
    [a,b]=size(shift(i,1).info);
    for j=1:a
        [d,c]=size(shift(i,1).info(j,1).value);
        for k=1:d
            for ii=1:q
                if ii == 1
                    Total_shift(i,1).info(j,1).value(k,1) = 0;
                end
                Total_shift(i,1).info(j,1).value(k,1)=shift(i,ii).info(j,1).value(k,1) + Total_shift(i,1).info(j,1).value(k,1);
            end
            shift_array = [shift_array Total_shift(i,1).info(j,1).value(k,1)];
            Eer_array   = [Eer_array Eer(i,1).info(j,1).value(k,1)];
            Ier_array   = [Ier_array Ier(i,1).info(j,1).value(k,1)];
        end
    end
end
% [EerUniqueArr,ia,ic]  = unique(Eer_array);
% figure;plot(EerUniqueArr,Ier_array(ia))
% xlabel('EPE')
% ylabel('IE')
% title('EPE vs. IE')
% set(gca,'fontsize',20)
% 
% 
% [EerUniqueArr,ia,ic]  = unique(Eer_array);
% figure;plot(EerUniqueArr,shift_array(ia))
% xlabel('EPE')
% ylabel('shift')
% title('EPE vs. shift')
% set(gca,'fontsize',20)
% 
% 
% [IerUniqueArr,ia,ic]  = unique(Ier_array);
% figure;plot(IerUniqueArr,shift_array(ia))
% xlabel('IE')
% ylabel('shift')
% title('IE vs. shift')
% set(gca,'fontsize',20)










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










