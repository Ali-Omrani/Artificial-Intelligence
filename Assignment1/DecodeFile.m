function [] = DecodeFile(fileName, key)
fileId = fopen(fileName);
formatSpec = '%c';
content = fscanf(fileId, formatSpec);
fclose(fileId);
for i=1:26
     ascii = i + double('a') -1;
     old = key(i)
     new = char(ascii)
     
     content = strrep(content, old, new);
end
  fileId = fopen('result.txt' , 'w');
for i = 1:length(content)
    fprintf(fileId , '%c',content(i));
end
fclose(fileId);

end