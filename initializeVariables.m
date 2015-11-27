function[map, commandStructOrig, origDescriptions, origLookDescriptions, itemStructOrig, replacementDescriptions, replacementLookDescriptions, songNumber, songs, musicPaused, timesPlayed, directions] = initializeVariables()

% Load map text file into 3 dimentional map with a 0 in places where there
% are not rooms, and a room number where there are.
map = zeros(4, 3, 4);
fid1 = fopen('places.txt');
data = textscan(fid1, '%d %s %d %d %d');
fclose(fid1);
for i = 1:length(data{1})
    map(data{3}(i), data{4}(i), data{5}(i)) = data{1}(i);
end

% Load commands from text file into a struct which includes which rooms
% each command can be used in.
fid2 = fopen('commands.txt');
commandData = textscan(fid2, '%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d');
fclose(fid2);
for i = 1:length(commandData{2})
    commandArray = [];
    for j = 2:length(commandData)
        if commandData{j}(i) == 1
            commandArray = [commandArray, j - 1];
        end
    end
    commandStructOrig.(commandData{1}{i}) = commandArray;
end

% Loads room descriptions into a cell array
fid3 = fopen('descriptions.txt');

tline = fgets(fid3);
i = 1;
origDescriptions = cell(length(commandData{2}));
while ischar(tline)
    origDescriptions{i} = tline;
    tline = fgets(fid3);
    i = i + 1;
end

fclose(fid3);

% Loads room examine descriptions into a cell array
fid5 = fopen('lookDescriptions.txt');

tline = fgets(fid5);
i = 1;
origLookDescriptions = cell(length(commandData{2}));
while ischar(tline)
    origLookDescriptions{i} = tline;
    tline = fgets(fid5);
    i = i + 1;
end

fclose(fid5);

% Loads replacement room descriptions into a cell array
fid6 = fopen('descriptions2.txt');

tline = fgets(fid6);
i = 1;
replacementDescriptions = cell(length(commandData{2}));
while ischar(tline)
    replacementDescriptions{i} = tline;
    tline = fgets(fid6);
    i = i + 1;
end

fclose(fid6);

% Loads replacement look descriptions into a cell array
fid6 = fopen('lookDescriptions2.txt');

tline = fgets(fid6);
i = 1;
replacementLookDescriptions = cell(length(commandData{2}));
while ischar(tline)
    replacementLookDescriptions{i} = tline;
    tline = fgets(fid6);
    i = i + 1;
end

fclose(fid6);

% Load items into array
fid4 = fopen('items.txt');
itemArray = textscan(fid4, '%s %d');
fclose(fid4);

for i = 1:length(itemArray{2})
    itemStructOrig.(itemArray{1}{i}) = itemArray{2}(i);
end

commandStructOrig.pickup = itemArray{2};
commandStructOrig.pickup(5) = 0;

% Loading audioplayers into cell array & starting music
songNames = {'lavenderTown.mp3', 'legendOfZeldaTheme.mp3'};
songNumber = 1;
songs = {musicPlayer(songNames{1}), musicPlayer(songNames{2})};
play(songs{songNumber});
musicPaused = false;

fid8 = fopen('timesPlayed.txt');
timesPlayedCell = textscan(fid8, '%d');
timesPlayed = timesPlayedCell{1};
fclose(fid8);

fid10 = fopen('directions.txt');

tline = fgets(fid10);
i = 1;
directions = cell(length(commandData{2}));
while ischar(tline)
    directions{i} = tline;
    tline = fgets(fid10);
    i = i + 1;
end

fclose(fid10);
end

