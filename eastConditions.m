function[action, position] = eastConditions(commandStruct, command, currentPosition, map)

action = '';
position = currentPosition;
roomNumsWhereEast = commandStruct.(command);
roomNumber = getRoom(map, currentPosition);

if ~isempty(find(roomNumsWhereEast == roomNumber, 1))
    position = goEast(currentPosition);
else
    action = 'You cannot go east here.';
end

end