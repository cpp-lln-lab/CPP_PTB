function [video, cfg] = createFramesTextureStructure(video, cfg)
    % creates a structure with the textures of the provided images/video frames
    %
    % input cfg needs to have the following:
    % cfg.screen.win : the window where the video will be played
    %
    % input video needs to have the following:
    % video.path : the path, as a string, starting from the current directory,
    %              where the images are stores
    % video.name : the name of the video frames.
    %              All images should be named the same and followed by an
    %              increasing number, as an index to the frames
    % video.frame.format : the image format, e.g. '.png', '.jpeg', etc.
    %                      It can be any format supported by imread %
    % video.frame.number : the number of frames/images you want to present
    %
    % new in the output is video.frames %
    % a structure with the provided images stored as textures %
    %
    % (C) Copyright 2020 CPP_PTB developers

    % structure to store the video frames
    video.frames = struct;
    % fill it with the images the PTB way
    for s = 1:video.frame.number
        video.frames(s).readImage = imread(fullfile(cd, ...
                                                    video.path, ...
                                                    strcat(video.name, ...
                                                           num2str(s), ...
                                                           video.frame.format)));
        video.frames(s).videoFrameTexture = Screen('MakeTexture', ...
                                                   cfg.screen.win, ...
                                                   video.frames(s).readImage);
    end

end
