function value = cppPtbDefaults(type)
    %
    % USAGE::
    %
    %   value = cppPtbDefaults(type)
    %
    % (C) Copyright 2022 CPP_PTB developers

    value = [];

    switch lower(type)

        case 'all'
            value =  struct('testingDevice', 'pc', ...
                            'color',  struct('background', [0 0 0]), ...
                            'skipSyncTests', 0);

            value.aperture.type = 'none';

            value.debug = cppPtbDefaults('debug');
            value.text = cppPtbDefaults('text');
            value.screen = cppPtbDefaults('screen');
            value.fixation = cppPtbDefaults('fixation');
            value.keyboard = cppPtbDefaults('keyboard');

        case 'debug'
            value.do = true;
            value.transpWin = true;
            value.smallWin = true;

        case 'keyboard'
            value.keyboard = [];
            value.responseBox = [];
            value.responseKey = {};
            value.escapeKey = 'ESCAPE';

        case 'text'
            value.font = 'Courier New';
            value.size = 18;
            value.style = 1;

        case 'fixation'
            value.type = 'cross';
            value.xDisplacement = 0;
            value.yDisplacement = 0;
            value.color = [255 255 255];
            value.width = 1;
            value.lineWidthPix = 5;

        case 'screen'
            value.monitorWidth = 42;
            value.monitorDistance = 134;
            value.resolution = {[], [], []};

        case 'audio'
            value.devIdx = [];
            value.playbackMode = 1;

            value.fs = 44100;
            value.channels = 2;
            value.initVolume = 1;
            value.requestedLatency = 3;

            value.repeat = 1;

            % Start immediately (0 = immediately)
            value.startCue = 0;

            % Should we wait for the device to really start?
            value.waitForDevice = 1;

            value.pushSize  = value.fs * 0.010; % ! push N ms only

            value.requestOffsetTime = 1; % offset 1 sec
            value.reqsSampleOffset = value.requestOffsetTime * value.fs;

        case 'eyetracker'
            value.defaultCalibration = true;
            value.backgroundColor = [192 192 192];
            value.fontColor = [0 0 0];
            value.calibrationTargetColor = [0 0 0];
            value.calibrationTargetSize = 1;
            value.calibrationTargetWidth = 0.5;
            value.displayCalResults = 1;

    end

end
