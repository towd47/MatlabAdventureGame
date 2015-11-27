function[action, position] = northConditions(inventory, commandStruct, command, currentPosition, map)

action = '';
position = currentPosition;
roomNumsWhereNorth = commandStruct.(command);
roomNumber = getRoom(map, currentPosition);

if ~isempty(find(roomNumsWhereNorth == roomNumber, 1))
    if roomNumber == 2
        if ~isempty(find(ismember(inventory, 'ancient key_used'), 1))
            position = goNorth(currentPosition);
        else
            action = 'The door is locked.';
        end
    elseif roomNumber == 6
        if ~isempty(find(ismember(inventory, 'flashlight_on6'), 1))
            position = goNorth(currentPosition);
        else
            action = 'It''s too dark to proceed. Maybe if you had a light...';
        end
    elseif roomNumber == 17
        if ~isempty(find(ismember(inventory, 'key_used'), 1))
            position = goNorth(currentPosition);
        else
            action = 'The door is locked.';
        end
    else
        position = goNorth(currentPosition);
    end
else
    action = 'You cannot go north here.';
end

end