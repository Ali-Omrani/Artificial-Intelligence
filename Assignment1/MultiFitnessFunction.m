function [totalResult] = MultiFitnessFunction(fileName, population, alphabetFreq)
totalResult = zeros(length(population), 1);
for i = 1:length(population)
    inputAlphabet = population{1,i};
    inputFreq = population{2,i};
    %% single char freq
    result = 0;
%     temp = inputFreq - alphabetFreq;
%     result = -1 * sum(abs(temp));
    %% multi char 
    T = double('T')-double('A') +1;
    H = double('H')-double('A') +1;
    E =  double('E')-double('A') +1;
    I = double('I')-double('A') +1;
    N = double('N')-double('A') +1;
    R = double('R')-double('A') +1;
    A = double('A')-double('A') +1;
    D = double('D')-double('A') +1;
    G = double('G')-double('A') +1;
    fileId = fopen(fileName);
    formatSpec = '%c';
    content = fscanf(fileId, formatSpec);
    %th
    expression = strcat(inputAlphabet(T), inputAlphabet(H));
    result = result + 2 * length(strfind(content , expression));
    %he
    expression = strcat(inputAlphabet(H), inputAlphabet(E));
    result = result + length(strfind(content , expression));
    %in
    expression = strcat(inputAlphabet(I), inputAlphabet(N));
    result = result + length(strfind(content , expression));
    %er
    expression = strcat(inputAlphabet(E), inputAlphabet(R));
    result = result + length(strfind(content , expression));
    %an
    expression = strcat(inputAlphabet(A), inputAlphabet(N));
    result = result + length(strfind(content , expression));
    %ed
    expression = strcat(inputAlphabet(E), inputAlphabet(D));
    result = result + length(strfind(content , expression));
    %the
    expression = strcat(inputAlphabet(T), inputAlphabet(H), inputAlphabet(E));
    result = result + 5 * length(strfind(content , expression));
    %ing
    expression = strcat(inputAlphabet(I), inputAlphabet(N), inputAlphabet(G));
    result = result + 5 * length(strfind(content , expression));
    %and
    expression = strcat(inputAlphabet(A), inputAlphabet(N), inputAlphabet(D));
    result = result + 5 * length(strfind(content , expression));
    %eee
    expression = strcat(inputAlphabet(E), inputAlphabet(E), inputAlphabet(E));
    result = result - 5 * length(strfind(content , expression));
    fclose(fileId);
    totalResult(i) = result;

end
% totalResult = totalResult + abs(min(totalResult)) + randi([1,30]);
end