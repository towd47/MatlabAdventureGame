function[audioPlayer] = musicPlayer(filename)

[y, Fs] = audioread(filename);
audioPlayer = audioplayer(y, Fs);

end