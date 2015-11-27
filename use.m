function[action, inventory, descriptions, lookDescriptions, bossActive, bossHits, bossKilled, gameWin] = use(itemName, inventory, map, position, descriptions, lookDescriptions, replacementDescriptions, replacementLookDescriptions, bossActive, bossHits, bossKilled, timesPlayed)

roomNumber = getRoom(map, position);
gameWin = 0;
unableAction = 'You can''t use that now.';

if ~strcmp(itemName, '')
    if ~bossKilled
        if strcmp(itemName, 'ancient key')
            itemName = 'ancient_key';
        end
        if ~isempty(find(ismember(inventory, itemName), 1))
            if ~isempty(find(ismember(inventory, 'ancient_key'), 1)) && roomNumber == 2 && strcmp(itemName, 'key')
                itemName = 'ancient_key';
            end
            if strcmp(itemName, 'crowbar')
                if roomNumber == 19
                    if isempty(find(ismember(inventory, 'crowbar_used'), 1))
                        inventory = [inventory, 'crowbar_used'];
                        action = 'You swing the crowbar and smash the wall. It crumbles, revealing an opening to another room. Unfortunately you broke the crowbar in the process.';
                        lookDescriptions{roomNumber} = replacementLookDescriptions{roomNumber};
                    else
                        action = 'You already broke the wall.';
                    end
                else
                    action = unableAction;
                end
            elseif strcmp(itemName, 'stone')
                if roomNumber == 1
                    action = 'You place the stone in the center and the candles blow out. The Room is lit by an ominous red light which emanates from the stone. There is a flash of light and you close your eyes to shield them. When you open your eyes and they adjust to the light you see a figure in front of you. As you make eye contact you see its eyes are pure black. It lets out a demonic scream and rushes you.';
                    descriptions{roomNumber} = replacementDescriptions{roomNumber};
                    bossActive = true;
                else
                    action = unableAction;
                end
            elseif strcmp(itemName, 'ladder')
                if roomNumber == 11
                    if isempty(find(ismember(inventory, 'ladder_used'), 1))
                        inventory = [inventory, 'ladder_used'];
                        action = 'You place the ladder under the hole. It''s the perfect height.';
                        descriptions{roomNumber} = replacementDescriptions{roomNumber};
                    else
                        action = unableAction;
                    end
                else
                    action = unableAction;
                end
            elseif strcmp(itemName, 'knife')
                if roomNumber == 1
                    if bossHits == 2
                        action = 'You brace yourself with the knife held out in front of you. The creature jumps right on the knife. It sinks into the dark red skin and the creature goes silent. You let go of the knife and the creature falls to the floor. You look down at your blood-covered hands and wonder, what just happened? Before you can question your sanity, everything around you starts shaking. Pieces of concrete from the ceiling start falling around you. The back corner of the room caves in. You need to get out of here now!';
                        bossKilled = true;
                        bossActive = false;
                        descriptions{2} = replacementDescriptions{2};
                        descriptions{3} = replacementDescriptions{3};
                        descriptions{13} = replacementDescriptions{13};
                    else
                        action = 'You try to stab the demon with the knife, but he overpowers you and rips you to shreads.';
                        gameWin = -1;
                    end
                elseif roomNumber == 5
                    if isempty(find(ismember(inventory, 'knife_used5'), 1))
                        inventory = [inventory, 'knife_used5', 'stone'];
                        action = 'You use the knife to cut open the bag and find a small red stone. You pickup the stone.';
                        lookDescriptions{roomNumber} = replacementLookDescriptions{roomNumber};
                    else
                        action = unableAction;
                    end
                else
                    action = unableAction;
                end
            elseif strcmp(itemName, 'letter')
                letterText = sprintf('To whomever it may concern, If you have found this letter then it means I have failed. It also means that you have been dragged here and are now in a very dangerous predicament. This house is sealed from the outside by a hex which can only be broken if the entity which put it there is destroyed. This being lurks in a different dimension parallel to our own. The only way to destroy the entity is to summon it into our dimension and kill it. That was my task.');
                letterText2 = sprintf('Because I have failed, this task now falls to you. Should you fail, another random soul will be summoned here to take your place and complete the same task. If this demonic creature is not stopped it could lead to the end. The end of humanity, of life, and of the world as we know it. Do not make my mistakes. Prepare yourself and defeat this abomination. Good luck, a Friend. You keep reading and see another message with a bunch of crossed off numbers: You are number %d. Dont fail us.', timesPlayed);
                action = {letterText, letterText2};
            elseif strcmp(itemName, 'key')
                if roomNumber == 17
                    if isempty(find(ismember(inventory, 'key_used'), 1))
                        inventory = [inventory, 'key_used'];
                        action = 'You use the key to unlock the door.';
                    else
                        action = 'You already unlocked the door.';
                    end
                else
                    action = unableAction;
                end
            elseif strcmp(itemName, 'ancient_key')
                if roomNumber == 2
                    if isempty(find(ismember(inventory, 'ancient key_used'), 1))
                        inventory = [inventory, 'ancient key_used'];
                        action = 'You use the ancient key to unlock the door.';
                    else
                        action = 'You already unlocked the door.';
                    end
                else
                    action = unableAction;
                end
            elseif strcmp(itemName, 'flashlight')
                if roomNumber == 6
                    if ~isempty(find(ismember(inventory, 'flashlight_on6'), 1))
                        action = 'You already used the flashlight here.';
                    else
                        inventory = [inventory, 'flashlight_on6'];
                        action = 'You turn on the flashlight.';
                        descriptions{roomNumber} = replacementDescriptions{roomNumber};
                    end
                elseif roomNumber == 7
                    if ~isempty(find(ismember(inventory, 'flashlight_on7'), 1))
                        action = 'You already used the flashlight here.';
                    else
                        inventory = [inventory, 'flashlight_on7'];
                        action = 'You turn on the flashlight.';
                        descriptions{roomNumber} = replacementDescriptions{roomNumber};
                    end
                else
                    action = unableAction;
                end
            elseif strcmp(itemName, 'mace')
                if roomNumber == 1 && bossActive
                    if bossHits == 0
                        action = 'You club the figure with the mace and it staggers. It looks back at you bloodied and enraged, and rushes you again.';
                        bossHits = bossHits + 1;
                    elseif bossHits == 1
                        action = 'You bash it in the face once more sending it back to the ground. You turn to leave but the door won''t move. When you look back the creature is standing up staring at you. It makes a motion with its hand and the mace is torn from your grip and sent across the room. You cannot get to it. You must have something else you can use to defend yourself! The creature leaps at you once more.';
                        bossHits = bossHits + 1;
                    else
                        action = 'You no longer have that item!';
                    end
                else
                    action = unableAction;
                end
            else
                action = 'That item does not exist.';
            end

        else
            action = 'That item does not exist.';
        end
    else
        action = 'There''s not time to use anything, you have to get out of the house!';
    end
else
    action = 'Use what?';
end

end