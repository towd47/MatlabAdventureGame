function[errorMessage, position] = downConditions(commandStruct, command, currentPosition, map)

errorMessage = '';
position = currentPosition;
roomNumsWhereDown = commandStruct.(command);
roomNumber = getRoom(map, currentPosition);

if ~isempty(find(roomNumsWhereDown == roomNumber, 1))
    position = goDown(currentPosition);
else
    errorMessage = 'You cannot go down here.';
end

end

