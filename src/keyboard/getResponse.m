function responseEvents = getResponse(action, deviceNumber, cfg, getOnlyPress)
    % responseEvents = getResponse(action, deviceNumber, cfg, getOnlyPress)
    %
    % Wrapper function to use KbQueue
    %
    % The queue will be listening to key presses on a keyboard device:
    % cfg.keyboard.responseBox or cfg.keyboard.keyboard are 2 main examples.
    %
    % When no deviceNumber is set then it will listen to the default device.
    %
    % Check the CPP_getResponseDemo for a quick script on how to use it.
    %
    %
    % INPUT
    %
    % - action: Defines what we want the function to do
    %  - init: to initialise the queue
    %  - start: to start listening to keypresses
    %  - check: checks all the key presses events since 'start', or since last
    %    'check' or 'flush' (whichever was the most recent)
    %    -- can check for demand to abort if the escapeKey is listed in the
    %       Keys of interest.
    %    -- can only check for demands to abort when getResponse('check') is called:
    %       so there will be a delay between the key press and the experiment stopping
    %    -- abort errors send specific signals that allow the catch to get
    %       them and allows us to "close" nicely
    %  - flush: empties the queue of events in case you want to restart from a clean
    %    queue
    %  - stop: stops listening to key presses
    %
    % - getOnlyPress: if set to true the function will only return the key presses and
    %    will not return when the keys were released (default=true)
    %    See the section on OUTPUT below for more info
    %
    %
    %
    % OUTPUT
    %
    % responseEvents: returns all the keypresses and return them as a structure
    % with field names that make it easier to save the output of in a BIDS
    % format
    %
    % responseEvents.onset : this is an absolute value and you should
    %   substract the "experiment start time" to get a value relative to when the
    %   experiment was started.
    %
    % responseEvents.trial_type = 'response';
    %
    % responseEvents.duration = 0;
    %
    % responseEvents.keyName : the name of the key pressed
    %
    % responseEvents(iEvent,1).pressed : if
    %   pressed == 1  --> the key was pressed
    %   pressed == 0  --> the key was released

    if nargin < 2 || isempty(deviceNumber)
        deviceNumber = -1;
    end

    if nargin < 3
        cfg = struct( ...
            'keyboard', struct('responseKey', {}) ...
            );
    end

    if nargin < 4
        getOnlyPress = true;
    end

    responseEvents = struct;

    switch action

        case 'init'

            % Prevent spilling of keystrokes into console.
            % If you use ListenChar(2), this will prevent you from using KbQueue.
            ListenChar(-1);

            % Clean and realease any queue that might be opened
            KbQueueRelease(deviceNumber);

            keysOfInterest = setKeysOfInterest(cfg.keyboard);

            % Create the keyboard queue to collect responses.
            KbQueueCreate(deviceNumber, keysOfInterest);

        case 'start'
            KbQueueStart(deviceNumber);

        case 'check'
            responseEvents = getAllKeyEvents(responseEvents, deviceNumber, getOnlyPress);

            checkAbortGetResponse(responseEvents, cfg);

        case 'flush'
            KbQueueFlush(deviceNumber);

        case 'stop'
            KbQueueStop(deviceNumber);

        case 'release'
            KbQueueRelease(deviceNumber);

            % Give me my keyboard back... Pretty please.
            ListenChar(0);

    end

    talkToMe(action, cfg);

end

function keysOfInterest = setKeysOfInterest(keyboard)
    % list all the response keys we want KbQueue to listen to
    % by default we listen to all keys
    % but if responseKey is set in the parameters we override this

    keysOfInterest = zeros(1, 256);

    fprintf('\n Will be listening for key presses on : ');

    if ~isempty(keyboard.responseKey)

        responseTargetKeys = nan(1, numel(keyboard.responseKey));

        for iKey = 1:numel(keyboard.responseKey)
            fprintf('\n - %s ', keyboard.responseKey{iKey});
            responseTargetKeys(iKey) = KbName(keyboard.responseKey(iKey));
        end

        keysOfInterest(responseTargetKeys) = 1;

    else

        keysOfInterest = ones(1, 256);

        fprintf('ALL KEYS.');

    end

    fprintf('\n\n');
end

function responseEvents = getAllKeyEvents(responseEvents, deviceNumber, getOnlyPress)

    iEvent = 1;

    while KbEventAvail(deviceNumber)

        event = KbEventGet(deviceNumber);

        % we only return the pressed keys by default
        if getOnlyPress == true && event.Pressed == 0
        else

            responseEvents(iEvent, 1).onset = event.Time;
            responseEvents(iEvent, 1).trial_type = 'response';
            responseEvents(iEvent, 1).duration = 0;
            responseEvents(iEvent, 1).keyName = KbName(event.Keycode);
            responseEvents(iEvent, 1).pressed =  event.Pressed;

            iEvent = iEvent + 1;

        end

    end

end

function talkToMe(action, cfg)

    verbose = false;
    if isfield(cfg, 'verbose')
        verbose = cfg.verbose;
    end

    switch action

        case 'init'
            msg = 'Initialising KbQueue.';

        case 'start'
            msg = 'Starting to listen to keypresses.';

        case 'check'
            msg = 'Checking recent keypresses.';

        case 'flush'
            msg = 'Reinitialising keyboard queue.';

        case 'stop'
            msg = 'Stopping to listen to keypresses.';

        case 'release'
            msg = 'Releasing KbQueue.';

        otherwise
            msg = '';

    end

    if verbose
        fprintf('\n %s\n\n', msg);

    end

end
