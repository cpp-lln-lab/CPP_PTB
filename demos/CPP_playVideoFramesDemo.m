% (C) Copyright 2021 CPP_PTB developers

%% Demo showing how to use the createFramesTextureStructure and playVideoFrames functions

% This small script shows how to use the getReponse function

% add parent directory to matlab path (so we can access the CPP_PTB functions)
addpath(fullfile(pwd, '..'));

%% start with a clean slate
clear;
clc;

% use the default set up (use main keyboard and use the ESCAPE key to abort)


%% initialize PTB % This can def be improved by using other CPP_PTB functions%

    % Skip the PTB sync test
    Screen('Preference', 'SkipSyncTests', 2);

    % Get the screen numbers and draw to the external screen if avaliable
    cfg.screen.idx = max(Screen('Screens'));

    % Set the PTB window background manually
    cfg.color.background = [127 127 127];

    % Get the screen numbers and draw to the external screen if avaliable
    cfg.screen.idx = max(Screen('Screens'));

    % Open an on screen window
    [cfg.screen.win, cfg.screen.winRect] = Screen('OpenWindow', cfg.screen.idx, cfg.color.background);
    
    
%% Video related info

    % The name of your "video" and its images format
    cfg.video.name = 'coffee';

    % The format fo the images
    cfg.video.frame.format = '.jpeg'; % can be any img format compatible with the "imread" function

    % the folder where the images are (from the current folder)
    cfg.video.path = '/video_frames/';

    % The frame rate at which you want to present your video
    cfg.video.frame.rate = 29.97;

    % The number of frames of your video you want to present
    cfg.video.frame.number = 30;


    % Read the images and create the stucture with their textures
    cfg = createFramesTextureStructure(cfg);


    % Play the video
    playVideoFrames(cfg);


    % The end
    sca;