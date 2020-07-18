function wait4Trigger(cfg)

triggerCounter = 0;

if strcmp(cfg.device, 'Scanner')
    
    msg = 'Waiting for trigger';
    talkToMe(cfg, msg)

    while triggerCounter < cfg.numTriggers
        
        keyCode = []; %#ok<NASGU>
        
        [~, keyCode] = KbPressWait(-1);
        
        if strcmp(KbName(keyCode), cfg.triggerKey)
            
            triggerCounter = triggerCounter + 1 ;
            
            msg = sprintf(' Trigger %i', triggerCounter);
            talkToMe(cfg, msg)
            
            pauseBetweenTriggers(cfg)
            
        end
    end
end
end


function talkToMe(cfg, msg)

fprintf([msg , ' \n']);

if isfield(cfg, 'win')
    
    DrawFormattedText(cfg.win, msg,...
        'center', 'center', cfg.textColor);
    
    Screen('Flip', cfg.win);
    
end

end


function pauseBetweenTriggers(cfg)
% we pause between triggers for half a repetition time or 500 ms if no RT
% is specified.
% we do this otherwise KbWait and KbPressWait might be too fast and could
% catch several triggers in one go.

if isfield(cfg, 'repetitionTime')
    waitTime = cgf.repetitionTime / 2;
else
    waitTime = .5;
end

WaitSecs(waitTime);

end