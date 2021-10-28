function structure = degToPix(fieldName, structure, cfg)
    % For a given field value in degrees of visual angle in the structure, this computes its value
    % in pixel using the pixel per degree value of the cfg structure and returns a structure with
    % an additional field with Pix suffix holding that new value.
    %
    % USAGE::
    %
    %   structure = degToPix(fieldName, structure, cfg)
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
    %   fixation.width = 2;
    %   cfg.screen.ppd = 10;
    %
    %   fixation = degToPix('width', fixation, cfg);
    %
    %
    % (C) Copyright 2020 CPP_PTB developers

    deg = getfield(structure, fieldName); %#ok<GFLD>

    structure = setfield(structure, [fieldName 'Pix'], ...
                         deg * cfg.screen.ppd); %#ok<SFLD>

end
