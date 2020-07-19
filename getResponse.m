function responseEvents = getResponse(action, cfg, expParameters, getOnlyPress)
% wrapper function to use KbQueue
% The queue will be listening to key presses on the response box as defined
%  in the cfg structure : see setParameters for more details.
%
% Check the CPP_getResponseDemo for a quick script on how to use it.
%
%
%
% INPUT
%
% - action: Defines what we want the function to do
%  - init: to initialise the queue
%  - start: to start listening to keypresses
%  - check:
%  - flush:
%  - stop:
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
% responseEvents.key_name : the name of the key pressed
%
% responseEvents(iEvent,1).pressed : if
%   pressed == 1  --> the key was pressed
%   pressed == 0  --> the key was released


if nargin < 4
    getOnlyPress = true;
end

responseEvents = struct;

responseBox = cfg.responseBox;

switch action
    
    case 'init'
        
        % Prevent spilling of keystrokes into console. 
        % If you use ListenChar(2), this will prevent you from using KbQueue.
        ListenChar(-1);
        
        % Clean and realease any queue that might be opened
        KbQueueRelease(responseBox);
        
        keysOfInterest = setKeysOfInterest(expParameters);
        
        % Create the keyboard queue to collect responses.
        KbQueueCreate(responseBox, keysOfInterest);
        
        
    case 'start'
        
        KbQueueStart(responseBox);
        
        
    case 'check'
        
        responseEvents = getAllKeyEvents(responseEvents, responseBox, getOnlyPress);
        
        checkAbort(cfg)
          
    case 'flush'
        
        KbQueueFlush(responseBox);
        
        
    case 'stop'
        
        KbQueueRelease(responseBox);
        
        % Give me my keyboard back... Pretty please.
        ListenChar(0);
        
        
end

talkToMe(action, expParameters);

end


function keysOfInterest = setKeysOfInterest(expParameters)
% list all the response keys we want KbQueue to listen to
% by default we listen to all keys
% but if responseKey is set in the parameters we override this

keysOfInterest = ones(1,256);

fprintf('\n Will be listening for key presses on : ')

if isfield(expParameters, 'responseKey') && ~isempty(expParameters.responseKey)

    responseTargetKeys = nan(1,numel(expParameters.responseKey));
    
    for iKey = 1:numel(expParameters.responseKey)
        fprintf('\n  - %s ', expParameters.responseKey{iKey})
        responseTargetKeys(iKey) = KbName(expParameters.responseKey(iKey));
    end
    
    keysOfInterest(responseTargetKeys) = 1;
    
else
    
    fprintf('ALL KEYS.')
    
end

fprintf('\n\n')
end


function responseEvents = getAllKeyEvents(responseEvents, responseBox, getOnlyPress)

iEvent = 1;

while KbEventAvail(responseBox)
    
    event = KbEventGet(responseBox);
    
    % we only return the pressed keys by default
    if getOnlyPress==true && event.Pressed==0
    else
        
        responseEvents(iEvent,1).onset = event.Time;
        responseEvents(iEvent,1).trial_type = 'response';
        responseEvents(iEvent,1).duration = 0;
        responseEvents(iEvent,1).key_name = KbName(event.Keycode);
        responseEvents(iEvent,1).pressed =  event.Pressed;
        
        iEvent = iEvent + 1;
        
    end
    
end

end


function talkToMe(action)


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

fprintf('\n %s\n\n', msg);

end