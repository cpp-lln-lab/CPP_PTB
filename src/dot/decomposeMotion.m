% (C) Copyright 2020 CPP_PTB developers

function [horVector, vertVector] = decomposeMotion(angleMotion)
    %
    % Decompose angle of start motion into horizontal and vertical vector.
    %
    % USAGE::
    %
    %   [horVector, vertVector] = decomposeMotion(angleMotion)
    %
    % :param angleMotion: in degrees
    % :type angleMotion: scalar
    %
    % :returns: - :horVector: horizontal component of motion
    %           - :vertVector: vertical component of motion
    %
    %

    horVector = cos(pi * angleMotion / 180);
    vertVector = -sin(pi * angleMotion / 180);
end
