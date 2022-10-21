	function map3D = positionXAction(src, data, map3D)
		map3D = get(map3D, 'userdata');
		value = get(map3D.legend.handle, 'position');
		control = findobj(map3D.auxPanel.legendsPanel.handle, 'tag', 'SetPositionXControl');
		value(1) = get(control, 'value');
		control = findobj(map3D.auxPanel.legendsPanel.handle, 'tag', 'SetPositionYControl');
		value(2) = get(control, 'value');
		set(map3D.legend.handle, 'position', value);
	end