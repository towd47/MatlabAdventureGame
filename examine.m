function[description] = examine(roomNumber, lookDescriptions, inventory, descriptions)

if length(lookDescriptions{roomNumber}) < 2
    description = descriptions{roomNumber};
else
    if roomNumber == 7
        if isempty(find(ismember(inventory, 'flashlight_on7'), 1))
            description = 'It''s too dark to see anything.';
        else
            description = lookDescriptions{roomNumber};
        end
    else
        description = lookDescriptions{roomNumber};
    end
end

end