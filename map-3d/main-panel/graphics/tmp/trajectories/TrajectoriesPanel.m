function trajectoriesPanel = TrajectoriesPanel(auxPanel)
	trajectoriesPanel.handle = uipanel(
		auxPanel.handle,
		'tag', 'auxCtrl',
		'visible', 'off');
	trajectoriesPanel.pwd = pwd;
	addpath(pwd);
	
	trajectoriesPanel.addRemoveTrajectoryPanel.handle = uipanel(trajectoriesPanel.handle);
		trajectoriesPanel.addTrajectoryButton.handle = uicontrol(
			trajectoriesPanel.addRemoveTrajectoryPanel.handle,
			'string', 'Add trajectory',
			'units', 'normalized', 'position', [.0, .5, 1, .5],
			'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', addTrajectoryAction(h, e, auxPanel.map3D.handle)),
			'tag', 'Add trajectory');;
	
	cd(strjoin({auxPanel.map3D.pwd, "util"}, filesep));
	organizePanel(trajectoriesPanel.handle, 2, 0);
endfunction