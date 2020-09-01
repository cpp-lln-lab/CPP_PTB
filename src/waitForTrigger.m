function waitForTrigger(varargin)
    % waitForTrigger(cfg, deviceNumber, quietMode, nbTriggersToWait)
    %
    % Counts a certain number of triggers coming from the scanner before returning.
    %
    % If you are not using the quietMode, it flips and waits for half a TR before starting to
    % check for the next trigger (unless this was the last trigger to wait for and in
    % this case it returns immediately).
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
    %
    % INPUTS
    %  - varargin{1} = cfg
    %
    % - varargin{2} = deviceNumber
    %
    % - varargin{3} = quietMode: a boolean to make sure nothing is printed on the screen or
    % the prompt
    %
    % - nbTriggersToWait

    [cfg, nbTriggersToWait, deviceNumber, quietMode] = checkInputs(varargin);

    triggerCounter = 0;

    if strcmpi(cfg.testingDevice, 'mri')

        msg = ['Experiment starting in ', ...
            num2str(nbTriggersToWait - triggerCounter), '...'];

        talkToMe(cfg, msg, quietMode);

        while triggerCounter < nbTriggersToWait

            keyCode = []; %#ok<NASGU>

            [~, keyCode] = KbPressWait(deviceNumber);

            if strcmp(KbName(keyCode), cfg.mri.triggerKey)

                triggerCounter = triggerCounter + 1;

                msg = sprintf(' Trigger %i', triggerCounter);

                talkToMe(cfg, msg, quietMode);

                % we only wait if this is not the last trigger
                if triggerCounter < nbTriggersToWait
                    pauseBetweenTriggers(cfg);
                end

            end
        end
    end
end

function [cfg, nbTriggersToWait, deviceNumber, quietMode] = checkInputs(varargin)

    varargin = varargin{1};

    if numel(varargin) < 1 || isempty(varargin{1}) || ~isstruct(varargin{1})
        error('First input must be a cfg structure.');
    elseif isstruct(varargin{1})
        cfg = varargin{1};
    end

    if numel(varargin) < 3 || isempty(varargin{3})
        quietMode = false;
    else
        quietMode = varargin{3};
    end

    if numel(varargin) < 2 || isempty(varargin{2})
        deviceNumber = -1;
        if ~quietMode
            fprintf('Will wait for triggers on the main keyboard device.\n');
        end
    else
        deviceNumber = varargin{2};
    end

    if numel(varargin) < 4 || isempty(varargin{4})
        nbTriggersToWait = cfg.mri.triggerNb;
    else
        nbTriggersToWait = varargin{4};
    end

end

function talkToMe(cfg, msg, quietMode)

    if ~quietMode

        fprintf([msg, ' \n']);

        if isfield(cfg, 'screen') && isfield(cfg.screen, 'win')

            DrawFormattedText(cfg.screen.win, msg, ...
                'center', 'center', cfg.text.color);

            Screen('Flip', cfg.screen.win);

        end

    end

end

function pauseBetweenTriggers(cfg)
    % we pause between triggers otherwise KbWait and KbPressWait might be too fast and could
    % catch several triggers in one go.

    waitTime = 0.5;
    if isfield(cfg, 'mri') && isfield(cfg.mri, 'repetitionTime') && ~isempty(cfg.mri.repetitionTime)
        waitTime = cfg.mri.repetitionTime / 2;
    end

    WaitSecs(waitTime);

end

% function [MyPort] = WaitForScanTrigger(Parameters)
%
%     %% Opening IOPort
%     PortSettings = sprintf('BaudRate=115200 InputBufferSize=10000 ReceiveTimeout=60');
%     PortSpec = FindSerialPort([], 1);
%
%     % Open port portSpec with portSettings, return handle:
%     MyPort = IOPort('OpenSerialPort', PortSpec, PortSettings);
%
%     % Start asynchronous background data collection and timestamping. Use
%     % blocking mode for reading data -- easier on the system:
%     AsyncSetup = sprintf('BlockingBackgroundRead=1 ReadFilterFlags=0 StartBackgroundRead=1');
%     IOPort('ConfigureSerialPort', MyPort, AsyncSetup);
%
%     % Read once to warm up
%     WaitSecs(1);
%     IOPort('Read', MyPort);
%
%     nTrig = 0;
%
%     %% waiting for dummie triggers from the scanner
%     while nTrig <= Parameters.Dummies
%
%         [PktData, TReceived] = IOPort('Read', MyPort);
%
%         % it is checked if something was received via trigger_port
%         % oldtrigger is there so 'number' is only updated when something new is
%         % received via trigger_port (normally you receive a "small series" of data at
%         % a time)
%         if isempty(PktData)
%             TReceived = 0;
%         end
%
%         if TReceived && (oldtrigger == 0)
%             Number = 1;
%         else
%             Number = 0;
%         end
%
%         oldtrigger = TReceived;
%
%         if Number
%             nTrig = nTrig + 1;
%             Number = 0; %#ok<NASGU>
%         end
%
%     end
%
% end
%
