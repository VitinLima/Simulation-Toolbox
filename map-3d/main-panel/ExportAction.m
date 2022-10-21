function map3D = ExportAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	
	choices = {"Save image", "Export kml file"};
	
	KEYVALUE = {
		"ListString", choices,
		"SelectionMode", "Single",
		"InitialValue", 1,
		"Name", "",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "Cancel"
		}';
	
	[SEL, OK] = listdlg(KEYVALUE{1:end});
	if OK
		switch (SEL)
			case 1
        [FNAME, FPATH, FLTIDX] = uiputfile(".png", "Save as", map3D.program.transient.lastSavedDirectory);
        if FNAME==0
          return;
        endif
        map3D.program.transient.lastSavedDirectory = FPATH;
				saveImage([FPATH, filesep, FNAME], map3D);
			case 2
        [FNAME, FPATH, FLTIDX] = uiputfile(".kml", "Save as", map3D.program.transient.lastSavedDirectory);
        if FNAME==0
          return;
        endif
        map3D.program.transient.lastSavedDirectory = FPATH;
        H = findall(map3D.canvas.handle, "type", "line");
				exportKML([FPATH, filesep, FNAME], H, map3D.program);
		end
	end
end