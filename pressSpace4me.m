function pressSpace4me(deviceNumber)
% Use that to stop your script and only restart when the space bar is pressed.
% This is a good way to have a final checkpoint before starting and letting the
% user or the experimenter press the space bar to start.
% When no deviceNumber is set then it will check the default device
   
if nargin < 1 || isempty(deviceNumber)
    deviceNumber = -1;
end

fprintf('\nPress space to continue.\n');

while 1

    % check keyboard very 100 ms
    WaitSecs(0.1);

    [~, keyCode, ~] = KbWait(deviceNumber);
    if strcmp(KbName(find(keyCode)), 'space')
        fprintf('Starting the experiment...\n');
        break
    end

end

end
