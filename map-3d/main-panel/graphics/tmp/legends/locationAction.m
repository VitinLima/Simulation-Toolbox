	function map3D = locationAction(src, data, map3D)
		map3D = get(map3D, 'userdata');
		control = findobj(map3D.auxPanel.legendsPanel.handle, 'tag', 'SetLocationControl');
		choices = {"best", "bestoutside", "east", "eastoutside", "none", "north", "northeast", "northeastoutside", "northoutside", "northwest", "northwestoutside", "south", "southeast", "southeastoutside", "southoutside", "southwest", "southwestoutside", "west", "westoutside"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(map3D.legend.handle, 'location', value);
		control = findobj(map3D.auxPanel.legendsPanel.handle, 'tag', 'SetPositionXControl');
		value = get(map3D.legend.handle, 'position');
		set(control, 'value', value(1));
		control = findobj(map3D.auxPanel.legendsPanel.handle, 'tag', 'SetPositionYControl');
		value = get(map3D.legend.handle, 'position');
		set(control, 'value', value(2));
	end