function[isInStruct] = structContains(struct, containedItem)

% Takes a command input and the structure of all commands and checks if
% the command is in the command struct
isInStruct = -1;
names = fieldnames(struct);
for i = 1:length(names)
    if strcmp(containedItem, names{i})
        isInStruct = 1;
        break
    end
end

end