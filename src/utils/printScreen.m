% (C) Copyright 2020 CPP_PTB developers

function frame = printScreen(win, filename, frame)

    image_array = Screen('GetImage', win);

    imagesc(image_array);
    box  off;
    axis off;
    set(gca, 'position', [0 0 1 1], 'units', 'normalized');

    print(gcf, [filename sprintf('%04.0f', frame) '.jpeg'], '-djpeg');

    frame = frame + 1;

end
