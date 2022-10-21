function map3D = rrCallback(src, data, map3D)
	map3D = get(map3D, 'userdata');
	ydata = get(map3D.canvas.map.handle, 'ydata');
	xdata = get(map3D.canvas.map.handle, 'xdata');
	cdata = get(map3D.canvas.map.handle, 'cdata');
	xdata += ydata;
	ydata = xdata - ydata;
	xdata -= ydata;
	ydata *= -1;
	ydata = fliplr(ydata);
	cdata = permute(cdata, [2, 1, 3]);
	cdata = flipud(cdata);
	set(map3D.canvas.map.handle, 'ydata', ydata);
	set(map3D.canvas.map.handle, 'xdata', xdata);
	set(map3D.canvas.map.handle, 'cdata', cdata);
end