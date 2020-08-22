addpath(fullfile(pwd, '..'));

clear;
clc;

if IsOctave
    more off; % for a better display experience
end

cfg = setDefaultsPTB;

%% Set parameters

% Decide which device you want to collect responses from
deviceNumber = []; % default device (PTB will find it for you)

cfg.keyboard.responseKey = {'a', 'b'};
cfg.keyboard.responseKey{end + 1} = cfg.keyboard.escapeKey;

%% Final checks

getOnlyPress = 1;

% Make sure keyboard mapping is the same on all supported operating systems
KbName('UnifyKeyNames');

fprintf('\nDuring the next 5 seconds we will collect responses on the following keys: \n\n');
if isempty(cfg.keyboard.responseKey)
    fprintf('\nALL KEYS\n\n');
else
    for iKey = 1:numel(cfg.keyboard.responseKey)
        fprintf('\n%s', cfg.keyboard.responseKey{iKey});
    end
    fprintf('\n\n');
end

%% Run manual test
try

    getResponse('init', deviceNumber, cfg);

    getResponse('start', deviceNumber);

    WaitSecs(5);

    responseEvents = getResponse('check', deviceNumber, cfg, getOnlyPress);

    getResponse('release', deviceNumber);

    % if some keys were pressed and that we are supposed to listen to only some
    % keys, we make sure that only those keys were listened to

    if ~isempty(cfg.keyboard.responseKey) && isfield(responseEvents, 'keyName')

        for iEvent = 1:size(responseEvents, 1)
            fprintf(' %s was pressed\n ', ...
                responseEvents(iEvent).keyName);

            if ~any(strcmp({responseEvents(iEvent).keyName}, cfg.keyboard.responseKey))
                errorRestrictedKeysGetReponse();
            end
        end

    end

catch ME

    switch ME.identifier
        case 'getResponse:restrictedKey'
            rethrow(ME);

        otherwise
            getResponse('release', deviceNumber);

            rethrow(ME);
    end

end
