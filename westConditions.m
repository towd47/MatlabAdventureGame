function[action, position] = westConditions(inventory, commandStruct, command, currentPosition, map)

action = '';
position = currentPosition;
roomNumsWhereWest = commandStruct.(command);
roomNumber = getRoom(map, currentPosition);

if ~isempty(find(roomNumsWhereWest == roomNumber, 1))
    if roomNumber == 6
        if ~isempty(find(ismember(inventory, 'flashlight_on6'), 1))
            position = goWest(currentPosition);
        else
            action = 'It''s too dark to proceed. Maybe if you had a light...';
        end
    elseif roomNumber == 19
        if ~isempty(find(ismember(inventory, 'crowbar_used'), 1))
            position = goWest(currentPosition);
        else
            action = 'The wall looks weak, maybe you could break it with something?';
        end
    else
        position = goWest(currentPosition);
    end
else
    action = 'You cannot go west here.';
end

end