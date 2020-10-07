% (C) Copyright 2010-2020 Sam Schwarzkopf
% (C) Copyright 2020 CPP_PTB developers

if SaveAps
    if SaveAps == 1
        ApFrm = zeros(100, 100, Parameters.Volumes_per_Trial * length(Parameters.Conditions));
    elseif SaveAps == 2
        ApFrm = zeros(640, 480, 3);
        sf = 0;
    end
    SavWin = Screen('MakeTexture', Win, 127 * ones(StimRect([3 3])));
end

% If saving movie
if SaveAps == 1 && PrevVolume ~= CurrVolume
    PrevVolume = CurrVolume;
    CurApImg = Screen('GetImage', Win);
    CurApImg = rgb2gray(CurApImg);
    CurApImg = imresize(CurApImg, [Rect(4) Rect(3)]);
    Fxy = round(CenterRect(FrameRect, Rect) + ...
                [Parameters.Image_Position Parameters.Image_Position]);
    CurApImg = CurApImg(Fxy(2):Fxy(4), Fxy(1):Fxy(3));
    CurApImg = double(abs(double(CurApImg) - 127) > 1);
    CurApImg = imresize(CurApImg, [100 100]);
    ApFrm(:, :, Parameters.Volumes_per_Trial * (Trial - 1) + CurrVolume) = CurApImg;
elseif SaveAps == 2
    CurApImg = Screen('GetImage', Win);
    CurApImg = imresize(CurApImg, [640 480]);
    sf = sf + 1;
    ApFrm(:, :, :, sf) = CurApImg;
end

if SaveAps == 2
    ApFrm = uint8(ApFrm);
    save('Stimulus_movie', 'ApFrm');
end
