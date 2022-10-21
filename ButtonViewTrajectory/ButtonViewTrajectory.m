function program = ButtonViewTrajectory(program)
	program.handle = figure('visible', 'off');
	program.image.handle = axes(program.handle, 'tag', 'image', 'outerposition', [.2 .2 .8 .8]);
	hold(program.image.handle, 'on');
	title(program.image.handle, program.file.title);
	grid(program.image.handle, 'on');
	xlabel(program.image.handle, "East");
	ylabel(program.image.handle, "North");
	zlabel(program.image.handle, "Up");
	program.image.trajectory.handle = line(program.image.handle, NaN, NaN, NaN, 'tag', 'trajectory', 'displayname', 'Trajectory');
	program.legend.handle = legend(program.image.handle, 'location', 'northeast');
	program.image.gsMarker.handle = line(program.image.handle, NaN, NaN, NaN, 'marker', '*', 'color', 'red', 'tag', 'GSMarker', 'userdata', '', 'displayname', 'Ground station', 'visible', 'off');
	program.image.gsConeLine1.handle = line(program.image.handle, [NaN NaN], [NaN NaN], [NaN NaN], 'color', 'red', 'tag', 'GSCone1', 'userdata', '', 'displayname', 'Aperture line 1', 'visible', 'off');
	program.image.gsConeLine2.handle = line(program.image.handle, [NaN NaN], [NaN NaN], [NaN NaN], 'color', 'red', 'tag', 'GSCone2', 'userdata', '', 'displayname', 'Aperture line 2', 'visible', 'off');
	program.image.map.handle = image(program.image.handle);
	set(program.image.map.handle, 'tag', 'map', 'userdata', []);
	program.mcp.handle = uipanel(
		program.handle,
		'position', [.0 .2 .2 .8],
		'tag', 'mainCtrl');
	program.evacp.handle = uipanel(
		program.handle,
		'position', [.0 .0 1 .2],
		'tag', 'auxCtrl',
		'visible', 'off');
	program.gsacp.handle = uipanel(
		program.handle,
		'position', [.0 .0 1 .2],
		'tag', 'auxCtrl',
		'visible', 'off');
	program.lacp.handle = uipanel(
		program.handle,
		'position', [.0 .0 1 .2],
		'tag', 'auxCtrl',
		'visible', 'off');
	program.macp.handle = uipanel(
		program.handle,
		'position', [.0 .0 1 .2],
		'tag', 'auxCtrl',
		'visible', 'off');
	program.tacp.handle = uipanel(
		program.handle,
		'position', [.0 .0 1 .2],
		'tag', 'auxCtrl',
		'visible', 'off');
	program.emacp.handle = uipanel(
		program.handle,
		'position', [.0 .0 1 .2],
		'tag', 'auxCtrl',
		'visible', 'on');
	set(program.handle, 'userdata', program);
	
##	program = renderTrajectory(program);
	program = createMCP(program);
	program = createEvACP(program);
	program = createGSACP(program);
	program = createLACP(program);
	program = createMACP(program);
	program = createTACP(program);
	program = createEmACP(program);
	set(program.handle, 'userdata', program);
	
	get(program.tacp.stepControl.handle, 'callback')(program.tacp.stepControl.handle, [], program)
	
	set(program.handle, 'visible', 'on');
	waitfor(program.handle);
endfunction