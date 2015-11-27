function[commandStruct, itemStruct, position, inventory, descriptions, lookDescriptions, commandsEntered, bossActive, bossHits, bossKilled, gameWin] = restart(commandStructOrig, itemStructOrig, origDescriptions, origLookDescriptions)

commandStruct = commandStructOrig;
itemStruct = itemStructOrig;
descriptions = origDescriptions;
lookDescriptions = origLookDescriptions;

position = [4, 2, 2];
inventory = {};
commandsEntered = 1;
bossActive = false;
bossHits = 0;
bossKilled = false;
gameWin = 0;

end

