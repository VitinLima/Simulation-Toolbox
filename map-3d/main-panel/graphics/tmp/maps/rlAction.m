function map3D = rlCallback(src, data, map3D)
	map3D = get(map3D, 'userdata');
	ydata = get(map3D.canvas.map.handle, 'ydata');
	xdata = get(map3D.canvas.map.handle, 'xdata');
	cdata = get(map3D.canvas.map.handle, 'cdata');
	xdata += ydata;
	ydata = xdata - ydata;
	xdata -= ydata;
	xdata *= -1;
	xdata = fliplr(xdata);
	cdata = permute(cdata, [2, 1, 3]);
	cdata = fliplr(cdata);
	set(map3D.canvas.map.handle, 'ydata', ydata);
	set(map3D.canvas.map.handle, 'xdata', xdata);
	set(map3D.canvas.map.handle, 'cdata', cdata);
end