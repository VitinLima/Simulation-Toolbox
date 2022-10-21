function map3D = NominalTrajectoryAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	
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
		"Name", "Statistics functions",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "Back"
		}';
	
	do
    [SEL, OK] = listdlg(KEYVALUE{1:end});
    if !OK
      continue;
    end
		switch(SEL)
			case 1
        h = findobj(map3D.canvas.handle, 'tag', "nominal trajectory");
        if isempty(h)
          displayNominalTrajectory(map3D);
        else
          waitfor(msgbox("Nominal trajectory already displayed."));
        end
			case 2
        h = findobj(map3D.canvas.handle, 'tag', "nominal trajectory");
        if !isempty(h)
          delete(h);
        else
          waitfor(msgbox("No nominal trajectory found."));
        end
      case 3
        h = findobj(map3D.canvas.handle, 'tag', "nominal trajectory");
        if !isempty(h)
          editLine(h);
        else
          waitfor(msgbox("No nominal trajectory found."));
        end
      case 4
        searchNominalTrajectoryValue(map3D.program.nominalTrajectory);
      case 5
        [FNAME, FPATH, FLTIDX] = uiputfile(".kml", "Save as", map3D.program.transient.lastSavedDirectory);
        if FNAME==0
          return;
        endif
        map3D.program.transient.lastSavedDirectory = FPATH;
				exportKML([FPATH, filesep, FNAME], map3D.program.nominalTrajectory, map3D.program);
		end
	until !OK
end