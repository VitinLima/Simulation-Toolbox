function map3D = setStepAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	eastIdx = find(strcmp(map3D.file.variables, "Position East of launch"));
	northIdx = find(strcmp(map3D.file.variables, "Position North of launch"));
	altitudeIdx = find(strcmp(map3D.file.variables, "Altitude"));
	
	map3D.auxPanel.trajectoriesPanel.stepControl.value = get(src, 'value')*0.8 + 0.02;
	
	X = map3D.file.data(:,eastIdx);
	Y = map3D.file.data(:,northIdx);
	Z = map3D.file.data(:,altitudeIdx);
	
	dx = ceil(length(X)*map3D.auxPanel.trajectoriesPanel.stepControl.value);
	X = X(1:dx:end);
	dy = ceil(length(Y)*map3D.auxPanel.trajectoriesPanel.stepControl.value);
	Y = Y(1:dy:end);
	dz = ceil(length(Z)*map3D.auxPanel.trajectoriesPanel.stepControl.value);
	Z = Z(1:dz:end);

	set(map3D.canvas.trajectory.handle, 'xdata', X, 'ydata', Y, 'zdata', Z);
end