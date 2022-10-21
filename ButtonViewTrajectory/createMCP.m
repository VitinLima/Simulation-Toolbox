function program = createMCP(program)
	function program = insertEventButtonCallback(src, data, program)
		program = get(program, 'userdata');
		targetEventIdx = menu("Events", program.file.evts);
		if targetEventIdx == 0
			return;
		end
		timeIdx = find(strcmp(program.file.variables, "Time"));
		eastIdx = find(strcmp(program.file.variables, "Position East of launch"));
		northIdx = find(strcmp(program.file.variables, "Position North of launch"));
		altitudeIdx = find(strcmp(program.file.variables, "Altitude"));
		
		time = program.file.evtTimes(targetEventIdx);
		
		idx = find(program.file.data(:, timeIdx) == time);
		
		targetEvent = cell2mat(program.file.evts(targetEventIdx));
		east = program.file.data(idx, eastIdx);
		north = program.file.data(idx, northIdx);
		altitude = program.file.data(idx, altitudeIdx);
		
		plot3(program.image.handle, east, north, altitude, 'color', 'b', 'marker', '*', 'tag', "eventMarker", 'displayname', targetEvent, 'userdata', idx);
	end
	uicontrol(
		program.mcp.handle,
		'string', "Insert event",
		'callback', @(h, e)set(program.handle, 'userdata', insertEventButtonCallback(h, e, program.handle)),
		'tag', 'insertEventButton');
	
	function program = removeEventButtonCallback(src, data, program)
		program = get(program, 'userdata');
		evts = findall(findobj(findobj(program.handle, 'tag', 'image'), 'type', 'axes'), 'tag', 'eventText');
		plts = findall(findobj(findobj(program.handle, 'tag', 'image'), 'type', 'axes'), 'tag', 'eventPlot');
		choices = {};
		for e = evts
			choices(end+1) = get(e, 'string');
		end
		if length(choices) < 1
			return;
		end
		choice = menu("Event to remove:", choices);
		if choice > 0
			delete(evts(choice));
			delete(plts(choice));
		end
	end
	uicontrol(
		program.mcp.handle,
		'string', "Remove event",
		'callback', @(h, e)set(program.handle, 'userdata', removeEventButtonCallback(h, e, program.handle)),
		'tag', 'removeEventButton');
	
	function program = updateEACP(src, data, program)
		program = get(program, 'userdata');
		set([program.emacp.handle program.evacp.handle program.gsacp.handle program.lacp.handle program.macp.handle program.tacp.handle], 'visible', 'off');
		set(program.evacp.handle, 'visible', 'on');
		markers = findall(program.image.handle, 'tag', "eventMarker");
		if length(markers) < 1
			return;
		elseif length(markers) == 1
			marker = markers(1);
		else
			choice = menu("Event to edit:", get(markers, 'displayname'));
			if choice == 0
				return;
			endif
			
			marker = markers(choice);
		end
		set(program.evacp.handle, 'userdata', marker);
		set(program.evacp.markerSizeControl.handle, 'string', num2str(get(marker, 'markersize')));
		set(program.evacp.titleControl.handle, 'string', cell2mat(strsplit(get(marker, 'displayname'), '\n')(1)));
	end
	uicontrol(
		program.mcp.handle,
		'string', "Event settings",
		'callback', @(h, e)set(program.handle, 'userdata', updateEACP(h, e, program.handle)),
		'tag', 'eventSettingsButton');
	
	function program = updateLACP(src, data, program)
		program = get(program, 'userdata');
		set([program.emacp.handle program.evacp.handle program.gsacp.handle program.lacp.handle program.macp.handle program.tacp.handle], 'visible', 'off');
		set(program.lacp.handle, 'visible', 'on');
		set(program.lacp.fontControl.handle, 'string', num2str(get(program.legend.handle, 'fontsize')));
		set(program.lacp.positionXControl.handle, 'value', get(program.legend.handle, 'position')(1));
		set(program.lacp.positionYControl.handle, 'value', get(program.legend.handle, 'position')(2));
	end
	uicontrol(
		program.mcp.handle,
		'string', "Legend settings",
		'callback', @(h, e)set(program.handle, 'userdata', updateLACP(h, e, program.handle)),
		'tag', 'legendSettingsButton');
	
	function program = setMapButtonCallback(src, data, program)
		program = get(program, 'userdata');
		cd(strjoin({program.pwd, "Maps"}, filesep));
		[FileName,FilePath,Fileltidx] = uigetfile("","Map file:");
		if FileName == 0
			return;
		end
		[img, map, alpha] = imread(strjoin({FilePath,FileName}, ''));
		if img == -1
			return;
		end
		set(program.image.map.handle,
			'cdata', img,
			'userdata', img);
	end
	uicontrol(
		program.mcp.handle,
		'string', "Set map",
		'callback', @(h, e)set(program.handle, 'userdata', setMapButtonCallback(h, e, program.handle)),
		'tag', 'setMapButton');
	
	function program = updateMACP(src, data, program)
		program = get(program, 'userdata');
		set([program.emacp.handle program.evacp.handle program.gsacp.handle program.lacp.handle program.macp.handle program.tacp.handle], 'visible', 'off');
		set(program.macp.handle, 'visible', 'on');
##		set(program.macp.tixControl.handle, 'string', '0.0');
##		set(program.macp.tiyControl.handle, 'string', '0.0');
##		set(program.macp.ssControl.handle, 'string', '1.0');
	end
	uicontrol(
		program.mcp.handle,
		'string', 'Map settings',
		'callback', @(h, e)set(program.handle, 'userdata', updateMACP(h, e, program.handle)),
		'tag', 'mapSettingsButton');
	
	
	function program = updateTACP(src, data, program)
		program = get(program, 'userdata');
		set([program.emacp.handle program.evacp.handle program.gsacp.handle program.lacp.handle program.macp.handle program.tacp.handle], 'visible', 'off');
		set(program.tacp.handle, 'visible', 'on');
		trajectoryHandle = findobj(program.image.handle, 'tag', 'trajectory');
		set(program.tacp.stepControl.handle, 'value', program.tacp.stepControl.value);
		set(program.tacp.lineWidthControl.handle, 'string', num2str(get(trajectoryHandle, 'linewidth')));
	end
	uicontrol(
		program.mcp.handle,
		'string', 'Trajectory settings',
		'callback', @(h, e)set(program.handle, 'userdata', updateTACP(h, e, program.handle)),
		'tag', 'trajectorySettingsButton');
	
	function program = updateGSACP(src, data, program)
		program = get(program, 'userdata');
		set([program.emacp.handle program.evacp.handle program.gsacp.handle program.lacp.handle program.macp.handle program.tacp.handle], 'visible', 'off');
		set(program.gsacp.handle, 'visible', 'on');
		marker = findobj(program.image.handle, 'tag', 'GSmarker');
		set(program.gsacp.markerSizeControl.handle, 'string', num2str(get(marker, 'markersize')));
		set(program.gsacp.apertureAngleControl.handle, 'string', get(program.image.gsMarker.handle, 'userdata'));
		set(program.gsacp.maxDistanceControl.handle, 'string', get(program.image.gsConeLine1.handle, 'userdata'));
	end
	uicontrol(
		program.mcp.handle,
		'string', 'Ground Station',
		'callback', @(h, e)set(program.handle, 'userdata', updateGSACP(h, e, program.handle)),
		'tag', 'groundStationButton');
	
	function program = saveAsCallback(src, data, program)
		program = get(program, 'userdata');
		set(program.image.handle, 'outerposition', [0 0 1 1]);
		program.fileName = cell2mat(inputdlg("Save as: "));
		if !isempty(program.fileName)
			cd(strjoin({program.pwd, "Results"}, filesep));
			saveas(program.handle, program.fileName, 'png');
		end;
		set(program.image.handle, 'outerposition', [.2 .2 .8 .8]);
	end
	uicontrol(
		program.mcp.handle,
		'string', 'Save as',
		'callback', @(h, e)set(program.handle, 'userdata', saveAsCallback(h, e, program.handle)),
		'tag', 'saveAsButton');
	
	organizePanel(program.mcp.handle, 0, 1);
end