function [cfg] = initPTB(cfg)
% This will initialize PsychToolBox
% - screen
% - the windon opened takes the whole screen unless
% cfg.testingSmallScreen is set to true
% - debug mode : skips synch test and warnings
% - window transparency enabled by cfg.testingTranspScreen set to true
% - gets the flip interval
% - computes the pixel per degree of visual angle:
% the computation for ppd assumes the windows takes the whole screenDistance
% - set font details
% - keyboard
% - hides cursor
% - sound
%
% OUTPUT:
% cfg.keyboard = [];
% cfg.responseBox = [];
% 
% cfg.debug = true;
% cfg.testingTranspScreen = true;
% cfg.testingSmallScreen = true;
% 
% cfg.screen : screen numbers where drawing the stimulation (external screen if available)
% cfg.win : window opened by PTB
% cfg.winRect : window rectangule positiona and dimensions in pixel coordinates
% cfg.winWidth : window width in pixels
% cfg.winHeight : window height in pixels
% cfg.center : coordinate of the window center
% cfg.ppd : pixels per degree assuming the window fills the whole screen
% cfg.ifi : estimate of the monitor flip interval
% cfg.monRefresh : monitor refresh rate
% cfg.vbl : (I don't think this output is useful)
% cfg.textFont = 'Courier New';
% cfg.textSize = 18;
% cfg.textStyle = 1;
% cfg.backgroundColor = [0 0 0];
% cfg.monitorWidth = 42;
% cfg.screenDistance = 134;

% TO DO
% - We might want to add a couple of IF in case the experiment does not use audio for example.


checkDependencies()

% For octave: to avoid displaying messenging one screen at a time
more off

% check for OpenGL compatibility, abort otherwise:
AssertOpenGL;

cfg = setDefaultsPTB(cfg);

initDebug(cfg);


%% Keyboard
initKeyboard


%% Mouse
HideCursor;


    %% Audio
    cfg = initAudio(cfg);
    


%% Visual

% Get the screen numbers and draw to the external screen if avaliable
cfg.screen = max(Screen('Screens'));

cfg = openWindow(cfg);

% window size info
[cfg.winWidth, cfg.winHeight] = WindowSize(cfg.win);

if strcmpi(cfg.stimPosition,'scanner')
    cfg.winRect(1,4) = cfg.winRect(1,4)*2/3;
end

% Get the Center of the Screen
cfg.center = [cfg.winRect(3), cfg.winRect(4)]/2;

% Computes the number of pixels per degree given the distance to screen and
% monitor width
% This assumes that the window fills the whole screen
FOV = computeFOV(cfg);
cfg.ppd = cfg.winRect(3)/FOV;


%% Select specific text font, style and size
initText(cfg)


%% Timing
% Query frame duration
cfg.ifi = Screen('GetFlipInterval', cfg.win);
cfg.monRefresh = 1/cfg.ifi;

% Set priority for script execution to realtime priority:
Priority(MaxPriority(cfg.win));


%% Warm up some functions
% Do dummy calls to GetSecs, WaitSecs, KbCheck to make sure
% they are loaded and ready when we need them - without delays
% in the wrong moment:
KbCheck;
WaitSecs(0.1);
GetSecs;


%% Initial flip to get a first time stamp
% Initially sync us to VBL at start of animation loop.
cfg.vbl = Screen('Flip', cfg.win);


end


function initDebug(cfg)

% init PTB with different options in concordance to the debug Parameters
Screen('Preference','SkipSyncTests', 0);
if cfg.debug
    
    Screen('Preference', 'SkipSyncTests', 2);
    Screen('Preference', 'Verbosity', 0);
    Screen('Preferences', 'SuppressAllWarnings', 2);
    
    fprintf('\n\n\n\n')
    fprintf('########################################\n')
    fprintf('##   DEBUG MODE. TIMING WILL BE OFF.  ##\n')
    fprintf('########################################')
    fprintf('\n\n\n\n')
    
    testKeyboards(cfg)
    
end

if cfg.testingTranspScreen
    PsychDebugWindowConfiguration
end

end

function initKeyboard

% Make sure keyboard mapping is the same on all supported operating systems
% Apple MacOS/X, MS-Windows and GNU/Linux:
KbName('UnifyKeyNames');

% Don't echo keypresses to Matlab window
ListenChar(-1);

end

function cfg = initAudio(cfg)
    
    if cfg.initAudio

        InitializePsychSound(1);

        cfg.audio.devIdx= [];
        cfg.audio.playbackMode = 1;
            
        if isfield(cfg.audio, 'useDevice')
            
            % get audio device list
            audioDev = PsychPortAudio('GetDevices');
            
            % find output device to use
            idx = find(...
                audioDev.NrInputChannels == cfg.audio.inputChannels && ...
                audioDev.NrOutputChannels == cfg.audio.channels && ...
                ~cellfun(@isempty, regexp({audioDev.HostAudioAPIName}, cfg.audio.deviceName)));
            
            % save device ID
            cfg.audio.devIdx = audioDev(idx).DeviceIndex;
            
            % get device's sampling rate
            cfg.audio.fs = audioDev(idx).DefaultSampleRate;

        end
        
        cfg.audio.pahandle = PsychPortAudio('Open', ...
            cfg.audio.devIdx, ...
            cfg.audio.playbackMode, ...
            cfg.audio.requestedLatency, ...
            cfg.audio.fs, ...
            cfg.audio.channels);
        
        % set initial PTB volume for safety (participants can adjust this manually
        % at the begining of the experiment)
        PsychPortAudio('Volume', cfg.audio.pahandle, cfg.audio.initVolume);
        
        cfg.audio.pushSize  = cfg.audio.fs * 0.010; %! push N ms only
        
        cfg.audio.requestOffsetTime = 1; % offset 1 sec
        cfg.audio.reqsSampleOffset = cfg.audio.requestOffsetTime * cfg.audio.fs;

    end
end

function cfg = openWindow(cfg)

if cfg.testingSmallScreen
    [cfg.win, cfg.winRect] = Screen('OpenWindow', cfg.screen, cfg.backgroundColor, [0,0, 480, 270]);
else
    [cfg.win, cfg.winRect] = Screen('OpenWindow', cfg.screen, cfg.backgroundColor);
end

% Enable alpha-blending, set it to a blend equation useable for linear
% superposition with alpha-weighted source.
Screen('BlendFunction', cfg.win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

end

function FOV = computeFOV(cfg)

% computes the number of degrees of visual angle in the whole field of view
FOV = 2 *( 180 * ( atan( cfg.monitorWidth / (2*cfg.screenDistance) ) / pi));

end


function initText(cfg)

Screen('TextFont', cfg.win, cfg.textFont);
Screen('TextSize', cfg.win, cfg.textSize);
Screen('TextStyle', cfg.win, cfg.textStyle);

end