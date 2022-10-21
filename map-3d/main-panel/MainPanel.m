function mainPanel = MainPanel(map3D)
	mainPanel.handle = uipanel(
		map3D.handle,
		'position', [.0 0 .2 1],
		'tag', 'mainPanel');
	mainPanel.map3D = map3D;
	
	mainPanel.nominalTrajectoryButton.handle = uicontrol(
		mainPanel.handle,
		'string', 'nominal trajectory',
		'callback', @(h, e)set(mainPanel.map3D.handle, 'userdata', NominalTrajectoryAction(h, e, mainPanel.map3D.handle)),
		'tag', 'nominalTrajectoryButton');
	
	mainPanel.trajectoryDispersionButton.handle = uicontrol(
		mainPanel.handle,
		'string', 'trajectory dispersion',
		'callback', @(h, e)set(mainPanel.map3D.handle, 'userdata', TrajectoryDispersionAction(h, e, mainPanel.map3D.handle)),
		'tag', 'trajectoryDispersionButton');
  
	mainPanel.mapsButton.handle = uicontrol(
		mainPanel.handle,
		'string', 'map',
		'callback', @(h, e)set(mainPanel.map3D.handle, 'userdata', MapAction(h, e, mainPanel.map3D.handle)),
		'tag', 'mapButton');
	
	mainPanel.exportButton.handle = uicontrol(
		mainPanel.handle,
		'string', 'export',
		'callback', @(h, e)set(mainPanel.map3D.handle, 'userdata', ExportAction(h, e, mainPanel.map3D.handle)),
		'tag', 'TrajectoriesButton');
		
	organizePanel(mainPanel.handle, 0, 1);
endfunction