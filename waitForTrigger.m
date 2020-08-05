function waitForTrigger(cfg, deviceNumber)
    % waitForTrigger(cfg, deviceNumber)
    %
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

        msg = ['Experiment starting in ', ...
            num2str(cfg.mri.triggerNb - triggerCounter), '...'];
        talkToMe(cfg, msg);

        while triggerCounter < cfg.mri.triggerNb

            keyCode = []; %#ok<NASGU>

            [~, keyCode] = KbPressWait(deviceNumber);

            if strcmp(KbName(keyCode), cfg.mri.triggerKey)

                triggerCounter = triggerCounter + 1 ;

                msg = sprintf(' Trigger %i', triggerCounter);
                talkToMe(cfg, msg);

                % we only wait if this is not the last trigger
                if triggerCounter < cfg.mri.triggerNb
                    pauseBetweenTriggers(cfg);
                end

            end
        end
    end
end

function talkToMe(cfg, msg)

    fprintf([msg, ' \n']);

    if isfield(cfg, 'screen') && isfield(cfg.screen, 'win')

        DrawFormattedText(cfg.screen.win, msg, ...
            'center', 'center', cfg.text.color);

        Screen('Flip', cfg.screen.win);

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
