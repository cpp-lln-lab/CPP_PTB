 %% Demo showing how to use the getResponse function

% This small script shows how to use the getReponse function

% add parent directory to matlab path (so we can access the CPP_PTB functions)
addpath(fullfile(pwd, '..'));

%% start with a clean slate
clear;
clc;

if IsOctave
    more off; % for a better display experience
end

% use the default set up (use main keyboard and use the ESCAPE key to abort)
cfg = setDefaultsPTB;

% show the default option
disp(cfg.keyboard);

%% set parameters

% Change the values set by defaults (for more info about the keyboard see the doc)
% cfg.keyboard.keyboard = ??
% cfg.keyboard.responseBox = ??
% cfg.keyboard.escapeKey = ??

% Decide which device you want to collect responses from
deviceNumber = []; % default device (PTB will find it for you)
% deviceNumber = cfg.keyboard.keyboard; % the one you may have chosen as the main keyboard
% deviceNumber = cfg.keyboard.responseBox; % the one you may have chosen as the response box

% if you want getResponse to ignore the key release
getOnlyPress = 1;

% We set which keys are "valid", any keys other than those will be ignored
cfg.keyboard.responseKey = {'a', 'b'};

% This would make sure that you listen to presses of the escape key
cfg.keyboard.responseKey{end + 1} = cfg.keyboard.escapeKey;

%% Final checks

% Make sure keyboard mapping is the same on all supported operating systems
KbName('UnifyKeyNames');

% Test that the keyboards are correctly configured
testKeyboards(cfg);

% Give the time to the test key to be released and not listened to
WaitSecs(1);

fprintf('\nDuring the next 5 seconds we will collect responses on the following keys: \n\n');
if isempty(cfg.keyboard.responseKey)
    fprintf('\nALL KEYS\n\n');
else
    for iKey = 1:numel(cfg.keyboard.responseKey)
        fprintf('\n%s', cfg.keyboard.responseKey{iKey});
    end
    fprintf('\n\n');
end

%% Run demo

try

    % Create the keyboard queue to collect responses.
    getResponse('init', deviceNumber, cfg);

    % Start collecting responses for 5 seconds
    %  Each new key press is added to the queue of events recorded by KbQueue
    startSecs = GetSecs();
    getResponse('start', deviceNumber);

    % Here we wait for 5 seconds but are still collecting responses.
    %  So you could still be doing something else (presenting audio and visual stim) and
    %  still collect responses.
    WaitSecs(5);

    % Check what keys were pressed (all of them)
    % If the escapeKey was pressed at any time, it will only abort when you
    % getResponse('check')
    responseEvents = getResponse('check', deviceNumber, cfg, getOnlyPress);

    % This can be used to flush the queue: empty all events that are still present in the queue
    getResponse('flush', deviceNumber);

    % If you wan to stop listening to key presses. You could start listening again
    % later by calling: getResponse('start', deviceNumber)
    getResponse('stop', deviceNumber);

    % If you wan to destroyt the queue: you would have to initialize it again
    getResponse('release', deviceNumber);

    %% Now we look what keys were pressed and when
    for iEvent = 1:size(responseEvents, 1)

        if responseEvents(iEvent).pressed
            eventType = 'pressed';
        else
            eventType = 'released';
        end

        fprintf('\n %s was %s at time %.3f seconds\n', ...
            responseEvents(iEvent).keyName, ...
            eventType, ...
            responseEvents(iEvent).onset - startSecs);

    end

catch ME

    getResponse('release', deviceNumber);

    switch ME.identifier

        case 'getResponse:abortRequested'
            warning('You pressed the escape key: will try to fail gracefully.');

            fprintf('\nWe did catch your abort signal.\n');

        otherwise
            rethrow(ME); % display other errors

    end
end
