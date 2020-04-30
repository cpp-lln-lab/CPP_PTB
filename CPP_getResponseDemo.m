  jk%% Demo showing how to use the getResponse function

% This small script shows how to use the getReponse function 
%  (a wrapper around the KbQueue function from PTB)

% start with a clean slate
clear; clc; 
if IsOctave
    more off % for a better display experience
end

%% set parameters

% cfg.responseBox would be the device number of the device used by the participant to give his/her 
% response: like the button box in the scanner or a separate keyboard for a behavioral experiment
%
% cfg.keyboard would be the device number of the keyboard on which the experimenter will type or 
% press the keys necessary to start or abort the experiment.

%  cfg.responseBox and cfg.keyboard can be different or the same.

% If you want to know the device number of all the keyboards and responses
% boxes connected to the computer you can use the following code.
% [cfg.keyboardNumbers, cfg.keyboardNames] = GetKeyboardIndices

% Using empty vectors should work for linux when to select the "main"
%  keyboard. You might have to try some other values for Windows. To
%  assigne a specific keyboard input the kb assigned value (see README)
cfg.keyboard = [];
cfg.responseBox = [];

% We set which keys are "valid", any keys other than those will be ignored
expParameters.responseKey = {};


%% init

% Keyboard
%  Make sure keyboard mapping is the same on all supported operating systems
%  Apple MacOS/X, MS-Windows and GNU/Linux:
KbName('UnifyKeyNames');


% we ask PTB to tell us which keyboard devices are connected to the computer
[cfg.keyboardNumbers, cfg.keyboardNames] = GetKeyboardIndices;

cfg.keyboardNumbers
cfg.keyboardNames


% Test that the keyboards are correctly configured
testKeyboards(cfg);

% Give the time to the test key to be released and not listened
WaitSecs(1);


fprintf('\nDuring the next 5 seconds we will collect responses on the following keys: \n\n');
if isempty(expParameters.responseKey)
    fprintf('\nALL KEYS\n\n');    
else
    for iKey=1:numel(expParameters.responseKey)
        fprintf('\n%s', expParameters.responseKey{iKey});  
    end
    fprintf('\n\n');
end



%% Run demo

% Create the keyboard queue to collect responses.
getResponse('init', cfg, expParameters, 1);

% Start collecting responses for 5 seconds
%  Each new key press is added to the queue of events recorded by KbQueue
startSecs = GetSecs();
getResponse('start', cfg, expParameters, 1);



% Here we wait for 5 seconds but are still collecting responses.
%  So you could still be doing something else (presenting audio and visual stim) and
%  still collect responses.
WaitSecs(5);



% Check what keys were pressed (all of them)
responseEvents = getResponse('check', cfg, expParameters, 0, 1);

% The following line would only return key presses and not releases
% responseEvents = getResponse('check', cfg, expParameters, 1 , 1);

% This can be used to flush the queue: empty all events that are still present in the queue
getResponse('flush', cfg, expParameters, 1);

% If you wan to stop listening to key presses.
getResponse('stop', cfg, expParameters, 1);




%% Now we look what keys were pressed and when
for iEvent = 1:size(responseEvents, 1)

    if responseEvents(iEvent).pressed
        eventType = 'pressed';
    else
        eventType = 'released';
    end

    fprintf('%s was %s at time %.3f seconds\n', ...
        responseEvents(iEvent).key_name, ...
        eventType, ...
        responseEvents(iEvent).onset - startSecs);

end
