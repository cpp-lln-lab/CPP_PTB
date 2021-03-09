function playVideoFrames(cfg)

% Plays the provided image textures at the desidred frame rate %
% The images should render as a video %
%
% input cfg needs to have the following: %
% cfg.screen.win : the window where the video will be played %
% cfg.color.background : the desired background color %
% cfg.video.frame.number : the number of frames/images you want to present %
% cfg.video.frame.rate : the frame rate (fps) at which you would like your video to be presented %
% cfg.video.frames : a structure with the images textures, as output of createFramesTextureStructure %

   % calculate the duration of a single frame based on the provided desired frame rate %    
   cfg.video.frame.duration = 1/cfg.video.frame.rate;

    % Draw background onto full screen and get first flip timestamp before images/movie presentation %
    Screen('FillRect', cfg.screen.win, cfg.color.background);
    [~, ~, lastEventTime] = Screen('Flip', cfg.screen.win);

    % frames presentation loop
    for f = 1:cfg.video.frame.number

        Screen('DrawTexture', cfg.screen.win, cfg.video.frames(f).videoFrameTexture, [], [], 0);
        [~, ~, lastEventTime] = Screen('Flip', cfg.screen.win, lastEventTime+cfg.video.frame.duration);

    end   

end