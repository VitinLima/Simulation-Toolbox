function map3D = fxAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	xdata = get(map3D.canvas.map.handle, 'xdata');
	xdata *= -1;
	set(map3D.canvas.map.handle, 'xdata', xdata);
end