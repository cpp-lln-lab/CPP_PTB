% (C) Copyright 2010-2020 Sam Schwarzkopf
% (C) Copyright 2020 CPP_PTB developers

function smoothRect(win, color, rect, fringe)
    %
    % Draws a filled rect (using the PTB parameters) with a transparent fringe.
    %
    % USAGE::
    %
    %   SmoothRect(WindowPtr, Color, Rect, Fringe)
    %

    alphas = linspace(0, 255, fringe);

    for f = 0:fringe - 1
        Screen('FillRect', win, ...
               [color alphas(f + 1)], ...
               [rect(1) + f rect(2) + f rect(3) - f rect(4) - f]);
    end
