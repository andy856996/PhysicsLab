%% Automatically Generate Point Spread Function
clc;clear all;
%% inital data
GauExpArr = 'EE'; %Ex GEE or GGG
ParameterArrayName = 'x';
ParameterName = 'X';
%% CODE & output
%-------------ETA---------------%
ETAoutPutStr1 = '(1/(pi*(1';
ETAoutPutStr2 = ')))*';
etaFinalOutPut = '';
etaLength = length(GauExpArr)-1;
k=1;
for i = (length(GauExpArr)+1):(length(GauExpArr)+etaLength)
    outPutStr3(k) = string(['+' ParameterArrayName '(' num2str(i)  ')']);
    k = k + 1;
end
etaFinalOutPut = [etaFinalOutPut ETAoutPutStr1];
for i=1:length(outPutStr3)
    etaFinalOutPut = [etaFinalOutPut char(outPutStr3(i))];
end
etaFinalOutPut = [etaFinalOutPut ETAoutPutStr2];
%-------------alpha Beta...---------------%
ABFinalOutPut = [etaFinalOutPut '('];
for i=1:length(GauExpArr)
    if GauExpArr(i) == 'G'
        if i==1
            ABFinalOutPut = [ABFinalOutPut '(1/(' ParameterArrayName '(' num2str(i) ')^2))*exp(-(' ...
                ParameterName '/' ParameterArrayName '(' num2str(i) ')).^2)'];
        else
            ABFinalOutPut = [ABFinalOutPut '+(' ParameterArrayName '(' num2str(i+length(GauExpArr)-1) ')/(' ...
                ParameterArrayName '(' num2str(i) ')^2))*exp(-(' ParameterName '/' ParameterArrayName '(' num2str(i) ')).^2)' ];
        end
    elseif GauExpArr(i) == 'E'
        if i==1
            ABFinalOutPut = [ABFinalOutPut '(1/(2*(' ParameterArrayName '(' num2str(i) ')^2)))*exp(-(' ...
                ParameterName '/' ParameterArrayName '(' num2str(i) ')))'];
        else
            ABFinalOutPut = [ABFinalOutPut '+(' ParameterArrayName '(' num2str(i+length(GauExpArr)-1) ')/(2*(' ...
                ParameterArrayName '(' num2str(i) ')^2)))*exp(-(' ParameterName '/' ParameterArrayName '(' num2str(i) ')))' ];
        end
    else
        error('error : input error -> can not find G or E ');
    end
end
ABFinalOutPut = [ABFinalOutPut ');'];
disp(ABFinalOutPut);