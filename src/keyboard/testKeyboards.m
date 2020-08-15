function testKeyboards(cfg)
    % testKeyboards(cfg)
    %
    % Checks that the keyboards asked for properly connected.
    % If no key is pressed on the correct keyboard after the timeOut time this exits with an error.

    timeOut = 5;

    % Main keyboard used by the experimenter to quit the experiment if it is necessary
    % cfg.keyboard
    fprintf('\n This is a test: press any key on the main keyboard\n');
    t = GetSecs;
    [~, keyCode, ~] = KbPressWait(cfg.keyboard.keyboard, t + timeOut);
    throwError(keyCode, cfg.keyboard.keyboard, 1);

    if ~isequal(cfg.keyboard.keyboard, cfg.keyboard.responseBox)

        % For key presses for the subject
        % cfg.keyboard.responseBox
        fprintf('\n Thiscfg.keyboard is a test: press any key on the participant response box\n');
        t = GetSecs;
        [~, keyCode, ~] = KbPressWait(cfg.keyboard.responseBox, t + timeOut);
        throwError(keyCode, cfg.keyboard.responseBox, 2);

    end

end

function throwError(keyCode, deviceNumber, keyboardType)

    switch keyboardType
        case 1
            keyboardType = 'main keyboard';
        case 2
            keyboardType = 'response box';
    end

    text1 = ['\nYou asked for this keyboard device number to be used as ' keyboardType '.\n\n'];

    text2 = '\nThese are the devices currently connected.\n\n';

    errorText = 'No key was pressed. Did you configure the keyboards properly? See above for info.';

    if all(keyCode == 0)

        % Give me my keyboard back... Pretty please.
        ListenChar();

        fprintf(text1);

        if isempty(deviceNumber)
            disp('No keyboard selected, default is the main keyboard');
        else
            disp(deviceNumber);
        end

        fprintf(text2);

        [keyboardNumbers, keyboardNames] = GetKeyboardIndices;  %#ok<*NOPRT,*ASGLU>

        error(errorText);

    end

end
