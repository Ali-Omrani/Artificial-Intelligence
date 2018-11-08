function [outputAlphabet, outputFreq] = CrossOver(inputAlphabet1 , inputFreq1, inputAlphabet2, inputFreq2)
index = randi([1, 26]);

outputFreq  = inputFreq1(1:index);
outputAlphabet = inputAlphabet1(1:index);

for i= 1:26
    if find (outputAlphabet == inputAlphabet2(i))
        continue
    else
        outputAlphabet = [outputAlphabet ; inputAlphabet2(i)];
        outputFreq = [outputFreq ; inputFreq2(i)];
    end
    
end


end