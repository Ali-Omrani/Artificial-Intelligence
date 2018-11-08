function [result] = FitnessFunction(fileName, inputAlphabet, inputFreq, alphabetFreq)
%% single char freq
result = 0;
% temp = inputFreq - alphabetFreq;
% result = -1 * sum(abs(temp));
%% multi char 
    T = double('T')-double('A') +1;
    H = double('H')-double('A') +1;
    strcat(inputAlphabet(T), inputAlphabet(H))
    result = result + 2 * ExpressionOccurance(fileName, strcat(inputAlphabet(T), inputAlphabet(H)));
    E =  double('E')-double('A') +1;
    strcat(inputAlphabet(H), inputAlphabet(E))
    result = result + ExpressionOccurance(fileName, strcat(inputAlphabet(H), inputAlphabet(E)))
    
    I = double('I')-double('A') +1;
    N = double('N')-double('A') +1;
    strcat(inputAlphabet(I), inputAlphabet(N))
    result = result + ExpressionOccurance(fileName, strcat(inputAlphabet(I), inputAlphabet(N)))
    
    R = double('R')-double('A') +1;
    strcat(inputAlphabet(E), inputAlphabet(R))
    result = result + ExpressionOccurance(fileName, strcat(inputAlphabet(E), inputAlphabet(R)))
    
    A = double('A')-double('A') +1;
    strcat(inputAlphabet(A), inputAlphabet(N))
    result = result + ExpressionOccurance(fileName, strcat(inputAlphabet(A), inputAlphabet(N)))
    
    D = double('D')-double('A') +1;
    strcat(inputAlphabet(E), inputAlphabet(D))
    result = result + ExpressionOccurance(fileName, strcat(inputAlphabet(E), inputAlphabet(D)))
    strcat(inputAlphabet(T), inputAlphabet(H), inputAlphabet(E))
    result = result + 5 * ExpressionOccurance(fileName, strcat(inputAlphabet(T), inputAlphabet(H), inputAlphabet(E)))
    G = double('G')-double('A') +1;
    strcat(inputAlphabet(I), inputAlphabet(N), inputAlphabet(G))
    result = result + 5 * ExpressionOccurance(fileName, strcat(inputAlphabet(I), inputAlphabet(N), inputAlphabet(G)))
    strcat(inputAlphabet(A), inputAlphabet(N), inputAlphabet(D))
    result = result + 5 * ExpressionOccurance(fileName, strcat(inputAlphabet(A), inputAlphabet(N), inputAlphabet(D)))
    strcat(inputAlphabet(E), inputAlphabet(E), inputAlphabet(E))
    result = result - 5 * ExpressionOccurance(fileName, strcat(inputAlphabet(E), inputAlphabet(E), inputAlphabet(E)))
    


end