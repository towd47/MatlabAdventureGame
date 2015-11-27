function[action, position, gameWin] = southConditions(commandStruct, command, currentPosition, map, bossKilled, bossActive)

action = '';
gameWin = false;
position = currentPosition;
roomNumsWhereSouth = commandStruct.(command);
roomNumber = getRoom(map, currentPosition);

if ~isempty(find(roomNumsWhereSouth == roomNumber, 1))
    if ~bossActive
        position = goSouth(currentPosition);
    else
        action = 'You can not run from the demon.';
    end
elseif getRoom(map, currentPosition) == 9 && bossKilled == true
    gameWin = 1;
else
    action = 'You cannot go south here.';
end

end