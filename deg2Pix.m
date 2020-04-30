function structure = deg2Pix(fieldName, structure, Cfg)

deg = getfield( structure, fieldName);

structure = setfield( structure, [fieldName 'Pix'], ...
    floor(Cfg.ppd * deg) ) ;

end