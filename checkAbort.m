function checkAbort(cfg, deviceNumber)
    % checkAbort(cfg, deviceNumber)
    %
    % Check for experiment abortion from operator
    % When no deviceNumber is set then it will check the default device
    % When an abort key s detected this will set a global variable and throw a
    % specific error that can then be catched.
    %
    % Maint script
    % try
    %     % Your awesome experiment
    % catch ME % when something goes wrong
    %     switch ME.identifier
    %         case 'checkAbort:abortRequested'
    %             % stuff to do when an abort is requested (save data...)
    %         otherwise
    %             % stuff to do otherwise
    %             rethrow(ME) % display the error
    %     end
    % end

    if nargin < 1 || isempty(cfg)
        error('I need at least one input.');
    end

    if nargin < 2 || isempty(deviceNumber)
        deviceNumber = -1;
    end

    [keyIsDown, ~, keyCode] = KbCheck(deviceNumber);

    if keyIsDown && keyCode(KbName(cfg.keyboard.escapeKey))

        errorAbort();

    end

end
