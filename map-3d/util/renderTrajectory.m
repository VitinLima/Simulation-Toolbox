function program = renderTrajectory(program)
	timeIdx = find(strcmp(program.file.variables, "Time"));
	eastIdx = find(strcmp(program.file.variables, "Position East of launch"));
	northIdx = find(strcmp(program.file.variables, "Position North of launch"));
	altitudeIdx = find(strcmp(program.file.variables, "Altitude"));
	
	t = program.file.data(:,timeIdx);
	X = program.file.data(:,eastIdx);
	Y = program.file.data(:,northIdx);
	Z = program.file.data(:,altitudeIdx);
	
	dx = ceil(length(X)*program.tacp.stepControl.value);
	X = X(1:dx:end);
	dy = ceil(length(Y)*program.tacp.stepControl.value);
	Y = Y(1:dy:end);
	dz = ceil(length(Z)*program.tacp.stepControl.value);
	Z = Z(1:dz:end);
	
	hold(program.image.handle, 'on');
	trajectory = findobj(program.image.handle, 'type', 'line', 'tag', 'trajectory', 'displayname', 'Trajectory');
	set(trajectory, 'xdata', X, 'ydata', Y, 'zdata', Z);
	title(program.image.handle, program.file.title);
	grid(program.image.handle, 'on');
	xlabel(program.image.handle, "East");
	ylabel(program.image.handle, "North");
	zlabel(program.image.handle, "Up");
endfunction