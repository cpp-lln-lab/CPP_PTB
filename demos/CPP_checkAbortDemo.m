% add parent directory to the path (to make sure we can access the CPP_PTB
% functions)
addpath(fullfile(pwd, '..')) 

cfg.keyboard = [];
cfg.escapeKey = 'ESCAPE';
KbName('UnifyKeyNames');

% stay in the loop until the escape key is pressed
while GetSecs < Inf
    
    checkAbort(cfg)
    
end