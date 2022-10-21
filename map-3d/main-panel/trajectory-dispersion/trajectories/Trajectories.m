function Trajectories(map3D)
	choices = {
    "display",
    "remove",
		"graphics settings",
		"search",
    "export"};
  
	KEYVALUE = {
		"ListString", choices,
		"SelectionMode", "Single",
		"InitialValue", 1,
		"Name", "Dispersion trajectories",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "Back"
		}';
  
  do
    [SEL, OK] = listdlg(KEYVALUE{1:end});
    if OK
      switch(SEL)
        case 1
          h = findobj(map3D.canvas.handle, 'tag', "dispersion trajectories");
          if isempty(h)
            displayTrajectories(map3D);
          else
            waitfor(msgbox("Dispersion trajectories already displayed."));
          end
        case 2
          h = findobj(map3D.canvas.handle, 'tag', "dispersion trajectories");
          if !isempty(h)
            delete(h);
          else
            waitfor(msgbox("No dispersion trajectories found."));
          end
        case 3
          h = findobj(map3D.canvas.handle, 'tag', "dispersion trajectories");
          if !isempty(h)
            editLine(h);
          else
            waitfor(msgbox("No dispersion trajectories found."));
          end
        case 4
          trajectories = map3D.program.impactDispersion.trajectories;
          evts = map3D.program.nominalTrajectory.evts;
          variables = map3D.program.variables;
          units = map3D.program.nominalTrajectory.units;
          searchStatistics(trajectories, evts, variables, units);
        case 5
          [FNAME, FPATH, FLTIDX] = uiputfile(".kml", "Save as", map3D.program.transient.lastSavedDirectory);
          if FNAME==0
            return;
          endif
          map3D.program.transient.lastSavedDirectory = FPATH;
          exportKML([FPATH, filesep, FNAME], map3D.program.impactDispersion, map3D.program);
      end
    end
  until !OK
end