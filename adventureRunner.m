function adventureRunner()

% Load and initialize map, descriptions, and songs
[map, commandStructOrig, origDescriptions, origLookDescriptions, itemStructOrig, replacementDescriptions, replacementLookDescriptions, songNumber, songs, musicPaused, timesPlayed, directions] = initializeVariables();
[commandStruct, itemStruct, position, inventory, descriptions, lookDescriptions, commandsEntered, bossActive, bossHits, bossKilled, gameWin] = restart(commandStructOrig, itemStructOrig, origDescriptions, origLookDescriptions);

% Creating the gui to run the program.
f = figure('Visible', 'off', 'color', 'black', 'Position', [0, 0, 600, 400]);
fPosition = get(f, 'Position');
width = fPosition(3);
height = fPosition(4);

% Figures for Title Screen
titleText = uicontrol('Style', 'text', 'String', 'Andy''s Supernatural Adventure', 'BackgroundColor', 'Black', 'ForegroundColor', 'Red', 'Position', [100 325 400 75], 'fontsize', 30, 'fontname', 'Chiller');
quitButtonText = uicontrol('Style', 'pushbutton', 'String', 'Quit!', 'fontsize', 20, 'Position', [100 20 100 100], 'Callback', @quitButton); 
playButtonText = uicontrol('Style', 'pushbutton', 'String', 'Play!', 'fontsize', 20, 'Position', [250 20 100 100], 'Callback', @playButton);
helpButtonText = uicontrol('Style', 'pushbutton', 'String', 'Help!', 'fontsize', 20, 'Position', [400 20 100 100], 'Callback', @helpButton);

titleScreenUis = [titleText, quitButtonText, playButtonText, helpButtonText];

% Figures for Help/Command Screen
MovementCommandText = uicontrol('Style', 'text', 'Visible', 'off', 'fontsize', 20, 'String', 'Movement Commands: North, South, East, West, Up, Down. Use these to move throughout the house.', 'BackgroundColor', 'Black', 'ForegroundColor', 'green', 'Position', [25 300 550 100]);
ActionCommandText = uicontrol('Style', 'text', 'Visible', 'off', 'fontsize', 20, 'String', 'Action Commands: Examine - gives a closer look at the room, pickup <item> - picks up specified item, take <item> also works, use <item> - uses specified item, directions - gives descriptions of which way you can go, quit - returns to title screen.', 'BackgroundColor', 'Black', 'ForegroundColor', 'green', 'Position', [25 125 550 100]);
CommandBackButton = uicontrol('Style', 'pushbutton', 'Visible', 'off', 'String', 'Back to Title Screen!', 'Position', [25 25 550 75], 'fontsize', 20, 'Callback', @backButton);

helpScreenUis = [MovementCommandText, ActionCommandText, CommandBackButton];

% Figures for Play button and actual game
happeningText1 = uicontrol('Style', 'text', 'Visible', 'off', 'Position', [30, 3 * height / 4, width - 40, 100], 'backgroundcolor', 'black', 'foregroundcolor', 'green', 'HorizontalAlignment', 'left', 'fontsize', 14);
happeningText2 = uicontrol('Style', 'text', 'Visible', 'off', 'Position', [30, height / 2, width - 40, 100], 'backgroundcolor', 'black', 'foregroundcolor', 'green', 'HorizontalAlignment', 'left', 'fontsize', 14);
happeningText3 = uicontrol('Style', 'text', 'Visible', 'off', 'Position', [30, height / 4, width - 40, 100], 'String', ['You wake up in a large dark room. ', getRoomDescription(descriptions, getRoom(map, position))], 'backgroundcolor', 'black', 'foregroundcolor', 'green', 'HorizontalAlignment', 'left', 'fontsize', 14);
commandPrompt = uicontrol('Style', 'text', 'Visible', 'off', 'Position', [10, 63, 50, 20], 'backgroundcolor', 'black', 'foregroundcolor', 'green', 'fontsize', 14, 'String', '>>', 'HorizontalAlignment', 'left');
commandPrompt2 = uicontrol('Style', 'text', 'Visible', 'off', 'Position', [10, 183, 20, 20], 'backgroundcolor', 'black', 'foregroundcolor', 'green', 'fontsize', 14, 'String', '>>', 'HorizontalAlignment', 'left', 'Visible', 'off');
commandPrompt3 = uicontrol('Style', 'text', 'Visible', 'off', 'Position', [10, 283, 20, 20], 'backgroundcolor', 'black', 'foregroundcolor', 'green', 'fontsize', 14, 'String', '>>', 'HorizontalAlignment', 'left', 'Visible', 'off');
commandPrompt4 = uicontrol('Style', 'text', 'Visible', 'off', 'Position', [10, 383, 20, 20], 'backgroundcolor', 'black', 'foregroundcolor', 'green', 'fontsize', 14, 'String', '>>', 'HorizontalAlignment', 'left', 'Visible', 'off');
commandBox = uicontrol('Style', 'Edit', 'Visible', 'off', 'Position', [30, 60, width - 60, 25], 'backgroundcolor', 'black', 'foregroundcolor', 'green', 'fontsize', 14, 'HorizontalAlignment', 'left', 'Callback', @commandEnterCallback);
nextSong = uicontrol('Style', 'pushbutton', 'Visible', 'off', 'Position', [2 * width / 3, 0, width / 3, 50], 'String', 'Next Song', 'Callback', @nextSongCallback);
pauseResumeSong = uicontrol('Style', 'pushbutton', 'Visible', 'off', 'Position', [width / 3, 0, width / 3, 50], 'String', 'Pause', 'Callback', @pauseResumeSongCallback);
previousSong = uicontrol('Style', 'pushbutton', 'Visible', 'off', 'Position', [0, 0, width / 3, 50], 'String', 'Previous Song', 'Callback', @previousSongCallback);

playScreenUis = [happeningText1, happeningText2, happeningText3, commandPrompt, commandPrompt2, commandBox, nextSong, pauseResumeSong, previousSong];
allPlayUis = [playScreenUis, commandPrompt3, commandPrompt4];

% Figures for end game screen
menuButton = uicontrol('style', 'pushbutton', 'foregroundcolor', 'green', 'backgroundcolor', 'black', 'string', 'MENU', 'position', [25 10 150 25], 'Visible', 'off', 'Callback', @backButton);
playAgainButton = uicontrol('style', 'pushbutton', 'foregroundcolor', 'green', 'backgroundcolor', 'black', 'string', 'TRY AGAIN', 'position', [225 10 150 25], 'Visible', 'off', 'Callback', @playButton);
quittingButton = uicontrol('style', 'pushbutton', 'foregroundcolor', 'green', 'backgroundcolor', 'black', 'string', 'QUIT', 'position', [425 10 150 25], 'Visible', 'off', 'Callback', @quitButton);
textWinLose = uicontrol('style', 'text', 'backgroundcolor', 'black', 'fontsize', 14, 'position', [0 278 600 122], 'Visible', 'off');
imAxes = axes( 'Units', 'Pixels', 'Position', [0, 0, 600, 400]);
titlePic = imread('TitlePic.jpeg');
imshow(titlePic);
demonicCircle = imread('Satan.jpg');
moonlightpic = imread('moonlight.jpg');

endScreenUis = [menuButton, playAgainButton, quittingButton, textWinLose];

movegui(f, 'center');
set(f, 'Visible', 'on');

%Callback to end the program 
    function quitButton(~,~)
        close all
    end

%Callback to pull up a list of commands
    function helpButton(~,~)
        set(titleScreenUis, 'Visible', 'off');
        set(helpScreenUis, 'Visible', 'on');
        set(allPlayUis, 'Visible', 'off');
        set(endScreenUis, 'Visible', 'off');
        cla;
    end
        
    %Go back to original Title Screen Format
    function backButton(~,~)
        set(titleScreenUis, 'Visible', 'on');
        set(helpScreenUis, 'Visible', 'off');
        set(allPlayUis, 'Visible', 'off');
        set(endScreenUis, 'Visible', 'off');
        cla;
        imshow(titlePic);
    end

    %Begin Game
    function playButton(~,~)
        [commandStruct, itemStruct, position, inventory, descriptions, lookDescriptions, commandsEntered, bossActive, bossHits, bossKilled, gameWin] = restart(commandStructOrig, itemStructOrig, origDescriptions, origLookDescriptions);
        set(happeningText3, 'String', ['You wake up in a large dark room. ', getRoomDescription(descriptions, getRoom(map, position))]);
        set([happeningText1, happeningText2], 'String', '');
        set([commandPrompt2, commandPrompt3], 'Visible', 'off');
        set(titleScreenUis, 'Visible', 'off');
        set(helpScreenUis, 'Visible', 'off');
        set(playScreenUis, 'Visible', 'on');
        set(endScreenUis, 'Visible', 'off');
        cla;
        timesPlayed = timesPlayed + 1;
        fid9 = fopen('timesPlayed.txt', 'w');
        fprintf(fid9, '%d', timesPlayed);
        fclose(fid9);
    end

% Callback function for when a command is entered.
    function commandEnterCallback(~, ~)
        
        if ~musicPaused && ~isplaying(songs{songNumber})
            songNumber = nextSongNumber(songNumber, songs);
            play(songs{songNumber});
        end
        
        command = get(commandBox, 'String'); % Gets command entered
        
        if length(command) >= 3 && strcmpi(command(1:3), 'use')
            itemName = '';
            if length(command) > 4
                itemName = lower(command(5:length(command)));
            end
            command = 'use';
        end
        if length(command) >= 6 && strcmpi(command(1:6), 'pickup')
            itemName = '';
            if length(command) > 7
                itemName = lower(command(8:length(command)));
            end
            command = 'pickup';
        end
        if length(command) >= 4 && strcmpi(command(1:4), 'take')
            itemName = '';
            if length(command) > 5
                itemName = lower(command(6:length(command)));
            end
            command = 'pickup';
        end
        
        set(commandBox, 'String', ''); % Clears command box

        isvalid = ~isempty(find(ismember(fieldnames(commandStruct), command), 1)); 
        if isvalid
            if strcmp(command, 'north')
                [action, position] = northConditions(inventory, commandStruct, command, position, map);
                if ~isempty(action)
                    locMessage = action;
                else
                    locMessage = getRoomDescription(descriptions, getRoom(map, position)); % Message displaying new room
                end
            elseif strcmp(command, 'south')
                [action, position, gameWin] = southConditions(commandStruct, command, position, map, bossKilled, bossActive);
                if  gameWin == 0
                    if ~isempty(action)
                        locMessage = action;
                    else
                        locMessage = getRoomDescription(descriptions, getRoom(map, position)); % Message displaying new room
                    end
                elseif gameWin == 1
                    locMessage = action;
                    set(textWinLose, 'String', 'Out of breath, you reach the front door of the house. You reach down and grab the doorknob, praying that this time it will open. You open the door and stumble out into the moonlight. Although your legs are on fire, you force yourself to run away from the house. 100 feet out, you turn back to look at the house, only to see the last of its outline fading into nothingness. You blink hard twice, thinking that you''re seeing things. Your mind begins to race, trying to create some explaination for what you just saw, but you quickly stop and realize you''re just happy to be alive. With no idea where you are, you turn and start walking into the distance, just being thankful that you''re no longer inside the house.');
                    set(textWinLose, 'foregroundcolor', 'white');
                    set(textWinLose, 'position', [0 278 600 122]);
                    cla;
                    image(moonlightpic);
                    set(titleScreenUis, 'Visible', 'off');
                    set(helpScreenUis, 'Visible', 'off');
                    set(allPlayUis, 'Visible', 'off');
                    set(endScreenUis, 'Visible', 'on');
                    axis off;
                    fid12 = fopen('timesPlayed.txt', 'w');
                    fprintf(fid12, '2');
                    fclose(fid12);
                end
            elseif strcmp(command, 'east')
                [action, position] = eastConditions(commandStruct, command, position, map);
                if ~isempty(action)
                    locMessage = action;
                else
                    locMessage = getRoomDescription(descriptions, getRoom(map, position)); % Message displaying new room
                end
            elseif strcmp(command, 'west')
                [action, position] = westConditions(inventory, commandStruct, command, position, map);
                if ~isempty(action)
                    locMessage = action;
                else
                    locMessage = getRoomDescription(descriptions, getRoom(map, position)); % Message displaying new room
                end
            elseif strcmp(command, 'up')
                [action, position] = upConditions(inventory, commandStruct, command, position, map);
                if ~isempty(action)
                    locMessage = action;
                else
                    locMessage = getRoomDescription(descriptions, getRoom(map, position)); % Message displaying new room
                end
            elseif strcmp(command, 'down')
                [action, position] = downConditions(commandStruct, command, position, map);
                if ~isempty(action)
                    locMessage = action;
                else
                    locMessage = getRoomDescription(descriptions, getRoom(map, position)); % Message displaying new room
                end
            elseif strcmp(command, 'pickup')
                [locMessage, inventory, itemStruct, commandStruct, descriptions, lookDescriptions] = pickup(itemStruct, itemName, inventory, commandStruct, map, position, descriptions, lookDescriptions, replacementDescriptions, replacementLookDescriptions);
            elseif strcmp(command, 'use')
                [locMessage, inventory, descriptions, lookDescriptions, bossActive, bossHits, bossKilled, gameWin] = use(itemName, inventory, map, position, descriptions, lookDescriptions, replacementDescriptions, replacementLookDescriptions, bossActive, bossHits, bossKilled, timesPlayed);
                if gameWin == -1
                    cla;
                    imshow(demonicCircle);
                    set(textWinLose, 'String', 'The demon is too strong. It overpowers you and throws the knife to the side. You close your eyes as he draws his arm back. You hear a wet splattering sound and feel a pain in your chest. You fall to the ground limp, and open your eyes. Towering above you is the demon, with your heart beating its last beat in its hand. Everyting fades into darkness.');
                    set(textWinLose, 'foregroundcolor', 'red');
                    set(textWinLose, 'position', [0 335 600 65]);
                    set(titleScreenUis, 'Visible', 'off');
                    set(helpScreenUis, 'Visible', 'off');
                    set(allPlayUis, 'Visible', 'off');
                    set(endScreenUis, 'Visible', 'on');
                    axis off;
                end
                if iscell(locMessage)
                    set(happeningText3, 'String', locMessage{1});
                    locMessage = locMessage{2};
                end
            elseif strcmp(command, 'examine')
                locMessage = examine(getRoom(map, position), lookDescriptions, inventory, descriptions);
            elseif strcmp(command, 'directions')
                locMessage = directions{getRoom(map, position)};
            elseif strcmp(command, 'help')
                names = fieldnames(commandStruct);
                b = '';
                for l = 1:length(names) - 1
                    c = '';
                    if strcmp(names{l}, 'pickup') || strcmp(names{l}, 'use')
                        c = ' <item>';
                    end
                    b = [b, names{l}, c, ', '];
                end
                locMessage = ['The commands are: ', b, names{length(names)}, '.'];
                
            elseif strcmp(command, 'quit')
                cla;
                imshow(titlePic);
                set(titleScreenUis, 'Visible', 'on');
                set(helpScreenUis, 'Visible', 'off');
                set(allPlayUis, 'Visible', 'off');
                set(endScreenUis, 'Visible', 'off');
            end
            
            if strcmp(command, 'quit') ~= 1
                
                set(happeningText1, 'String', get(happeningText2, 'String'));
                set(happeningText2, 'String', get(happeningText3, 'String'));
                set(happeningText3, 'String', locMessage);
                
                if commandsEntered < 3
                    commandsEntered = commandsEntered + 1;
                    if commandsEntered == 2
                        set(commandPrompt3, 'Visible', 'on');
                    else
                        set(commandPrompt4, 'Visible', 'on');
                    end
                end
            end
            
        else % if not an actual command
            action1 = 'Error: Invalid command. Type help to see all commands.';
            set(happeningText1, 'String', get(happeningText2, 'String'));
            set(happeningText2, 'String', get(happeningText3, 'String'));
            set(happeningText3, 'String', action1);
            
            if commandsEntered < 3
                commandsEntered = commandsEntered + 1;
                if commandsEntered == 2
                    set(commandPrompt3, 'Visible', 'on');
                else
                    set(commandPrompt4, 'Visible', 'on');
                end
            end
        end
        
    end


    function nextSongCallback(~, ~)
        
        stop(songs{songNumber});
        songNumber = nextSongNumber(songNumber, songs);
        play(songs{songNumber});
        set(pauseResumeSong, 'String', 'Pause');
        
    end

    function pauseResumeSongCallback(~, ~)
        
        if isplaying(songs{songNumber}) % songs{songNumber} is the player thats playing
            pause(songs{songNumber});
            set(pauseResumeSong, 'String', 'Play');
        else
            resume(songs{songNumber});
            set(pauseResumeSong, 'String', 'Pause');
        end
    end

    function previousSongCallback(~, ~)
        
        stop(songs{songNumber});
        if songNumber == 1
            songNumber = length(songs);
        else
            songNumber = songNumber - 1;
        end
        
        play(songs{songNumber});
        set(pauseResumeSong, 'String', 'Pause');
        
    end

end