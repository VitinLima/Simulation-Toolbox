	function map3D = fontSizeAction(src, data, map3D)
		map3D = get(map3D, 'userdata');
		control = findobj(map3D.auxPanel.legendsPanel.handle, 'tag', 'SetFontControl');
		value = str2double(get(control, 'string'));
		if !isnan(value)
			set(map3D.legend.handle, 'fontsize', value);
		endif
	end