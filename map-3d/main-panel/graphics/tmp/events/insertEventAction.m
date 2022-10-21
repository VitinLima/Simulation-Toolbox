function map3D = insertEventAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	targetEventIdx = menu("Events", map3D.file.evts);
	if targetEventIdx == 0
		return;
	end
	timeIdx = find(strcmp(map3D.file.variables, "Time"));
	eastIdx = find(strcmp(map3D.file.variables, "Position East of launch"));
	northIdx = find(strcmp(map3D.file.variables, "Position North of launch"));
	altitudeIdx = find(strcmp(map3D.file.variables, "Altitude"));
	
	time = map3D.file.evtTimes(targetEventIdx);
	
	idx = find(map3D.file.data(:, timeIdx) == time);
	
	targetEvent = cell2mat(map3D.file.evts(targetEventIdx));
	east = map3D.file.data(idx, eastIdx);
	north = map3D.file.data(idx, northIdx);
	altitude = map3D.file.data(idx, altitudeIdx);
	
	plot3(map3D.image.handle, east, north, altitude, 'color', 'b', 'marker', '*', 'tag', "eventMarker", 'displayname', targetEvent, 'userdata', idx);
end