function [outputAlphabet, outputFreq] = Mutation(inputAlphabet , inputFreq)
index1 = randi([1, 26]);
index2 = randi([1, 26]);

inputAlphabet([index1, index2]) = inputAlphabet([index2 , index1]);
inputFreq([index1, index2]) = inputFreq([index2 , index1]);

outputAlphabet = inputAlphabet;
outputFreq = inputFreq;



end