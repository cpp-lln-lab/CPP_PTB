function waitForTrigger(cfg, deviceNumber)
    % Counts a certain number of triggers coming from the scanner before returning.
    %
    % Will print the count down in the command line and on the PTB window if one is
    % opened.
    %
    % If the fMRI sequence RT is provided (cgf.MRI.repetitionTime) then it will wait
    % for half a RT before starting to check for next trigger, otherwise it will
    % wait 500 ms.
    %
    % When no deviceNumber is set then it will check the default device: this is
    % probably only useful in debug as you will want to make sure you get the
    % triggers coming from the scanner in a real case scenario.

    if nargin < 1 || isempty(cfg)
        error('I need at least one input.');
    end

    if nargin < 2 || isempty(deviceNumber)
        deviceNumber = -1;
        fprintf('Will wait for triggers on the main keyboard device.\n');
    end

    triggerCounter = 0;

    if strcmpi(cfg.testingDevice, 'mri')

        msg = 'Waiting for trigger';
        talkToMe(cfg, msg);

        while triggerCounter < cfg.numTriggers

            keyCode = []; %#ok<NASGU>

            [~, keyCode] = KbPressWait(deviceNumber);

            if strcmp(KbName(keyCode), cfg.triggerKey)

                triggerCounter = triggerCounter + 1 ;

                msg = sprintf(' Trigger %i', triggerCounter);
                talkToMe(cfg, msg);

                % we only wait if this is not the last trigger
                if triggerCounter < cfg.numTriggers
                    pauseBetweenTriggers(cfg);
                end

            end
        end
    end
end

function talkToMe(cfg, msg)

    fprintf([msg, ' \n']);

    if isfield(cfg, 'win')

        DrawFormattedText(cfg.win, msg, ...
            'center', 'center', cfg.textColor);

        Screen('Flip', cfg.win);

    end

end

function pauseBetweenTriggers(cfg)
    % we pause between triggers otherwise KbWait and KbPressWait might be too fast and could
    % catch several triggers in one go.

    waitTime = 0.5;
    if ~isempty(cfg.MRI.repetitionTime)
        waitTime = cfg.MRI.repetitionTime / 2;
    end

    WaitSecs(waitTime);

end
