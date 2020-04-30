function pressSpace4me

fprintf('\npress space to continue\n');

while 1

    WaitSecs(0.1);
    
    [~, keyCode, ~] = KbWait(-1);
    
    responseKey = KbName(find(keyCode));
    
    if strcmp(responseKey,'space')
        fprintf('starting the experiment....\n');
        break
    end
    
end

end

