function newPositions = generateNewDotPositions(cfg, dotNumber)
    
    newPositions = rand(dotNumber, 2) * cfg.dot.matrixWidth;
    
end