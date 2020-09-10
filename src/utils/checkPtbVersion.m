function checkPtbVersion()
    % Checks that the right dependencies are installed.

    printCreditsCppPtb();

    PTB.major =  3;
    PTB.minor = 0;
    PTB.point =  14;

    fprintf('Checking dependencies\n');

    % check ptb version
    try

        [~, versionStruc] = PsychtoolboxVersion;

        fprintf(' Using PTB %i.%i.%i\n', ...
            versionStruc.major, ...
            versionStruc.minor, ...
            versionStruc.point);

        if any([ ...
                versionStruc.major < PTB.major, ...
                versionStruc.minor < PTB.minor, ...
                versionStruc.point < PTB.point ...
                ])

            str = sprintf('%s %i.%i.%i %s.\n%s', ...
                'The current version PTB version is not', ...
                PTB.major, ...
                PTB.minor, ...
                PTB.point, ...
                'In case of problems (e.g json file related) consider updating.');
            warning(str); %#ok<*SPWRN>
        end
    catch
        error('Failed to check the PTB version: Are you sure that PTB is in the matlab path?');
    end

    fprintf(' We got all we need. Let us get to work.\n');

end
