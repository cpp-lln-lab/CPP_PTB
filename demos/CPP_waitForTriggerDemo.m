cd ..;

cfg.device = 'mri';

cfg.numTriggers = 4;

cfg.triggerKey = 'space';

KbName('UnifyKeyNames');

waitForTrigger(cfg);
