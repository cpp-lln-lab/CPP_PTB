function [cfg] = initPTB(cfg)
% This will initialize PsychToolBox
% - screen
%   - the windon opened takes the whole screen by default
%   - set in debug mode with window transparency if necessary
%   - can skip synch test if you ask for it (nicely)
%   - gets the flip interval
%   - computes the pixel per degree of visual angle
%   - set font details
% - keyboard
% - sound


% TO DO
% - We might want to add a couple of IF in case the experiment does not use audio for example.
% - the computation for ppd assumes the windows takes the whole screenDistance
% - refactor the window opening section (pass the window size as argument)

checkDependencies()


% For octave: to avoid displaying messenging one screen at a time
more off

% check for OpenGL compatibility, abort otherwise:
AssertOpenGL;


%% Keyboard
% Make sure keyboard mapping is the same on all supported operating systems
% Apple MacOS/X, MS-Windows and GNU/Linux:
KbName('UnifyKeyNames');




% ---------- FIX LATER ---------- %
% might be over agressive to test this at every PTB init maybe make it
% dependent on a debug "flag"

testKeyboards(cfg)

% ---------- FIX LATER ---------- %




% Don't echo keypresses to Matlab window
ListenChar(-1);


%% Mouse
% Hide the mouse cursor:
HideCursor;


%% Audio
% Intialize PsychPortAudio
% in setParameters, one needs to define 
% cfg.audio.channels
% cfg.fs
% cfg.PTBInitVolume 


InitializePsychSound(1);

if any(strcmp(cfg.stimComp,{'mac','linux'}))
    
    % pahandle = PsychPortAudio('Open' [, deviceid][, mode][, reqlatencyclass][, freq] ...
    %       [, channels][, buffersize][, suggestedLatency][, selectchannels][, specialFlags=0]);
    % Try to get the lowest latency that is possible under the constraint of reliable playback
    cfg.pahandle = PsychPortAudio('Open', [], [], 3, cfg.fs, cfg.audio.channels);
     
else
    
    % get audio device list
    audio_dev       = PsychPortAudio('GetDevices');
    
    % find output device using WASAPI deiver
    idx             = find([audio_dev.NrInputChannels] == 0 & ...
        [audio_dev.NrOutputChannels] == 2 & ...
        ~cellfun(@isempty, regexp({audio_dev.HostAudioAPIName},'WASAPI')));
    
    % save device ID
    cfg.audio.i     = audio_dev(idx).DeviceIndex;
    
    % get device's sampling rate
    cfg.fs          = audio_dev(idx).DefaultSampleRate;
    
    % the latency is not important - but consistent latency is! Let's try with WASAPI driver.
    cfg.pahandle    = PsychPortAudio('Open', cfg.audio.i, 1, 3, cfg.fs, cfg.audio.channels);
    % cfg.pahandle = PsychPortAudio('Open', [], [], 0, cfg.fs, cfg.audio.channels);
    
end

% set initial PTB volume for safety (participants can adjust this manually
% at the begining of the experiment)
PsychPortAudio('Volume', cfg.pahandle, cfg.PTBInitVolume);

cfg.audio.pushsize  = cfg.fs*0.010; %! push N ms only
cfg.requestoffsettime = 1; % offset 1 sec
cfg.reqsampleoffset = cfg.requestoffsettime*cfg.fs; %


% playing parameters
% sound repetition
cfg.PTBrepet = 1;

% Start immediately (0 = immediately)
cfg.PTBstartCue = 0;

% Should we wait for the device to really start (1 = yes)
cfg.PTBwaitForDevice = 1;


%% Visual

cfg.screen = max(Screen('Screens')); % Main screen

% Open a fullscreen, onscreen window with gray background. Enable 32bpc
% floating point framebuffer via imaging pipeline on it.
PsychImaging('PrepareConfiguration');

% init PTB with different options in concordance to the Debug Parameters
if cfg.debug

    % set to one because we don not care about time
    Screen('Preference', 'SkipSyncTests', 2);
    Screen('Preference', 'Verbosity', 0);
    Screen('Preferences', 'SuppressAllWarnings', 2);

    if cfg.testingSmallScreen
        [cfg.win, cfg.winRect] = PsychImaging('OpenWindow', cfg.screen, cfg.backgroundColor,  [0,0, 480, 270]);
    else
        if cfg.testingTranspScreen
        PsychDebugWindowConfiguration
        end
        [cfg.win, cfg.winRect] = PsychImaging('OpenWindow', cfg.screen, cfg.backgroundColor);
    end

else
    Screen('Preference','SkipSyncTests', 0);
    [cfg.win, cfg.winRect] = PsychImaging('OpenWindow', cfg.screen, cfg.backgroundColor);

end


% window size info
[cfg.winWidth, cfg.winHeight] = WindowSize(cfg.win);




% ---------- FIX LATER ---------- %
% I don't think we want to hard code the 2/3 here. We might just add it to
% the Cfg structure
if strcmpi(cfg.stimPosition,'scanner')
    cfg.winRect(1,4) = cfg.winRect(1,4)*2/3;
end
% ---------- FIX LATER ---------- %




% Get the Center of the Screen
cfg.center = [cfg.winRect(3), cfg.winRect(4)]/2;

% Computes the number of pixels per degree given the distance to screen and
% monitor width

% This assumes that the window fills the whole screen
V = 2*(180*(atan(cfg.monitorWidth/(2*cfg.screenDistance))/pi));
cfg.ppd = cfg.winRect(3)/V;


% Enable alpha-blending, set it to a blend equation useable for linear
% superposition with alpha-weighted source.
Screen('BlendFunction', cfg.win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


%% Text and Font
% Select specific text font, style and size:
Screen('TextFont',cfg.win, cfg.textFont );
Screen('TextSize',cfg.win, cfg.textSize);
Screen('TextStyle', cfg.win, cfg.textStyle);


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
