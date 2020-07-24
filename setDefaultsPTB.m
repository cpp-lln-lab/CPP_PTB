function cfg = setDefaultsPTB(cfg)

    if nargin < 1
        cfg = struct;
    end

    %% list the default values
    fieldsToSet.testingDevice = 'pc';

    % keyboard defaults
    fieldsToSet.keyboard.keyboard = [];
    fieldsToSet.keyboard.responseBox = [];
    fieldsToSet.keyboard.responseKey = {};
    fieldsToSet.keyboard.escapeKey = 'ESCAPE';

    fieldsToSet.debug = true;
    fieldsToSet.testingTranspScreen = true;
    fieldsToSet.testingSmallScreen = true;

    fieldsToSet.backgroundColor = [0 0 0];

    % text defaults
    fieldsToSet.text.font = 'Courier New';
    fieldsToSet.text.size = 18;
    fieldsToSet.text.style = 1;

    fieldsToSet.monitorWidth = 42;
    fieldsToSet.screenDistance = 134;

    if isfield(cfg, 'initAudio') && cfg.initAudio

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

    if isfield(cfg, 'testingDevice') && strcmpi(cfg.testingDevice, 'mri')
        fieldsToSet.MRI.repetitionTime = [];
    end

    cfg = setDefaults(cfg, fieldsToSet);

    % sort fields alphabetically
    cfg = orderfields(cfg);

end

function structure = setDefaults(structure, fieldsToSet)
    % loop through the defaults fiels to set and update if they don't exist

    names = fieldnames(fieldsToSet);

    for i = 1:numel(names)

        thisField = fieldsToSet.(names{i});
        structure = setFieldToIfNotPresent( ...
            structure, ...
            names{i}, ...
            thisField);

    end

end

function structure = setFieldToIfNotPresent(structure, fieldName, value)
    if ~isfield(structure, fieldName)
        structure.(fieldName) = value;
    end
end
