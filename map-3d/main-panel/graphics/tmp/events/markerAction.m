function map3D = markerAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	marker = get(map3D.auxPanel.eventsPanel.handle, 'userdata');
	choices = {"*", "+", ".", "<", ">", "^", "d", "diamond", "h", "hexagram", "none", "o", "p", "pentagram", "s", "square", "v", "x"};
	choice = menu("Set location:", choices);
	value = cell2mat(choices(choice));
	set(marker, 'marker', value);
end