function farewellScreen(cfg)

    Screen('FillRect', cfg.screen.win, cfg.color.background, cfg.screen.winRect);
    DrawFormattedText(cfg.screen.win, 'Thank you!', 'center', 'center', cfg.text.color);
    Screen('Flip', cfg.screen.win);
    WaitSecs(cfg.mri.repetitionTime * 2);

end
