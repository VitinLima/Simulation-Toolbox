function legendsPanel = LegendsPanel(auxPanel)
	legendsPanel.handle = uipanel(
		auxPanel.handle,
		'tag', 'auxCtrl',
		'visible', 'off');
	legendsPanel.pwd = pwd;
	addpath(pwd);
	
	legendsPanel.fontUnitsControl.handle = uicontrol(
		legendsPanel.handle,
		'string', 'Set font units',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', fontUnitsAction(h, e, auxPanel.map3D.handle)));
	
	legendsPanel.fontControl.handle = uipanel(legendsPanel.handle);
		legendsPanel.fontControl.textHandle = uicontrol(
			legendsPanel.fontControl.handle,
			'units', 'normalized', 'position', [.0, .5, 1, .5],
			'style', 'edit',
			'tag', 'SetFontControl');
		legendsPanel.fontControl.buttonHandle = uicontrol(
			legendsPanel.fontControl.handle,
			'units', 'normalized', 'position', [.0, .0, 1, .5],
			'string', 'Set font size',
			'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', fontSizeAction(h, e, auxPanel.map3D.handle)));
	
	legendsPanel.locationControl.handle = uicontrol(
		legendsPanel.handle,
		'string', 'Set location',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', locationAction(h, e, auxPanel.map3D.handle)));
	
	legendsPanel.positionXControl.handle = uipanel(legendsPanel.handle);
		legendsPanel.positionXControl.buttonHandle = uicontrol(
			legendsPanel.positionXControl.handle,
			'units', 'normalized', 'position', [.0, .0, 1, .5],
			'style', 'slider',
			'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', positionXAction(h, e, auxPanel.map3D.handle)),
			'tag', 'SetPositionXControl');
		legendsPanel.positionXControl.textHandle = uicontrol(
			legendsPanel.positionXControl.handle,
			'units', 'normalized', 'position', [.0, .5, 1, .5],
			'style', 'text',
			'string', 'Set position x');
	
	legendsPanel.positionYControl.handle = uipanel(legendsPanel.handle);
		legendsPanel.positionYControl.buttonHandle = uicontrol(
			legendsPanel.positionYControl.handle,
			'units', 'normalized', 'position', [.0, .0, 1, .5],
			'style', 'slider',
			'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', positionYAction(h, e, auxPanel.map3D.handle)),
			'tag', 'SetPositionYControl');
		legendsPanel.positionYControl.textHandle = uicontrol(
			legendsPanel.positionYControl.handle,
			'units', 'normalized', 'position', [.0, .5, 1, .5],
			'style', 'text',
			'string', 'Set position y');
	
	cd(strjoin({auxPanel.map3D.pwd, "util"}, filesep));
	organizePanel(legendsPanel.handle, 2, 0);
end