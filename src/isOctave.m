function retval = isOctave
    % Return: true if the environment is Octave.
    % mostly used to testing when PTB is not in the path
    %
    % Must stay in the 'src' folder for continuous integration with github
    % action to work. Not sure why.

    persistent cacheval   % speeds up repeated calls

    if isempty (cacheval)
        cacheval = (exist ('OCTAVE_VERSION', 'builtin') > 0);
    end

    retval = cacheval;
end
