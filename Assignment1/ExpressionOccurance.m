function [occurance] = ExpressionOccurance(fileName, expression)

fileId = fopen(fileName);
formatSpec = '%c';
content = fscanf(fileId, formatSpec);
occurance = length(strfind(content , expression));
fclose(fileId);

end