% (C) Copyright 2020 CPP_PTB developers

function pressSpaceForMe()
    %
    % Use that to stop your script and only restart when the space bar is pressed.
    % This can be useful if as an experimenter you want to have one final check on
    % some set up before giving the green light.
    %
    % USAGE::
    %
    %   pressSpaceForMe()
    %

    fprintf('\nPress space to continue.\n');

    while 1

        WaitSecs(0.1);

        [~, keyCode, ~] = KbWait(-1);

        if strcmp(KbName(find(keyCode)), 'space')
            fprintf('starting the experiment...\n');
            break
        end

    end
