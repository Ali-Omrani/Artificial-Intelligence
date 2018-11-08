function [occurance] = CharacterOccurance(fileName)

occurance = zeros(26,1);
fileId = fopen(fileName);
formatSpec = '%c'
res = textscan(fileId , formatSpec);
doubleRes = double(res{:});
B = double('A':'Z');
occurance = histc(doubleRes, B);
total = sum(occurance);

% occurance = (occurance ./ total).*100 ;


characterBins = char(B);                       % Character Bins
for k1 = 1:2                       % Output Table
    idxrng = (1:13)+13*(k1-1);
    fprintf(1,['\n\t' repmat(' ~%c~ ', 1, 13) '\n'], characterBins(idxrng))
    fprintf(1,['\n\t' repmat('%3d  ', 1, 13) '\n\n'], occurance(idxrng))
end


fclose(fileId);
end