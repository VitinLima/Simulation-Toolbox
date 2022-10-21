function map3D = slsCallback(src, data, map3D)
	map3D = get(map3D, 'userdata');
	set(src, 'string', 'Select launch site.');
	waitforbuttonpress;
	cp = get(map3D.canvas.handle, 'currentpoint');
	dz = cp(2,3) - cp(1,3);
	if abs(dz) > 0.1
		dx = cp(2,1) - cp(1,1);
		dy = cp(2,2) - cp(1,2);
		x = cp(1,1) - dx/dz*cp(1,3);
		y = cp(1,2) - dy/dz*cp(1,3);
	else
		x = cp(1,1);
		y = cp(1,2);
	end
	xdata = get(map3D.canvas.map.handle, 'xdata');
	ydata = get(map3D.canvas.map.handle, 'ydata');
	xdata -= x;
	ydata -= y;
	set(map3D.canvas.map.handle, 'xdata', xdata);
	set(map3D.canvas.map.handle, 'ydata', ydata);
	set(src, 'string', 'Set launch site');
end