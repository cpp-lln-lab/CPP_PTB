% (C) Copyright 2021 CPP_PTB developers

%% Demo showing how to use the createFramesTextureStructure and playVideoFrames functions

% as it is, it presents two example videos in succession


% add parent directory to matlab path (so we can access the CPP_PTB functions)
addpath(fullfile(pwd, '..'));

%% start with a clean slate
clear;
clc;


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
    
    
%% Strcuture for video related info

    % The name of your "video" and its images format
    video.names = {'coffee','leaves'};
    
    % The number of frames of your video you want to present
    % If left empty, all available frames are taken
    video.frame.numbers = [];
    % video.frame.numbers = 30;
    % video.frame.numbers = [30,15];

    % The format fo the images
    video.frame.format = '.jpeg'; % can be any img format compatible with the "imread" function

    % the folder where the images are (from the current folder)
    video.stimuli.folder = 'stimuli/';

    % The frame rate at which you want to present your video
    video.frame.rate = 29.97;

    % Time bw videos in s
    video.isi = 1;

    
%% present the videos in a loop

    for trial = 1:length(video.names)
        
    % select name and folder where current video is
    video.name = video.names{trial};
    video.path = fullfile(video.stimuli.folder,video.name);
    
    
    % how many frames are going to be presented
    if numel(video.frame.numbers) < 1
        video.frame.number = size(dir([video.path,'/*',video.frame.format]),1);
        
    elseif numel(video.frame.numbers) > 1
        video.frame.number = video.frame.numbers(trial);
    
    else
        video.frame.number = video.frame.numbers;
    end
        
    
    % Read the images and create the stucture with their textures
    [video, cfg] = createFramesTextureStructure(video, cfg);

    % Play the video
    playVideoFrames(video, cfg);
    
    % ISI (better would be to use Flip)
    WaitSecs(video.isi);
    
    end


    % The end
    sca;
