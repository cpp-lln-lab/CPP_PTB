function test_suite = test_setDefaults %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_setDefaultsWrite()

    %% set up
    structure = struct();

    fieldsToSet.field = 1;

    structure = setDefaults(structure, fieldsToSet);

    %% data to test against
    expectedStructure.field = 1;

    %% test
    assertEqual(expectedStructure, structure);

end

function test_setDefaultsNoOverwrite()

    % set up
    structure.field.subfield_1 = 3;

    fieldsToSet.field.subfield_1 = 1;
    fieldsToSet.field.subfield_2 = 1;

    structure = setDefaults(structure, fieldsToSet);

    % data to test against
    expectedStructure.field.subfield_1 = 3;
    expectedStructure.field.subfield_2 = 1;

    % test
    assert(isequal(expectedStructure, structure));

end
