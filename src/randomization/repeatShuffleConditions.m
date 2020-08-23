function shuffledRepeats = repeatShuffleConditions(baseConditionVector, nbRepeats)
    % shuffledRepeats = repeatShuffleConditions(baseConditionVector, nbRepeats)
    %
    % given baseConditionVector, a vector of conditions (coded as numbers), this will
    % create a longer vector made of nbRepeats of this base vector and make sure
    % that a given condition is not repeated one after the other

    % TODO
    % - needs some input checks to make sure that there is actually a solution
    % for this randomization (e.g having [1 1 1 1 1 2] as input will lead to an
    % infinite loop)

    if numel(unique(baseConditionVector)) == 1
        error('There should be more than one condition to shuffle');
    end

    baseConditionVector = baseConditionVector(:)';

    while 1
        tmp = [];
        for iRepeat = 1:nbRepeats

            tmp = [tmp, shuffle(baseConditionVector)];

        end
        if ~any(diff(tmp, [], 2) == 0)
            break
        end
    end

    shuffledRepeats = tmp;

end
