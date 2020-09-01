function structure = setDefaults(structure, fieldsToSet)
    % structure = setDefaults(structure, fieldsToSet)
    %
    % recursively loop through the fields of a structure and sets a value if they don't exist
    %

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
