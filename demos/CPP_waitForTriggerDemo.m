addpath(genpath(fullfile(pwd, '..', 'src')));

%%
cfg.testingDevice = 'mri';

cfg.mri.triggerNb = 2;

cfg.mri.triggerKey = 'space';

KbName('UnifyKeyNames');

%%
% waitForTrigger(cfg);

%%
quietMode = true;
% waitForTrigger(cfg, [], quietMode);

%%
nbTriggersToWait = 1;
waitForTrigger(cfg, [], quietMode, nbTriggersToWait);
