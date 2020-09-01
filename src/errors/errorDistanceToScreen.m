function errorDistanceToScreen(cfg)

    errorStruct.message = sprintf([
        'Distance to monitor seems too small.\n' ...
        'It should be in centimeters.\n' ...
        'cfg.screen.monitorDistance = %f'], cfg.screen.monitorDistance);

    errorStruct.identifier = 'computeFOV:wrongDistanceToScreen';

    error(errorStruct);
end
