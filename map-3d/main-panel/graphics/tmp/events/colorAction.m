function map3D = colorAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	marker = get(map3D.auxPanel.eventsPanel.handle, 'userdata');
	choices = {"yellow", "blue", "black", "cyan", "green", "magenta", "red", "white"};
	choice = menu("Set location:", choices);
	value = cell2mat(choices(choice));
	set(marker, 'color', value);
end