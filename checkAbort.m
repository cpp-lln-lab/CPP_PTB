function checkAbort(cfg)
% Check for experiment abortion from operator

[keyIsDown, ~, keyCode] = KbCheck(cfg.keyboard);

if keyIsDown && keyCode(KbName(cfg.escapeKey))
    
    global stopEverything
    stopEverything = true;
    
    cleanUp();
    
    warning('\nEscape key press detected: aborting experiment.\n')
    
end

end