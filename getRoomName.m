function[roomName] = getRoomName(roomNum, roomNames)

roomName = roomNames{roomNum};
if ~isempty(strfind(roomName, '_'))
    index = strfind(roomName, '_');
    roomName(index) = ' ';
end

end

