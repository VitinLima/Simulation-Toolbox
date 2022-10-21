function Ellipsis(map3D)
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
    if OK
      switch(SEL)
        case 1
          h = findobj(map3D.canvas.handle, 'tag', "ellipsis");
          if isempty(h)
            displayEllipsis(map3D);
          else
            waitfor(msgbox("Ellipsis already plotted."));
          end
        case 2
          h = findobj(map3D.canvas.handle, 'tag', "ellipsis");
          if !isempty(h)
            delete(h);
          else
            waitfor(msgbox("No ellipsis found."));
          end
        case 3
          h = findobj(map3D.canvas.handle, 'tag', "ellipsis");
          if !isempty(h)
            editLine(h);
          else
            waitfor(msgbox("No ellipsis found."));
          end
        case 4
          h = findobj(map3D.canvas.handle, 'tag', "ellipsis");
          if !isempty(h)
            east = get(h, 'xdata');
            north = get(h, 'ydata');
            id = find(strcmp(map3D.program.variables, "Position East of launch"));
            lengthUnit = cell2mat(map3D.program.nominalTrajectory.units(id));
            searchEllipsis(map3D.program.impactDispersion.ellipsis, lengthUnit);
          else
            waitfor(msgbox("No ellipsis found."));
          end
        case 5
          [FNAME, FPATH, FLTIDX] = uiputfile(".kml", "Save as", map3D.program.transient.lastSavedDirectory);
          if FNAME==0
            return;
          endif
          map3D.program.transient.lastSavedDirectory = FPATH;
          exportKML([FPATH, filesep, FNAME], map3D.program.impactDispersion.ellipsis, map3D.program);
      end
    end
  until !OK
end