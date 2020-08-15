function [cfg] = initPTB(cfg)
    % [cfg] = initPTB(cfg)
    %
    % This will initialize PsychToolBox
    % - screen
    % - the windon opened takes the whole screen unless
    % cfg.screen.smallWin is set to true
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
    % See the Readme for more details on the content of cfg
    %
    %
    %

    checkPtbVersion();

    cfg = getOsInfo(cfg);

    pth = fileparts(mfilename('fullpath'));
    addpath(genpath(fullfile(pth, 'src')));

    % For octave: to avoid displaying messenging one screen at a time
    more off;

    % check for OpenGL compatibility, abort otherwise:
    AssertOpenGL;

    cfg = setDefaultsPTB(cfg);

    initKeyboard;
    initDebug(cfg);

    % Mouse
    HideCursor;

    %% Audio
    cfg = initAudio(cfg);

    %% Visual

    % Get the screen numbers and draw to the external screen if avaliable
    cfg.screen.idx = max(Screen('Screens'));

    cfg = openWindow(cfg);

    % window size info
    [cfg.screen.winWidth, cfg.screen.winHeight] = WindowSize(cfg.screen.win);

    % Get the Center of the Screen
    cfg.screen.center = [cfg.screen.winRect(3), cfg.screen.winRect(4)] / 2;

    % Computes the number of pixels per degree given the distance to screen and
    % monitor width
    % This assumes that the window fills the whole screen
    cfg.screen.FOV = computeFOV(cfg);
    cfg.screen.ppd = cfg.screen.winWidth / cfg.screen.FOV;

    % Initialize visual parmaters for fixation cross or dot
    cfg = initFixation(cfg);

    %% Select specific text font, style and size
    initText(cfg);

    %% Timing
    % Query frame duration
    cfg.screen.ifi = Screen('GetFlipInterval', cfg.screen.win);
    cfg.screen.monitorRefresh = 1 / cfg.screen.ifi;

    % Set priority for script execution to realtime priority:
    Priority(MaxPriority(cfg.screen.win));

    %% Warm up some functions
    % Do dummy calls to GetSecs, WaitSecs, KbCheck to make sure
    % they are loaded and ready when we need them - without delays
    % in the wrong moment:
    KbCheck;
    WaitSecs(0.1);
    GetSecs;

end

function cfg = getOsInfo(cfg)

    cfg.software.os = computer();
    cfg.software.name = 'Psychtoolbox';
    cfg.software.RRID = 'SCR_002881';

    [~, versionStruc] = PsychtoolboxVersion;

    cfg.software.version = sprintf('%i.%i.%i', ...
            versionStruc.major, ...
            versionStruc.minor, ...
            versionStruc.point);

    runsOn = 'Matlab - ';
    if IsOctave
        runsOn = 'Octave - ';
    end
    cfg.software.runsOn = [runsOn version()];

end

function initDebug(cfg)

    % init PTB with different options in concordance to the debug Parameters
    Screen('Preference', 'SkipSyncTests', 0);
    if cfg.debug.do

        Screen('Preference', 'SkipSyncTests', 2);
        Screen('Preference', 'Verbosity', 0);
        Screen('Preference', 'SuppressAllWarnings', 1);

        fprintf('\n\n\n\n');
        fprintf('########################################\n');
        fprintf('##   DEBUG MODE. TIMING WILL BE OFF.  ##\n');
        fprintf('########################################');
        fprintf('\n\n\n\n');

        testKeyboards(cfg);

    end

    if cfg.debug.transpWin
        PsychDebugWindowConfiguration;
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

    if cfg.audio.do

        InitializePsychSound(1);

        cfg.audio.devIdx = [];
        cfg.audio.playbackMode = 1;

        if isfield(cfg.audio, 'useDevice')

            % get audio device list
            audioDev = PsychPortAudio('GetDevices');

            % find output device to use
            idx = find( ...
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

        cfg.audio.pushSize  = cfg.audio.fs * 0.010; % ! push N ms only

        cfg.audio.requestOffsetTime = 1; % offset 1 sec
        cfg.audio.reqsSampleOffset = cfg.audio.requestOffsetTime * cfg.audio.fs;

    end
end

function cfg = openWindow(cfg)

    if cfg.debug.smallWin
        [cfg.screen.win, cfg.screen.winRect] = ...
            Screen('OpenWindow', cfg.screen.idx, cfg.color.background, ...
            [0, 0, 480, 270]);
    else
        [cfg.screen.win, cfg.screen.winRect] = ...
            Screen('OpenWindow', cfg.screen.idx, cfg.color.background);
    end

    % Enable alpha-blending, set it to a blend equation useable for linear
    % superposition with alpha-weighted source.
    % Required for drwing smooth lines and screen('DrawDots')
    Screen('BlendFunction', cfg.screen.win, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

end

function initText(cfg)

    Screen('TextFont', cfg.screen.win, cfg.text.font);
    Screen('TextSize', cfg.screen.win, cfg.text.size);
    Screen('TextStyle', cfg.screen.win, cfg.text.style);

end
