function map3D = sCallback(src, data, map3D)
	map3D = get(map3D, 'userdata');
	set(src, 'string', 'Select point 1.');
	waitforbuttonpress;
	cp = get(map3D.canvas.handle, 'currentpoint');
	set(src, 'string', 'Select point 2.');
	dz = cp(2,3) - cp(1,3);
	if abs(dz) > 0.1
		dx = cp(2,1) - cp(1,1);
		dy = cp(2,2) - cp(1,2);
		x1 = cp(1,1) - dx/dz*cp(1,3);
		y1 = cp(1,2) - dy/dz*cp(1,3);
	else
		x1 = cp(1,1);
		y1 = cp(1,2);
	end
	marker1 = plot3(map3D.canvas.handle,x1,y1,1, 'marker', '*', 'color', 'red', 'displayname', 'Scaler marker 1');
	waitforbuttonpress;
	cp = get(map3D.canvas.handle, 'currentpoint');
	set(src, 'string', 'Scale');
	dz = cp(2,3) - cp(1,3);
	if abs(dz) > 0.1
		dx = cp(2,1) - cp(1,1);
		dy = cp(2,2) - cp(1,2);
		x2 = cp(1,1) - dx/dz*cp(1,3);
		y2 = cp(1,2) - dy/dz*cp(1,3);
	else
		x2 = cp(1,1);
		y2 = cp(1,2);
	end
	marker2 = plot3(map3D.canvas.handle,x2,y2,1, 'marker', '*', 'color', 'red', 'displayname', 'Scaler marker 2');
	dx = x2 - x1;
	dy = y2 - y1;
	currScale = sqrt(dx*dx + dy*dy);
	if currScale < 0.1
		waitfor(msgbox('Invalid input.'));
		delete([marker1 marker2]);
		return;
	end
	scale = inputdlg('Corresponding scale value:');
	if isempty(scale)
		waitfor(msgbox('Operation canceled by the user.'));
		delete([marker1 marker2]);
		return;
	end
	scale = str2double(scale);
	if isnan(scale)
		waitfor(msgbox('Invalid scale.'));
		delete([marker1 marker2]);
		return;
	end
	delete([marker1 marker2]);
	xdata = get(map3D.canvas.map.handle, 'xdata');
	ydata = get(map3D.canvas.map.handle, 'ydata');
	xdata *= scale/currScale;
	ydata *= scale/currScale;
	set(map3D.canvas.map.handle, 'xdata', xdata);
	set(map3D.canvas.map.handle, 'ydata', ydata);
end