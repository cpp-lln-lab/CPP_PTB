% 2020 CPP BIDS SPM-pipeline developpers 

function structure = pixToDeg(fieldName, structure, cfg)
    % structure = pixToDeg(fieldName, structure, cfg)
    %
    % For a given field value in pixel in the structure,
    % this computes its value in degrees of viual angle using the pixel per 
    % degree value of the cfg structure and returns a structure with an 
    % additional field holding that new value and with a fieldname with any 
    % 'Pix' suffix removed and replaced with the 'DegVA' suffix .
    %
    % USAGE:
    % ------
    % fixation.widthPix = 20;
    % cfg.screen.ppd = 10;
    % 
    % fixation = degToPix('widthPix', fixation, cfg);
    %
    % Returns:
    % ------- 
    % fixation.widthDegVA = 2;
    %

    pix = getfield(structure, fieldName); %#ok<GFLD>

    structure = setfield(structure, [strrep(fieldName, 'Pix', '') 'DegVA'], ...
        floor(pix / cfg.screen.ppd)); %#ok<SFLD>

end