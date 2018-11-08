function [] = ReplaceChar(fileName, old , new)
fileId = fopen(fileName);
formatSpec = '%c';
content = fscanf(fileId, formatSpec);
fclose(fileId);
content = strrep(content, old, new);
fileId = fopen('result.txt' , 'w');
for i = 1:length(content)
    fprintf(fileId , '%c',content(i));
end
fclose(fileId);

end