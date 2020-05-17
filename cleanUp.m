function cleanUp

WaitSecs(0.5);

Priority(0);

ListenChar(0);
KbQueueRelease();

ShowCursor

% Screen Close All
sca;

% Close Psychportaudio if open 
if PsychPortAudio('GetOpenDeviceCount') ~= 0
	PsychPortAudio('Close');
end

if ~ismac
    % remove PsychDebugWindowConfiguration
    clear Screen
end

close all

 
end
