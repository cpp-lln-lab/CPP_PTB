cd ..;

cfg.testingDevice = 'mri';

cfg.mri.triggerNb = 4;

cfg.mri.triggerKey = 'space';

KbName('UnifyKeyNames');

waitForTrigger(cfg);
