function structure = pixToDeg(fieldName, structure, cfg)
    %
    % For a given field value in pixel in the structure,
    % this computes its value in degrees of viual angle using the pixel per
    % degree value of the cfg structure and returns a structure with an
    % additional field holding that new value and with a fieldname with any
    % 'Pix' suffix removed and replaced with the 'DegVA' suffix .
    %
    % USAGE::
    %
    %   structure = pixToDeg(fieldName, structure, cfg)
    %
    % :param fieldName:
    % :type fieldName: string
    % :param structure:
    % :type structure: structure
    % :param cfg:
    % :type cfg: structure
    %
    % :returns: - :structure: (structure)
    %
    % EXAMPLE::
    %
    %   fixation.widthPix = 20;
    %   cfg.screen.ppd = 10;
    %
    %   fixation = degToPix('widthPix', fixation, cfg);
    %

    % (C) Copyright 2020 CPP_PTB developers

    pix = getfield(structure, fieldName); %#ok<GFLD>

    structure = setfield(structure, [strrep(fieldName, 'Pix', '') 'DegVA'], ...
                         pix / cfg.screen.ppd); %#ok<SFLD>

end
