function program = createLACP(program)
	function program = fontUnitsCallback(src, data, program)
		program = get(program, 'userdata');
		choices = {"centimeters", "inches", "normalized", "pixels", "points"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(program.legend.handle, 'fontunits', value);
		control = findobj(program.lacp.handle, 'tag', 'SetFontControl');
		set(control, 'string', num2str(get(program.legend.handle, 'fontsize')));
	end
	program.lacp.fontUnitsControl.handle = uicontrol(
		program.lacp.handle,
		'string', 'Set font units',
		'callback', @(h, e)set(program.handle, 'userdata', fontUnitsCallback(h, e, program.handle)));
	
	function program = fontSizeCallback(src, data, program)
		program = get(program, 'userdata');
		control = findobj(program.lacp.handle, 'tag', 'SetFontControl');
		value = str2double(get(control, 'string'));
		if !isnan(value)
			set(program.legend.handle, 'fontsize', value);
		endif
	end
	tmp = uipanel(program.lacp.handle);
	program.lacp.fontControl.handle = uicontrol(
		tmp,
		'style', 'edit',
		'tag', 'SetFontControl');
	uicontrol(
		tmp,
		'string', 'Set font size',
		'callback', @(h, e)set(program.handle, 'userdata', fontSizeCallback(h, e, program.handle)));
	organizePanel(tmp, 2, 1);
	
	function program = locationCallback(src, data, program)
		program = get(program, 'userdata');
		control = findobj(program.lacp.handle, 'tag', 'SetLocationControl');
		choices = {"best", "bestoutside", "east", "eastoutside", "none", "north", "northeast", "northeastoutside", "northoutside", "northwest", "northwestoutside", "south", "southeast", "southeastoutside", "southoutside", "southwest", "southwestoutside", "west", "westoutside"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(program.legend.handle, 'location', value);
		control = findobj(program.lacp.handle, 'tag', 'SetPositionXControl');
		value = get(program.legend.handle, 'position');
		set(control, 'value', value(1));
		control = findobj(program.lacp.handle, 'tag', 'SetPositionYControl');
		value = get(program.legend.handle, 'position');
		set(control, 'value', value(2));
	end
	program.lacp.locationControl.handle = uicontrol(
		program.lacp.handle,
		'string', 'Set location',
		'callback', @(h, e)set(program.handle, 'userdata', locationCallback(h, e, program.handle)));
	
	function program = positionXCallback(src, data, program)
		program = get(program, 'userdata');
		value = get(program.legend.handle, 'position');
		control = findobj(program.lacp.handle, 'tag', 'SetPositionXControl');
		value(1) = get(control, 'value');
		control = findobj(program.lacp.handle, 'tag', 'SetPositionYControl');
		value(2) = get(control, 'value');
		set(program.legend.handle, 'position', value);
	end
	tmp = uipanel(program.lacp.handle);
	program.lacp.positionXControl.handle = uicontrol(
		tmp,
		'style', 'slider',
		'callback', @(h, e)set(program.handle, 'userdata', positionXCallback(h, e, program.handle)),
		'tag', 'SetPositionXControl');
	uicontrol(
		tmp,
		'style', 'text',
		'string', 'Set position x')
	organizePanel(tmp, 2, 1);
	
	function program = positionYCallback(src, data, program)
		program = get(program, 'userdata');
		value = get(program.legend.handle, 'position');
		control = findobj(program.lacp.handle, 'tag', 'SetPositionXControl');
		value(1) = get(control, 'value');
		control = findobj(program.lacp.handle, 'tag', 'SetPositionYControl');
		value(2) = get(control, 'value');
		set(program.legend.handle, 'position', value);
	end
	tmp = uipanel(program.lacp.handle);
	program.lacp.positionYControl.handle = uicontrol(
		tmp,
		'style', 'slider',
		'callback', @(h, e)set(program.handle, 'userdata', positionYCallback(h, e, program.handle)),
		'tag', 'SetPositionYControl');
	uicontrol(
		tmp,
		'style', 'text',
		'string', 'Set position y')
	organizePanel(tmp, 2, 1);
	
	organizePanel(program.lacp.handle, 2, 0);
end