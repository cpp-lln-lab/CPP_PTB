function chosenPositions = setTargetPositionInSequence(seqLength, nbTarget, forbiddenPos)
    % chosenPositions = setTargetPositionInSequence(seqLength, nbTarget, forbiddenPos)
    %
    % For a sequence of length seqLength where we want to insert nbTarget targets, this
    % will return nbTarget random position in that sequence and make sure that,
    % they are not consecutive positions.

    REPLACE = false;

    allowedPositions = setxor(forbiddenPos, 1:seqLength);

    chosenPositions = [];

    if nbTarget < 1
        return

    elseif nbTarget == 1

        chosenPositions = randsample(allowedPositions, nbTarget, REPLACE);

    else

        targetDifference = 0;

        while any(abs(targetDifference) < 2)
            chosenPositions = randsample(allowedPositions, nbTarget, REPLACE);
            chosenPositions = sort(chosenPositions);
            targetDifference = diff(chosenPositions, [], 2);
        end

    end

end
