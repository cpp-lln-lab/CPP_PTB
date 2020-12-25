% (C) Copyright 2020 CPP_PTB developers

function structure = setDefaults(structure, fieldsToSet)
    %
    % Recursively loop through the fields of a structure and sets a value if they don't exist.
    %
    % USAGE::
    %
    %   structure = setDefaults(structure, fieldsToSet)
    %
    % :param structure:
    % :type structure: structure
    % :param fieldsToSet:
    % :type fieldsToSet: structure
    %
    % :returns: - :structure: (structure)

    fieldsToSet = orderfields(fieldsToSet);

    names = fieldnames(fieldsToSet);

    for i = 1:numel(names)

        thisField = fieldsToSet.(names{i});

        if isfield(structure, names{i}) && isstruct(structure.(names{i}))

            structure.(names{i}) = ...
                setDefaults( ...
                            structure.(names{i}), ...
                            fieldsToSet.(names{i}) ...
                           );

        else

            structure = setFieldToIfNotPresent( ...
                                               structure, ...
                                               names{i}, ...
                                               thisField);
        end

    end

    structure = orderfields(structure);

end

function structure = setFieldToIfNotPresent(structure, fieldName, value)
    if ~isfield(structure, fieldName)
        structure.(fieldName) = value;
    end
end
