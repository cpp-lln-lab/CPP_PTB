function [dots] = updateDots(dots, cfg)

    % Move the selected dots
    dots.positions = dots.positions + dots.speeds;

    if all(isnan(dots.positions(:)))
        errorStruct.message = 'All dots position have NaN values.';
        errorStruct.identifier = 'updateDots:onlyNans';

        error(errorStruct);
    end

    % Add one frame to the dot lifetime to each dot
    dots.time = dots.time + 1;

    dots = reseedDots(dots, cfg);

end
