% (C) Copyright 2020 CPP_PTB developers

function cfg = setDefaultsPTB(cfg)
    % cfg = setDefaultsPTB(cfg)
    %
    % Set some defaults values if none have been set before.

    if nargin < 1
        cfg = struct;
    end

    %% list the default values
    fieldsToSet.testingDevice = 'pc';

    fieldsToSet.skipSyncTests = 0;

    % keyboard defaults
    fieldsToSet.keyboard.keyboard = [];
    fieldsToSet.keyboard.responseBox = [];
    fieldsToSet.keyboard.responseKey = {};
    fieldsToSet.keyboard.escapeKey = 'ESCAPE';

    fieldsToSet.debug.do = true;
    fieldsToSet.debug.transpWin = true;
    fieldsToSet.debug.smallWin = true;

    fieldsToSet.color.background = [0 0 0];

    % text defaults
    fieldsToSet.text.font = 'Courier New';
    fieldsToSet.text.size = 18;
    fieldsToSet.text.style = 1;

    fieldsToSet.screen.monitorWidth = 42;
    fieldsToSet.screen.monitorDistance = 134;
    fieldsToSet.screen.resolution = {[], [], []};

    % fixation cross or dot
    fieldsToSet.fixation.type = 'cross';
    fieldsToSet.fixation.xDisplacement = 0;
    fieldsToSet.fixation.yDisplacement = 0;
    fieldsToSet.fixation.color = [255 255 255];
    fieldsToSet.fixation.width = 1; % degrees of visual angle
    fieldsToSet.fixation.lineWidthPix = 5;

    % define visual apperture field
    fieldsToSet.aperture.type = 'none';

    if isfield(cfg, 'audio') && cfg.audio.do

        fieldsToSet.audio.devIdx = [];
        fieldsToSet.audio.playbackMode = 1;

        fieldsToSet.audio.fs = 44800;
        fieldsToSet.audio.channels = 2;
        fieldsToSet.audio.initVolume = 1;
        fieldsToSet.audio.requestedLatency = 3;

        % playing parameters
        % sound repetition
        fieldsToSet.audio.repeat = 1;

        % Start immediately (0 = immediately)
        fieldsToSet.audio.startCue = 0;

        % Should we wait for the device to really start?
        fieldsToSet.audio.waitForDevice = 1;

    end

    if isfield(cfg, 'eyeTracker') && cfg.eyeTracker.do

        % Calibration environment
        fieldsToSet.eyeTracker.defaultCalibration = true;
        fieldsToSet.eyeTracker.backgroundColor = [192 192 192];
        fieldsToSet.eyeTracker.fontColor = [0 0 0];
        fieldsToSet.eyeTracker.calibrationTargetColor = [0 0 0];
        fieldsToSet.eyeTracker.calibrationTargetSize = 1;
        fieldsToSet.eyeTracker.calibrationTargetWidth = 0.5;
        fieldsToSet.eyeTracker.displayCalResults = 1;

    end

    if isfield(cfg, 'testingDevice') && strcmpi(cfg.testingDevice, 'mri')
        fieldsToSet.bids.mri.RepetitionTime = [];
        fieldsToSet.pacedByTriggers.do = false;
    end

    cfg = setDefaults(cfg, fieldsToSet);

    % sort fields alphabetically
    cfg = orderfields(cfg);

end
