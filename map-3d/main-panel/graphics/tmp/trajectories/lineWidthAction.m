function map3D = lineWidthAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	control = findobj(map3D.auxPanel.trajectoriesPanel.handle, 'tag', 'SetLineWidthControl');
	value = str2double(get(control, 'string'));
	if !isnan(value)
		set(map3D.canvas.trajectory.handle, 'linewidth', value);
	endif
end