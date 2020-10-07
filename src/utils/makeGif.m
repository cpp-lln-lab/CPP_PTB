% (C) Copyright 2020 CPP_PTB developers

close all;
clear;
clc;

output_folder = fullfile(pwd, 'ouputs');
screen_capture_folder = fullfile(output_folder, 'screen_capture');
screen_capture_filename = fullfile(screen_capture_folder, ...
                                   'EMCL_kaks_frame-');

gif_file = fullfile(screen_capture_folder, ...
                    'EMCL_kaks_frame.gif');

FigDim = [100, 100, 1000, 1500];
Visibility = 'on';

for tif_img = 6:26 % 128

    filename = fullfile([screen_capture_filename sprintf('%04.0f', tif_img) '.tif']);

    h = figure('name', 'test', ...
               'Position', FigDim, 'Color', [1 1 1], ...
               'Visible', Visibility);

    imshow(imread(filename));

    frame = getframe(h);
    im = frame2im(frame);
    [imind, cm] = rgb2ind(im, 256);

    if tif_img == 1
        imwrite(imind, cm, gif_file, 'gif', 'Loopcount', inf);
    else
        imwrite(imind, cm, gif_file, 'gif', 'WriteMode', 'append');
    end

    close all;
end
