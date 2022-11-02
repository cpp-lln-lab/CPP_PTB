function saveApertures(saveAps, cfg, apertures)
    %

    % (C) Copyright 2010-2020 Sam Schwarzkopf
    % (C) Copyright 2020 CPP_PTB developers
    if saveAps

        matFile = fullfile( ...
                           cfg.outputDir, ...
                           strrep(cfg.fileName.events, '.tsv', '_AperturesPRF.mat'));
        if IsOctave
            save(matFile, '-mat7-binary');
        else
            save(matFile, '-v7.3');
        end

        for iApert = 1:size(apertures.Frames, 3)

            tmp = apertures.Frames(:, :, iApert);

            % We skip the all nan frames and print the others
            if ~all(isnan(tmp(:)))

                close all;

                imagesc(apertures.Frames(:, :, iApert));

                colormap gray;

                box off;
                axis off;
                axis square;

                apertureName = getApertureName(cfg, apertures, iApert);

                print(gcf, ...
                      fullfile(cfg.aperture.outputDir, [ApertureName '.tif']), ...
                      '-dtiff');
            end

        end

    end

end
