function test_suite = test_checkAbortGetResponse %#ok<*STOUT>
    try % assignment of 'localfunctions' is necessary in Matlab >= 2016
        test_functions = localfunctions(); %#ok<*NASGU>
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;
end

function test_checkAbortGetResponseBasic()

    responseEvents(1).keyName = 'a';
    responseEvents(2).keyName = '2';
    responseEvents(3).keyName = 'ESCAPE';

    cfg.keyboard.escapeKey = 'ESCAPE';

    assertExceptionThrown(@()checkAbortGetResponse(responseEvents, cfg), ...
        'getResponse:abortRequested');

end
