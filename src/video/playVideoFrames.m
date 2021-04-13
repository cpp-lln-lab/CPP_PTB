function playVideoFrames(video, cfg)

% Plays the provided image textures at the desidred frame rate %
% The images should render as a video %
%
% input cfg needs to have the following: %
% cfg.screen.win : the window where the video will be played %
% cfg.color.background : the desired background color %
%
% input video needs to have the following: %
% video.frame.number : the number of frames/images you want to present %
% video.frame.rate : the frame rate (fps) at which you would like your video to be presented %
% video.frames : a structure with the images textures, as output of createFramesTextureStructure %
% video.corner : the top left coordinate of your video on screen; leave empty to present in the middle of the screen %


   % calculate the duration of a single frame based on the provided desired frame rate %    
   video.frame.duration = 1/video.frame.rate;
   
   % calculate the destination rectangle for the video
   if isempty(video.corner)
       video.position = [];
   else
       video.height = size(video.frames(1).readImage,1);
       video.width = size(video.frames(1).readImage,2);
       video.position = [video.corner, video.corner(1)+video.width, video.corner(2)+video.height];
   end

    % Draw background onto full screen and get first flip timestamp before images/movie presentation %
    Screen('FillRect', cfg.screen.win, cfg.color.background);
    [~, ~, lastEventTime] = Screen('Flip', cfg.screen.win);

    % frames presentation loop
    for f = 1:video.frame.number

        Screen('DrawTexture', cfg.screen.win, video.frames(f).videoFrameTexture, [], [video.position], 0);
        [~, ~, lastEventTime] = Screen('Flip', cfg.screen.win, lastEventTime+video.frame.duration);

    end   

    % Clear video from screen %
    Screen('FillRect', cfg.screen.win, cfg.color.background);
    [~, ~, lastEventTime] = Screen('Flip', cfg.screen.win);
    
end