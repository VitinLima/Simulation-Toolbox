function map3D = markerSizeAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	marker = get(map3D.auxPanel.eventsPanel.handle, 'userdata');
	control = findobj(map3D.auxPanel.eventsPanel.handle, 'tag', 'MarkerSizeControl');
	set(marker, 'markersize', str2double(get(control, 'string')));
end