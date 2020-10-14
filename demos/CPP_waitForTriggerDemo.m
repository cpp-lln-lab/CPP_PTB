% (C) Copyright 2020 CPP_PTB developers

% add parent/src directory to the path (to make sure we can access the CPP_PTB functions)
addpath(genpath(fullfile(pwd, '..', 'src')));

cfg.testingDevice = 'mri';

cfg.mri.triggerNb = 5;
cfg.mri.triggerKey = 't';

KbName('UnifyKeyNames');

quietMode = false;

fprintf(1, 'Press the letter %s %i times, please.\n', cfg.mri.triggerKey, cfg.mri.triggerNb); 

lastTriggerTimeStamp = waitForTrigger(cfg, [], quietMode, cfg.mri.triggerNb);

fprintf(1, 'Thank you. The time stamp of the last trigger was %f.\n', lastTriggerTimeStamp) 
