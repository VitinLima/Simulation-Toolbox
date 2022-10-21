function program = createEvACP(program)
	function program = colorCallback(src, data, program)
		program = get(program, 'userdata');
		marker = get(program.evacp.handle, 'userdata');
		choices = {"yellow", "blue", "black", "cyan", "green", "magenta", "red", "white"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(marker, 'color', value);
	end
	program.evacp.colorControl.handle = uicontrol(
		program.evacp.handle,
		'string', 'Set color',
		'callback', @(h, e)set(program.handle, 'userdata', colorCallback(h, e, program.handle)),
		'tag', 'colorControl');
	
	function program = markerCallback(src, data, program)
		program = get(program, 'userdata');
		marker = get(program.evacp.handle, 'userdata');
		choices = {"*", "+", ".", "<", ">", "^", "d", "diamond", "h", "hexagram", "none", "o", "p", "pentagram", "s", "square", "v", "x"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(marker, 'marker', value);
	end
	program.evacp.markerControl.handle = uicontrol(
		program.evacp.handle,
		'string', 'Set marker',
		'callback', @(h, e)set(program.handle, 'userdata', markerCallback(h, e, program.handle)),
		'tag', 'markerControl');
	
	function program = markerSizeCallback(src, data, program)
		program = get(program, 'userdata');
		marker = get(program.evacp.handle, 'userdata');
		control = findobj(program.evacp.handle, 'tag', 'MarkerSizeControl');
		set(marker, 'markersize', str2double(get(control, 'string')));
	end
	tmp = uipanel(program.evacp.handle);
	program.evacp.markerSizeControl.handle = uicontrol(
		tmp,
		'style', 'edit',
		'tag', 'MarkerSizeControl');
	uicontrol(
		tmp,
		'string', 'Set marker size',
		'callback', @(h, e)set(program.handle, 'userdata', markerSizeCallback(h, e, program.handle)));
	organizePanel(tmp, 2, 1);
	
	function program = informationDisplayedCallback(src, data, program)
		program = get(program, 'userdata');
		marker = get(program.evacp.handle, 'userdata');
		listIdx = get(src, 'userdata');
		[listIdx, OK] = listdlg(
			'PromptString', "Variables",
			'SelectionMode', 'Multiple',
			'InitialValue', listIdx,
			'ListString', program.file.variables);
		if OK
			idx = get(marker, 'userdata');
			nString = cell2mat(strsplit(get(marker, 'displayname'), '\n')(1));
			for i = listIdx
				nString = strjoin({nString, strjoin({cell2mat(program.file.variables(i)), strjoin({num2str(program.file.data(idx, i)), cell2mat(program.file.units(i))}, ' ')}, ": ")}, '\n');
			end
			set(marker, 'displayname', nString);
			set(src, 'userdata', listIdx);
		end
	end
	program.evacp.informationDisplayedControl.handle = uicontrol(
		program.evacp.handle,
		'string', 'Information displayed',
		'userdata', [],
		'callback', @(h, e)set(program.handle, 'userdata', informationDisplayedCallback(h, e, program.handle)));
	
	function program = titleCallback(src, data, program)
		program = get(program, 'userdata');
		marker = get(program.evacp.handle, 'userdata');
		control = findobj(program.evacp.handle, 'tag', 'TitleControl');
		set(marker, 'displayname', strjoin([get(control, 'string'), strsplit(get(marker, 'displayname'), '\n')(2:end)], '\n'));
	end
	tmp = uipanel(program.evacp.handle);
	program.evacp.titleControl.handle = uicontrol(
		tmp,
		'style', 'edit',
		'tag', 'TitleControl');
	uicontrol(
		tmp,
		'string', 'Set title',
		'callback', @(h, e)set(program.handle, 'userdata', titleCallback(h, e, program.handle)));
	organizePanel(tmp, 2, 1);
	
	organizePanel(program.evacp.handle, 2, 0);
end