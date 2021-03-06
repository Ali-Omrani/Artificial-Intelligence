clear
clc

%% init
fileName = 'EncryptedText';
alphabet = 'A' : 'Z';
alphabet = alphabet';
occuranceFreq = CharacterOccurance(fileName);
res{1} = alphabet;
res{2} = occuranceFreq;
alphabetFreq = AlphabetFrequency('Freq.txt');

%% generate first population
tempSize = 1000;
firstPopulationSize = 100;
tempP = cell(2, tempSize);
for i = 1:tempSize
    permutation = randperm(26);
    newAlphabet = alphabet(permutation);
    newFreq = occuranceFreq(permutation);
    tempP{1, i} = newAlphabet;
    tempP{2, i} = newFreq;
    i
end
index = 1:tempSize;
index = index';
fitness = MultiFitnessFunction(fileName, tempP, alphabetFreq);
fitness = [index ,fitness];
fitness = sortrows(fitness,2)
P = cell(2, firstPopulationSize);
for i= 1:firstPopulationSize
    i
    tempAlphabet = tempP{1,fitness(tempSize-i+1,1)};
    tempFreq = tempP{2,fitness(tempSize-i+1,1)};
     
     sortedFreq = sort(tempFreq, 'descend');
     idx1 = find(tempFreq == sortedFreq(1));
     tempFreq([idx1 5]) = tempFreq([5 idx1]);
     tempAlphabet([idx1 5]) = tempAlphabet([5 idx1]);
     sortedFreq = sort(tempFreq, 'descend');
     idx2 = find(tempFreq == sortedFreq(2));
     tempFreq([idx2 20]) = tempFreq([20 idx2]);
     tempAlphabet([idx2 20]) = tempAlphabet([20 idx2]);
     sortedFreq = sort(tempFreq, 'descend');
     idx3 = find(tempFreq == sortedFreq(3));
     tempFreq([idx3 1]) = tempFreq([1 idx3]);
     tempAlphabet([idx3 1]) = tempAlphabet([1 idx3]);
     
     idxI = find(tempFreq == sortedFreq(5));
     tempFreq([idxI 9]) = tempFreq([9 idxI]);
     tempAlphabet([idxI 9]) = tempAlphabet([9 idxI]);
     
     idxn = find(tempFreq == sortedFreq(6));
     tempFreq([idxI 14]) = tempFreq([14 idxI]);
     tempAlphabet([idxI 14]) = tempAlphabet([14 idxI]);
     
     tempAlphabet
     P{1,i} = tempAlphabet;
    P{2,i} = tempFreq;
end


MultiFitnessFunction(fileName, P, alphabetFreq)


% celldisp(P)
%%
gPercentage = 0.2;
mutationProbability = 0.15;
crossOverProbability = 0.8;
iteration = 200;
maxFit = 0;
resultAlphabet = 'A' : 'Z';
for i = 1:iteration
    i 
    newPopulation = cell(2, firstPopulationSize);
    
    fitness = MultiFitnessFunction(fileName , P, alphabetFreq);
    index = 1:firstPopulationSize;
    index = index';
    
    indexfitness = [index ,fitness];
    indexfitness = sortrows(indexfitness,2);
    for j = 1:firstPopulationSize*gPercentage
        idx = indexfitness(firstPopulationSize - j +1,1)
        newAlphabet = P{1, idx};
        newFreq = P{2, idx};
        newPopulation{1,j} = newAlphabet;
        newPopulation{2,j} = newFreq;
    end

    max(fitness)
    if (maxFit < max(fitness))
        [maxfit, idx] = max(fitness);
        resultAlphabet =  P{1, idx};
    end
%     maxFit = max(maxFit ,max(fitness))
    
    for j= (firstPopulationSize*gPercentage + 2)/2 : firstPopulationSize/2
        index1 = RandomSelect(fitness, P, alphabetFreq);
        index2 = RandomSelect(fitness, P, alphabetFreq);
        if rand <= crossOverProbability
            [newAlphabet1, newFreq1, newAlphabet2, newFreq2] = NewCrossOver(P{:,index1}, P{:,index2});
        else
            newAlphabet1 = P{1,index1};
            newFreq1 = P{2,index1};
            newAlphabet2 = P{1,index2};
            newFreq2 = P{2,index2};
        end
        
        if rand <= mutationProbability
            [newAlphabet1, newFreq1] = mutation(newAlphabet1, newFreq1);
        end
        
        if rand <= mutationProbability
            [newAlphabet2, newFreq2] = mutation(newAlphabet2, newFreq2);
        end
        
        newPopulation{1,j*2 -1} = newAlphabet1;
        newPopulation{2,j*2 -1} = newFreq1;
        newPopulation{1,j*2} = newAlphabet2;
        newPopulation{2,j*2} = newFreq2;
        
    end
    P = newPopulation;
end

fitness = MultiFitnessFunction(fileName, P, alphabetFreq);
% maxFitness = max(fitness)
maxFit

DecodeFile(fileName, resultAlphabet);










