cd ..

cfg.keyboard = [];
cfg.escapeKey = 'ESCAPE';
KbName('UnifyKeyNames');

% stay in the loop until the escape key is pressed
while GetSecs < Inf
    
    checkAbort(cfg)
    
end