function program = SaveFile(program)
  flt = {"*.b","Octave binary"};
	[FNAME,FPATH,FLTIDX] = uiputfile(flt,"File name:", program.transient.lastSavedDirectory);
	if FNAME == 0
    return;
  endif
  program.transient.lastSavedDirectory = FPATH;
  save('-binary', strjoin({FPATH, FNAME}, filesep), "program");
end