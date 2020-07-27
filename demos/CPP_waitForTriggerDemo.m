cd ..;

cfg.testingDevice = 'mri';

cfg.numTriggers = 4;

cfg.triggerKey = 'space';

KbName('UnifyKeyNames');

waitForTrigger(cfg);
