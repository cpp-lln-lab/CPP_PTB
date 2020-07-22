function devSandbox

    % This script is a stand-alone function that can be useful as a sandbox to
    %  develop the PTB audio/visual stimulation of your experiment. No input/output
    %  required.
    %
    % Here, a tutorial from https://peterscarfe.com/contrastgratingdemo.html is
    %  provided for illustrative purpose (notice that some variable names are updated
    %  to our code style). For your use, you will delete that part.
    %
    % It is composed of two parts:
    %  - a fixed structure that will initialize and close PTB in 'debug mode'
    %    (`PsychDebugWindowConfiguration`, `SkipSyncTests`)
    %  - the actual sandbox where to set your dynamic variables (the stimulation
    %    parameters) and the 'playground' where to develop the stimulation code
    %
    % When you are happy with it, ideally you will move the vars in `setParameters.m`
    %  and the stimulation code in a separate function in `my-experiment-folder/subfun`.
    %  The code style and variable names are the same used in `cpp-lln-lab/CPP_PTB`
    %  github repo, therefore it should be easy to move everything in your experiment
    %  scripts (see the template that is annexed in `cpp-lln-lab/CPP_PTB`)

    % Init the structure that will contain PTB setup
    cfg = struct;

    % Set some colors to be choosen as background
    cfg.white = [255 255 255];
    cfg.black = [0   0   0];
    cfg.grey  = mean([cfg.black; cfg.white]);

    % Set the PTB window background manually
    cfg.backgroundColor = cfg.grey;

    % Init PTB, see the Sub-Functions below
    cfg = devSandbox_initPTB(cfg);

    %%
    % -------------------------------------------------------------------------
    % -------------------------- SET YOUR VARS HERE ---------------------------
    % -------------------------------------------------------------------------

    % Define black and white
    white = WhiteIndex(cfg.screen);
    grey = white / 2;
    inc = white - grey;

    % Grating size in pixels
    gratingSizePix = 600;

    % Grating frequency in cycles / pixel
    freqCyclesPerPix = 0.01;

    % Drift speed cycles per second
    cyclesPerSecond = 1;

    % Contrast for our contrast modulation mask: 0 = mask has no effect, 1 = mask
    % will at its strongest part be completely opaque frameCounter.e. 0 and 100% contrast
    % respectively
    contrast = 0.8;

    % We set PTB to wait one frame before re-drawing
    waitframes = 1;

    % -------------------------------------------------------------------------
    %%

    % Catch the error and restore your computer for debugging
    try

        %%
        % -------------------------------------------------------------------------
        % ------------------------------ PLAYGROUND -------------------------------
        % -------------------------------------------------------------------------
        % Define Half-Size of the grating image.
        textureSize = gratingSizePix / 2;

        % First we compute pixels per cycle rounded to the nearest pixel
        pixPerCycle = ceil(1 / freqCyclesPerPix);

        % Frequency in Radians
        freqRad = freqCyclesPerPix * 2 * pi;

        % This is the visible size of the grating
        visibleSize = 2 * textureSize + 1;

        % Define our grating. Note it is only 1 pixel high. PTB will make it a full
        % grating upon drawing
        x = meshgrid(-textureSize:textureSize + pixPerCycle, 1);
        grating = grey * cos(freqRad * x) + inc;

        % Make a two layer mask filled with the background colour
        mask = ones(1, numel(x), 2) * grey;

        % Place the grating in the 'alpha' channel of the mask
        mask(:, :, 2) = grating .* contrast;

        % Make our grating mask texture
        gratingMaskTex = Screen('MakeTexture', cfg.win, mask);

        % Make a black and white noise mask half the size of our grating. This will
        % be scaled upon drawing to make a "chunky" noise texture which our grating
        % will mask. Note the round function in here. For this demo we are simply
        % rounding the size to the nearest pixel, leaving PTB to do some scaling.
        noise = rand(round(visibleSize / 2)) .* white;

        % Make our noise texture
        noiseTexture = Screen('MakeTexture', cfg.win, noise);

        % Make a destination rectangle for our textures and center this on the
        % screen
        dstRect = [0 0 visibleSize visibleSize];
        dstRect = CenterRect(dstRect, cfg.winRect);

        % Calculate the wait duration
        waitDuration = waitframes * cfg.ifi;

        % Recompute pixPerCycle, this time without the ceil() operation from above.
        % Otherwise we will get wrong drift speed due to rounding errors
        pixPerCycle = 1 / freqCyclesPerPix;

        % Translate requested speed of the grating (in cycles per second) into
        % a shift value in "pixels per frame"
        shiftPerFrame = cyclesPerSecond * pixPerCycle * waitDuration;

        % Sync us to the vertical retrace
        vbl = Screen('Flip', cfg.win);

        % Set the frame counter to zero, we need this to 'drift' our grating
        frameCounter = 0;

        % Loop until a key is pressed
        while ~KbCheck

            % Calculate the xoffset for our window through which to sample our
            % grating
            xoffset = mod(frameCounter * shiftPerFrame, pixPerCycle);

            % Now increment the frame counter for the next loop
            frameCounter = frameCounter + 1;

            % Define our source rectangle for grating sampling
            srcRect = [xoffset 0 xoffset + visibleSize visibleSize];

            % Draw noise texture to the screen
            Screen('DrawTexture', cfg.win, noiseTexture, [], dstRect, []);

            % Draw grating mask
            Screen('DrawTexture', cfg.win, gratingMaskTex, srcRect, dstRect, []);

            % Flip to the screen on the next vertical retrace
            vbl = Screen('Flip', cfg.win, vbl + (waitframes - 0.5) * cfg.ifi);

        end

        % -------------------------------------------------------------------------
        %%

        % Close PTB, see the Sub-Functions below
        devSandbox_cleanUp;

    catch

        devSandbox_cleanUp;
        psychrethrow(psychlasterror);

    end

end

%% Sub-Functions
function cfg = devSandbox_initPTB(cfg)

    % Shorter version of `initPTB.m`

    % Skip the PTB sync test
    Screen('Preference', 'SkipSyncTests', 2);

    % Open a transparent window
    PsychDebugWindowConfiguration;

    % Here we call some default settings for setting up Psychtoolbox
    PsychDefaultSetup(2);

    % Get the screen numbers and draw to the external screen if avaliable
    cfg.screen = max(Screen('Screens'));

    % Open an on screen window
    [cfg.win, cfg.winRect] = Screen('OpenWindow', cfg.screen, cfg.backgroundColor);

    % Get the size of the on screen window
    [cfg.winWidth, cfg.winHeight] = WindowSize(cfg.win);

    % Query the frame duration
    cfg.ifi = Screen('GetFlipInterval', cfg.win);

    % Get the Center of the Screen
    cfg.center = [cfg.winRect(3), cfg.winRect(4)] / 2;

    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', cfg.win, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

end

function devSandbox_cleanUp

    % A wrapper function to close all windows, ports, show mouse cursor, close keyboard queues
    % and give access back to the keyboards.

    WaitSecs(0.5);

    Priority(0);

    ListenChar(0);
    KbQueueRelease();

    ShowCursor;

    % Screen Close All
    sca;

    % Close Psychportaudio if open
    if PsychPortAudio('GetOpenDeviceCount') ~= 0
        PsychPortAudio('Close');
    end

    if ~ismac
        % remove PsychDebugWindowConfiguration
        clear Screen;
    end

    close all;

end
