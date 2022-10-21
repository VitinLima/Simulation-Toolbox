function program = createMACP(program)
##	function program = tixCallback(src, data, program)
##		program = get(program, 'userdata');
##		control = findobj(program.macp.handle, 'tag', 'tixControl');
##		value = str2double(get(control, 'string'));
##		if !isnan(value)
##			xdata = get(program.image.map.handle, 'xdata');
##			xdata += value;
##			set(program.image.map.handle, 'xdata', xdata);
##		endif
##	end
##	tmp = uipanel(program.macp.handle);
##	program.macp.tixControl.handle = uicontrol(
##		tmp,
##		'style', 'edit',
##		'tag', 'tixControl');
##	uicontrol(
##		tmp,
##		'string', 'Translate image x',
##		'callback', @(h, e)set(program.handle, 'userdata', tixCallback(h, e, program.handle)));
##	organizePanel(tmp, 2, 1);
##	
##	function program = tiyCallback(src, data, program)
##		program = get(program, 'userdata');
##		control = findobj(program.macp.handle, 'tag', 'tiyControl');
##		value = str2double(get(control, 'string'));
##		if !isnan(value)
##			ydata = get(program.image.map.handle, 'ydata');
##			ydata += value;
##			set(program.image.map.handle, 'ydata', ydata);
##		endif
##	end
##	tmp = uipanel(program.macp.handle);
##	program.macp.tiyControl.handle = uicontrol(
##		tmp,
##		'style', 'edit',
##		'tag', 'tiyControl');
##	uicontrol(
##		tmp,
##		'string', 'Translate image y',
##		'callback', @(h, e)set(program.handle, 'userdata', tiyCallback(h, e, program.handle)));
##	organizePanel(tmp, 2, 1);
	
	function program = rrCallback(src, data, program)
		program = get(program, 'userdata');
		ydata = get(program.image.map.handle, 'ydata');
		xdata = get(program.image.map.handle, 'xdata');
		cdata = get(program.image.map.handle, 'cdata');
		xdata += ydata;
		ydata = xdata - ydata;
		xdata -= ydata;
		ydata *= -1;
		ydata = fliplr(ydata);
		cdata = permute(cdata, [2, 1, 3]);
		cdata = flipud(cdata);
		set(program.image.map.handle, 'ydata', ydata);
		set(program.image.map.handle, 'xdata', xdata);
		set(program.image.map.handle, 'cdata', cdata);
	end
	program.macp.rrControl.handle = uicontrol(
		program.macp.handle,
		'string', 'Rotate right',
		'callback', @(h, e)set(program.handle, 'userdata', rrCallback(h, e, program.handle)),
		'tag', 'rrControl');
	
	function program = rlCallback(src, data, program)
		program = get(program, 'userdata');
		ydata = get(program.image.map.handle, 'ydata');
		xdata = get(program.image.map.handle, 'xdata');
		cdata = get(program.image.map.handle, 'cdata');
		xdata += ydata;
		ydata = xdata - ydata;
		xdata -= ydata;
		xdata *= -1;
		xdata = fliplr(xdata);
		cdata = permute(cdata, [2, 1, 3]);
		cdata = fliplr(cdata);
		set(program.image.map.handle, 'ydata', ydata);
		set(program.image.map.handle, 'xdata', xdata);
		set(program.image.map.handle, 'cdata', cdata);
	end
	program.macp.rlControl.handle = uicontrol(
		program.macp.handle,
		'string', 'Rotate left',
		'callback', @(h, e)set(program.handle, 'userdata', rlCallback(h, e, program.handle)),
		'tag', 'rlControl');
	
##	function program = ssCallback(src, data, program)
##		program = get(program, 'userdata');
##		control = findobj(program.macp.handle, 'tag', 'ssControl');
##		value = str2double(get(control, 'string'));
##		if !isnan(value)
##			if abs(value) < 0.1
##				return;
##			end
##			ydata = get(program.image.map.handle, 'ydata');
##			xdata = get(program.image.map.handle, 'xdata');
##			ydata *= value;
##			xdata *= value;
##			set(program.image.map.handle, 'ydata', ydata);
##			set(program.image.map.handle, 'xdata', xdata);
##		endif
##	end
##	tmp = uipanel(program.macp.handle);
##	program.macp.ssControl.handle = uicontrol(
##		tmp,
##		'style', 'edit',
##		'tag', 'ssControl');
##	uicontrol(
##		tmp,
##		'string', 'Set scale',
##		'callback', @(h, e)set(program.handle, 'userdata', ssCallback(h, e, program.handle)));
##	organizePanel(tmp, 2, 1);
	
	function program = slsCallback(src, data, program)
		program = get(program, 'userdata');
		set(src, 'string', 'Select launch site.');
		waitforbuttonpress;
		cp = get(program.image.handle, 'currentpoint');
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
		xdata = get(program.image.map.handle, 'xdata');
		ydata = get(program.image.map.handle, 'ydata');
		xdata -= x;
		ydata -= y;
		set(program.image.map.handle, 'xdata', xdata);
		set(program.image.map.handle, 'ydata', ydata);
		set(src, 'string', 'Set launch site');
	end
	program.macp.sControl.handle = uicontrol(
		program.macp.handle,
		'string', 'Set launch site',
		'callback', @(h, e)set(program.handle, 'userdata', slsCallback(h, e, program.handle)),
		'tag', 'sControl');
	
	function program = sCallback(src, data, program)
		program = get(program, 'userdata');
		set(src, 'string', 'Select point 1.');
		waitforbuttonpress;
		cp = get(program.image.handle, 'currentpoint');
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
		marker1 = plot3(program.image.handle,x1,y1,1, 'marker', '*', 'color', 'red', 'displayname', 'Scaler marker 1');
		waitforbuttonpress;
		cp = get(program.image.handle, 'currentpoint');
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
		marker2 = plot3(program.image.handle,x2,y2,1, 'marker', '*', 'color', 'red', 'displayname', 'Scaler marker 2');
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
		xdata = get(program.image.map.handle, 'xdata');
		ydata = get(program.image.map.handle, 'ydata');
		xdata *= scale/currScale;
		ydata *= scale/currScale;
		set(program.image.map.handle, 'xdata', xdata);
		set(program.image.map.handle, 'ydata', ydata);
	end
	program.macp.sControl.handle = uicontrol(
		program.macp.handle,
		'string', 'Scale',
		'callback', @(h, e)set(program.handle, 'userdata', sCallback(h, e, program.handle)),
		'tag', 'sControl');
	
	function program = fyCallback(src, data, program)
		program = get(program, 'userdata');
		ydata = get(program.image.map.handle, 'ydata');
		ydata *= -1;
		set(program.image.map.handle, 'ydata', ydata);
	end
	program.macp.fyControl.handle = uicontrol(
		program.macp.handle,
		'string', 'Flip y',
		'callback', @(h, e)set(program.handle, 'userdata', fyCallback(h, e, program.handle)),
		'tag', 'fyControl');
	
	function program = fxCallback(src, data, program)
		program = get(program, 'userdata');
		xdata = get(program.image.map.handle, 'xdata');
		xdata *= -1;
		set(program.image.map.handle, 'xdata', xdata);
	end
	program.macp.fxControl.handle = uicontrol(
		program.macp.handle,
		'string', 'Flip x',
		'callback', @(h, e)set(program.handle, 'userdata', fxCallback(h, e, program.handle)),
		'tag', 'fxControl');
	
	organizePanel(program.macp.handle, 2, 0);
endfunction