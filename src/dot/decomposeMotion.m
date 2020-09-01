function [horVector, vertVector] = decomposeMotion(angleMotion)
    % [horVector, vertVector] = decomposeMotion(angleMotion)
    %
    % decompose angle of start motion into horizontal and vertical vector
    %
    % - angleMotion: in degrees
    % - horVector: horizontal component of motion
    % - vertVector: vertical component of motion

    horVector = cos(pi * angleMotion / 180);
    vertVector = -sin(pi * angleMotion / 180);
end
