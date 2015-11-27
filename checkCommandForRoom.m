function[isValidForRoom, action] = checkCommandForRoom(commandStruct, command, currentRoomNum)

isValidForRoom = -1;
if structContains(commandStruct, command) == 1 % checks if the command is a valid command
    for i = 1:length(commandStruct.(command))
        if currentRoomNum == commandStruct.(command)(i)
            isValidForRoom = 1;
        end
    end
    action = '';
end
    
if isValidForRoom == -1 % if the command is not valid for the room, or not a command at all, then this fuction returns a string with the available commands for the current room
    names = fieldnames(commandStruct);
    availableCommands = {};
    for i = 1:length(names)
        if ismember(currentRoomNum, commandStruct.(names{i}))
            availableCommands = [availableCommands, names(i)];
        end
    end
    a = 'ERROR: Invalid command. The available commands for this room are: ';
    b = '';
    for i = 1:length(availableCommands) - 1
        b = [b, availableCommands{i}, ', '];
    end
    b = [b, availableCommands{length(availableCommands)}, '.'];
    action = [a, b];
end
    
end