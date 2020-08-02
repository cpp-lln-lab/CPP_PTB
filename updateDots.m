function [dots] = updateDots(dots, cfg)
    
    % Move the selected dots
    dots.positions = dots.positions + dots.speeds;

    % Create a logical vector to detect any dot that has:
    % - an xy position inferior to 0
    % - an x position superior to winWidth
    % - an x position superior to winHeight
    % - has exceeded its liftime
    N = any([...
        dots.positions > cfg.screen.winWidth, ...
        dots.positions < 0, ...
        dots.time > dots.lifeTime, ...
        rand(cfg.dot.number,1) < cfg.dot.proportionKilledPerFrame ], 2) ;
    
    % If there is any such dot we relocate it to a new random position
    % and change its lifetime to 1
    if any(N)
        dots.positions(N, :) = rand(sum(N), 2) * cfg.screen.winWidth;
        dots.time(N, 1) = 1;
    end
    
    % Add one frame to the dot lifetime to each dot
    dots.time = dots.time + 1;
end
