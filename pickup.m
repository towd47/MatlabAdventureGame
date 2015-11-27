function[action, inventory, itemStruct, commandStruct, descriptions, lookDescriptions] = pickup(itemStruct, itemName, inventory, commandStruct, map, position, descriptions, lookDescriptions, replacementDescriptions, replacementLookDescriptions)

roomNum = getRoom(map, position);
if ~strcmp(itemName, '')
    if strcmp(itemName, 'ancient key')
        itemName = 'ancient_key';
    end
    if structContains(itemStruct, itemName) == 1
        if roomNum == 13 && strcmpi(itemName, 'key')
            itemName = 'ancient_key';
        end
        if roomNum == 7 && isempty(find(ismember(inventory, 'flashlight_on7'), 1))
            action = 'It''s too dark to see anything you can pickup here.';
        elseif itemStruct.(itemName) == roomNum
        	itemStruct.(itemName) = 0;
            inventory = [inventory, itemName];
            if strcmp(itemName, 'ancient_key')
                itemName = 'ancient key';
            end
            action = ['You pickup the ', itemName, '. '];
            commandStruct.pickup(roomNum) = 0;
            if length(replacementDescriptions{roomNum}) > 2
                descriptions{roomNum} = replacementDescriptions{roomNum};
            end
            if length(replacementLookDescriptions{roomNum}) > 2
                lookDescriptions{roomNum} = replacementLookDescriptions{roomNum};
            end
        else
            action = 'That item is not in this room.';
        end
    else
        action = 'That item does not exist.';
    end
else
    action = 'Pickup what?';
end

end

