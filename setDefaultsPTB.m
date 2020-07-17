function cfg = setDefaultsPTB(cfg)

% list the default values
fieldsToSet.keyboard = [];
fieldsToSet.responseBox = [];

fieldsToSet.debug = true;
fieldsToSet.testingTranspScreen = true;
fieldsToSet.testingSmallScreen = true;

fieldsToSet.backgroundColor = [0 0 0];

fieldsToSet.textFont = 'Courier New';
fieldsToSet.textSize = 18;
fieldsToSet.textStyle = 1;

fieldsToSet.monitorWidth = 42;
fieldsToSet.screenDistance = 134;

% loop through the defaults and set them in cfg if they don't exist
names = fieldnames(fieldsToSet);

for i = 1:numel(names)
    cfg = setFieldToIfNotPresent(...
        cfg, ...
        names{i}, ...
        getfield(fieldsToSet, names{i})); %#ok<GFLD>
end


end

function struct = setFieldToIfNotPresent(struct, fieldName, value)
    if ~isfield(struct, fieldName)
        struct = setfield(struct, fieldName, value); %#ok<SFLD>
    end
end