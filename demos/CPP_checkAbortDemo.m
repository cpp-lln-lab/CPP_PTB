% (C) Copyright 2020 CPP_PTB developers

% add parent directory to the path (to make sure we can access the CPP_PTB
% functions)
addpath(fullfile(pwd, '..'));

% set up
cfg.keyboard.escapeKey = 'ESCAPE';

% beginning of demo
KbName('UnifyKeyNames');

try

    % stay in the loop until the escape key is pressed
    while GetSecs < Inf

        checkAbort(cfg);

    end

catch ME

    switch ME.identifier
        case 'checkAbort:abortRequested'
            warning('You pressed the escape key: will try to fail gracefully.');
            fprintf('\nWe did catch your abort signal.\n');
        otherwise
            rethrow(ME); % display other errors
    end

end
