function [cfg] = initPTB(cfg)
% This will initialize PsychToolBox
% - screen
%   - the windon opened takes the whole screen unless
%       cfg.testingSmallScreen is set to true 
%   - debug mode : skips synch test and warnings
%   - window transparency enabled by cfg.testingTranspScreen set to true
%   - gets the flip interval
%   - computes the pixel per degree of visual angle:
%       the computation for ppd assumes the windows takes the whole screenDistance
%   - set font details
% - keyboard
% - hides cursor
% - sound


% TO DO
% - We might want to add a couple of IF in case the experiment does not use audio for example.


checkDependencies()

% For octave: to avoid displaying messenging one screen at a time
more off

% check for OpenGL compatibility, abort otherwise:
AssertOpenGL;

initDebug(cfg);


%% Keyboard
initKeyboard(cfg)


%% Mouse
HideCursor;


%% Audio
InitializePsychSound(1);


%% Visual

% Get the screen numbers and draw to the external screen if avaliable
cfg.screen = max(Screen('Screens'));

cfg = openWindow(cfg);

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

function cfg = setDefaults(cfg)

cfg.keyboard = [];
cfg.responseBox = [];

cfg.debug = true;
cfg.testingTranspScreen = true;
cfg.testingSmallScreen = true;

cfg.backgroundColor = [0 0 0];

cfg.textFont = 'Courier New';
cfg.textSize = 18;
cfg.textStyle = 1;

cfg.monitorWidth = 42;
cfg.screenDistance = 134;
end


function initDebug(cfg)

% init PTB with different options in concordance to the debug Parameters
Screen('Preference','SkipSyncTests', 0);
if cfg.debug
    Screen('Preference', 'SkipSyncTests', 2);
    Screen('Preference', 'Verbosity', 0);
    Screen('Preferences', 'SuppressAllWarnings', 2);
end

if cfg.testingTranspScreen
    PsychDebugWindowConfiguration
end

end

function initKeyboard(cfg)

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

end

function cfg = openWindow(cfg)

if cfg.testingSmallScreen
    [cfg.win, cfg.winRect] = Screen('OpenWindow', cfg.screen, cfg.backgroundColor,  [0,0, 480, 270]);
else
    [cfg.win, cfg.winRect] = Screen('OpenWindow', cfg.screen, cfg.backgroundColor);
end

%TODO make this optional

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