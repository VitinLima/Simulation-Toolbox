function map3D = titleAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	marker = get(map3D.auxPanel.eventsPanel.handle, 'userdata');
	control = findobj(map3D.auxPanel.eventsPanel.handle, 'tag', 'TitleControl');
	set(marker, 'displayname', strjoin([get(control, 'string'), strsplit(get(marker, 'displayname'), '\n')(2:end)], '\n'));
end