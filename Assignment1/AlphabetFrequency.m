function [frequency] = AlphabetFrequency(fileName)
frequency = 0;
fileId = fopen(fileName);
formatSpec = '%f';
frequency = fscanf(fileId , formatSpec);
frequency = frequency * 100;
end