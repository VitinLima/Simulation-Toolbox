function program = createTACP(program)
	function program = colorCallback(src, data, program)
		program = get(program, 'userdata');
		choices = {"yellow", "blue", "black", "cyan", "green", "magenta", "red", "white"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(program.image.trajectory.handle, 'color', value);
	end
	program.tacp.colorControl.handle = uicontrol(
		program.tacp.handle,
		'string', 'Set color',
		'callback', @(h, e)set(program.handle, 'userdata', colorCallback(h, e, program.handle)));
	
	function program = setStepCallback(src, data, program)
		program = get(program, 'userdata');
		eastIdx = find(strcmp(program.file.variables, "Position East of launch"));
		northIdx = find(strcmp(program.file.variables, "Position North of launch"));
		altitudeIdx = find(strcmp(program.file.variables, "Altitude"));
		
		program.tacp.stepControl.value = get(src, 'value')*0.8 + 0.02;
		
		X = program.file.data(:,eastIdx);
		Y = program.file.data(:,northIdx);
		Z = program.file.data(:,altitudeIdx);
		
		dx = ceil(length(X)*program.tacp.stepControl.value);
		X = X(1:dx:end);
		dy = ceil(length(Y)*program.tacp.stepControl.value);
		Y = Y(1:dy:end);
		dz = ceil(length(Z)*program.tacp.stepControl.value);
		Z = Z(1:dz:end);

		set(program.image.trajectory.handle, 'xdata', X, 'ydata', Y, 'zdata', Z);
	end
	tmp = uipanel(program.tacp.handle);
	program.tacp.stepControl.handle = uicontrol(
		tmp,
		'style', 'slider',
		'callback', @(h, e)set(program.handle, 'userdata', setStepCallback(h, e, program.handle)),
		'tag', 'stepControl');
	uicontrol(
		tmp,
		'style', 'text',
		'string', "Set plot step");
	organizePanel(tmp, 2, 1);
	
	function program = lineWidthCallback(src, data, program)
		program = get(program, 'userdata');
		control = findobj(program.tacp.handle, 'tag', 'SetLineWidthControl');
		value = str2double(get(control, 'string'));
		if !isnan(value)
			set(program.image.trajectory.handle, 'linewidth', value);
		endif
	end
	tmp = uipanel(program.tacp.handle);
	program.tacp.lineWidthControl.handle = uicontrol(
		tmp,
		'style', 'edit',
		'tag', 'SetLineWidthControl');
	uicontrol(
		tmp,
		'string', 'Set line width',
		'callback', @(h, e)set(program.handle, 'userdata', lineWidthCallback(h, e, program.handle)));
	organizePanel(tmp, 2, 1);
	
	function program = lineStyleCallback(src, data, program)
		program = get(program, 'userdata');
		choices = {"-", "--", "-.", ":", "none"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(program.image.trajectory.handle, 'linestyle', value);
	end
	program.tacp.lineStyleControl.handle = uicontrol(
		program.tacp.handle,
		'string', 'Set line style',
		'callback', @(h, e)set(program.handle, 'userdata', lineStyleCallback(h, e, program.handle)),
		'tag', 'lineStyleControl');
	
	organizePanel(program.tacp.handle, 2, 0);
endfunction