function map3D = fyCallback(src, data, map3D)
	map3D = get(map3D, 'userdata');
	ydata = get(map3D.canvas.map.handle, 'ydata');
	ydata *= -1;
	set(map3D.canvas.map.handle, 'ydata', ydata);
end