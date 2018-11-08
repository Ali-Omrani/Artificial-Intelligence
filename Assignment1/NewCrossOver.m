function [outputAlphabet1, outputFreq1, outputAlphabet2, outputFreq2] = NewCrossOver(inputAlphabet1 , inputFreq1, inputAlphabet2, inputFreq2)
index = randi([1, 26]);

outputFreq1  = inputFreq1(1:index);
outputAlphabet1 = inputAlphabet1(1:index);
outputFreq2 = inputFreq2(1:index);
outputAlphabet2 = inputAlphabet2(1:index);


for i= 1:26
    if find (outputAlphabet1 == inputAlphabet2(i))
        continue
    else
        outputAlphabet1 = [outputAlphabet1 ; inputAlphabet2(i)];
        outputFreq1 = [outputFreq1 ; inputFreq2(i)];
    end
    
end
for i= 1:26
    if find (outputAlphabet2 == inputAlphabet1(i))
        continue
    else
        outputAlphabet2 = [outputAlphabet2 ; inputAlphabet1(i)];
        outputFreq2 = [outputFreq2 ; inputFreq1(i)];
    end
    
end

end