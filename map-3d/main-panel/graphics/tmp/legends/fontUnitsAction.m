	function map3D = fontUnitsAction(src, data, map3D)
		map3D = get(map3D, 'userdata');
		choices = {"centimeters", "inches", "normalized", "pixels", "points"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(map3D.legend.handle, 'fontunits', value);
		control = findobj(map3D.auxPanel.legendsPanel.handle, 'tag', 'SetFontControl');
		set(control, 'string', num2str(get(map3D.legend.handle, 'fontsize')));
	end