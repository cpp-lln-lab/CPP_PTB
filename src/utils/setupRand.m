% (C) Copyright 2010-2020 Sam Schwarzkopf
% (C) Copyright 2020 CPP_PTB developers

function setupRand()
    % setupRand()
    %
    % Resets the seed of the random number generator.
    % Will "adapt" depending on the matlab/octave version.
    %
    % Taken from Sam's version
    % DOI:10.17605/OSF.IO/2RGSM
    % https://osf.io/2rgsm/

    try
        % Use the recommended method in Matlab R2012a.
        rng('shuffle');
        disp('Using modern randomizer...');
    catch
        % Use worse methods for old versions of Matlab (e.g. 7.1.0.246 (R14) SP3).
        try
            rand('twister', sum(100 * clock));
            randn('state', sum(100 * clock));
            disp('Using outdated randomizer...');
        catch
            % For very old Matlab versions these are the only methods you can use.
            % These are supposed to be flawed although you will probably not
            % notice any effect of this for most situations.
            rand('state', sum(100 * clock));
            randn('state', sum(100 * clock));
            disp('Using "flawed" randomizer...');
        end
    end

end
