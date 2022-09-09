function listAudioDevices()
    %
    % USAGE: listAudioDevices()
    %
    % See Also: testAudioDevices
    %
    %
    % (C) Copyright 2022 Remi Gau

    fprintf(1, '\n%s', repmat('-', 1, 100));

    fprintf(1, '\n  Available audio devices  \n');

    audioDev = PsychPortAudio('GetDevices');

    DeviceNames = char({audioDev.DeviceName}');

    fprintf(1, '\nDeviceName%s\t\tDeviceIndex\t\tDefaultSampleRate', ...
            repmat(' ', 1, size(DeviceNames, 2) - length('nDeviceName')));

    fprintf(1, '\n');

    for i = 1:length(audioDev)
        fprintf(1, '\n%s\t\t%i\t\t\t%i', ...
                DeviceNames(i, :), ...
                audioDev(i).DeviceIndex, ...
                audioDev(i).DefaultSampleRate);
    end

    fprintf(1, '\n%s', repmat('-', 1, 100));
    fprintf(1, '\n');
end
