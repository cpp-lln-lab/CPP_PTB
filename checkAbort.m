function checkAbort(cfg)
% Check for experiment abortion from operator

[keyIsDown, ~, keyCode] = KbCheck(cfg.keyboard);

if keyIsDown && keyCode(KbName(cfg.escapeKey))
    
    global stopEverything
    stopEverything = true;
    
    cleanUp();
    
    error('Escape key press detected: aborting experiment.')
    
end

end