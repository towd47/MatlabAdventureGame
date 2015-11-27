function[songNumber] = nextSongNumber(songNumber, songs)

if songNumber == length(songs)
    songNumber = 1;
else
    songNumber = songNumber + 1;        
end

end

