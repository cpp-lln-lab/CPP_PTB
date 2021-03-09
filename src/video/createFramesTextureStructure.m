function cfg = createFramesTextureStructure(cfg)

% creates a structure with the textures of the provided images/video frames %
%
% input cfg needs to have the following: % 
% cfg.screen.win : the window where the video will be played %
% cfg.video.path : the path, as a string, starting from the current directory, where the images are stores %
% cfg.video.name : the name of the video frames. All images should be named the same and followed by an increasing number, as an index to the frames %
% cfg.video.frame.format : the image format, e.g. '.png', '.jpeg', etc. It can be any format supported by imread %
% cfg.video.frame.number : the number of frames/images you want to present %
%
% new in the output is cfg.video.frames %
% a structure with the provided images stored as textures %
   
     % structure to store the video frames
     cfg.video.frames = struct;
     % fill it with the images the PTB way
     for s = 1:cfg.video.frame.number
         cfg.video.frames(s).videoFrameTexture = Screen('MakeTexture', cfg.screen.win, imread(char([cd cfg.video.path cfg.video.name num2str(s) cfg.video.frame.format])));
     end

end