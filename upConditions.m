function[action, position] = upConditions(inventory, commandStruct, command, currentPosition, map)

action = '';
position = currentPosition;
roomNumsWhereUp = commandStruct.(command);
roomNumber = getRoom(map, currentPosition);

if ~isempty(find(roomNumsWhereUp == roomNumber, 1))
    if roomNumber == 11
        if ~isempty(find(ismember(inventory, 'ladder_used'), 1))
            position = goUp(currentPosition);
        else
            action = 'The hole is too high for you to reach';
        end
    else
        position = goUp(currentPosition);
    end
else
    action = 'You cannot go up here.';
end

end