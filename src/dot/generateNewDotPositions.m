% (C) Copyright 2020 CPP_PTB developers

function newPositions = generateNewDotPositions(dotMatrixWidth, nbDots)

    newPositions = rand(nbDots, 2) * dotMatrixWidth;

end
