function testthingy()

f = figure('Visible', 'off', 'color', 'black', 'Position', [0, 0, 600, 400]);
imAxes = axes('Units', 'Pixels', 'Position', [0, 0, 600, 400]);
axes(imAxes);
[X, map] = imread('Satan.jpg');
Y = imresize(X, 0.5);
imshow(Y, map);

movegui(f, 'center');
set(f, 'Visible', 'on');

end