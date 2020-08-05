function [horVector, vertVector] = decomposeMotion(angleMotion)
    % decompose angle of start motion into horizontal and vertical vector
    horVector = cos(pi * angleMotion / 180);
    vertVector = -sin(pi * angleMotion / 180);
end
