function checkDependencies()
% Checks that the right dependencies are installed.

printCredits()


PTB = '3.0.16';

fprintf('Checking dependencies\n')

% check ptb version
try
a = PsychtoolboxVersion
fprintf(' Using %s %s\n', a, b)
if any(~strcmp(a, PTB))
    str = sprintf('%s %s %s.\n%s', ...
        'The current version PTB version is not', PTB,...
        'In case of problems (e.g json file related) consider updating.');
    warning(str); %#ok<*SPWRN>
end
catch
    error('Failed to check the PTB version: Are you sure that PTB is in the matlab path?')
end


fprintf(' We got all we need. Let''s get to work.\n')

end
