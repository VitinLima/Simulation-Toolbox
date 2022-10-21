function graphicsPanel = GraphicsPanel(auxPanel)
	graphicsPanel.handle = uipanel(
		auxPanel.handle,
		'tag', 'auxCtrl',
		'visible', 'on');
##	graphicsPanel.pwd = pwd;
##	addpath(strjoin({graphicsPanel.pwd, "axes"}, filesep));
##	addpath(strjoin({graphicsPanel.pwd, "images"}, filesep));
##	addpath(strjoin({graphicsPanel.pwd, "lines"}, filesep));
##	addpath(strjoin({graphicsPanel.pwd, "patches"}, filesep));
##	addpath(strjoin({graphicsPanel.pwd, "surfaces"}, filesep))
##	addpath(strjoin({graphicsPanel.pwd, "texts"}, filesep));;
##	addpath(strjoin({graphicsPanel.pwd, "graphical-functions"}, filesep));
	
##	graphicsPanel.stepButton.handle = uipanel(graphicsPanel.handle);
##		graphicsPanel.stepButton.buttonHandle = uicontrol(
##			graphicsPanel.stepButton.handle,
##			'units', 'normalized', 'position', [.0, .0, 1, .5],
##			'style', 'slider',
##			'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', setStepAction(h, e, auxPanel.map3D.handle)),
##			'tag', 'stepButton');
##		graphicsPanel.stepButton.textHandle = uicontrol(
##			graphicsPanel.stepButton.handle,
##			'units', 'normalized', 'position', [.0, .5, 1, .5],
##			'style', 'text',
##			'string', "Set plot step");
##	
##	graphicsPanel.lineWidthButton.handle = uipanel(graphicsPanel.handle);
##		graphicsPanel.lineWidthButton.textHandle = uicontrol(
##			graphicsPanel.lineWidthButton.handle,
##			'units', 'normalized', 'position', [.0, .5, 1, .5],
##			'style', 'edit',
##			'tag', 'SetLineWidthButton');
##		graphicsPanel.lineWidthButton.buttonHandle = uicontrol(
##			graphicsPanel.lineWidthButton.handle,
##			'units', 'normalized', 'position', [.0, .0, 1, .5],
##			'string', 'Set line width',
##			'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', lineWidthAction(h, e, auxPanel.map3D.handle)));
##	
##	graphicsPanel.lineStyleButton.handle = uicontrol(
##		graphicsPanel.handle,
##		'string', 'Set line style',
##		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', lineStyleAction(h, e, auxPanel.map3D.handle)),
##		'tag', 'lineStyleButton');
	
	graphicsPanel.axesButton.handle = uicontrol(
		graphicsPanel.handle,
		'string', 'Axes',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', AxeAction(h, e, auxPanel.map3D.handle)));
	
	graphicsPanel.imagesButton.handle = uicontrol(
		graphicsPanel.handle,
		'string', 'Images',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', ImageAction(h, e, auxPanel.map3D.handle)));
	
	graphicsPanel.lineAction.handle = uicontrol(
		graphicsPanel.handle,
		'string', 'Line',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', LineAction(h, e, auxPanel.map3D.handle)));
	
	graphicsPanel.patchAction.handle = uicontrol(
		graphicsPanel.handle,
		'string', 'Patch',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', PatchAction(h, e, auxPanel.map3D.handle)));
	
	graphicsPanel.surfaceAction.handle = uicontrol(
		graphicsPanel.handle,
		'string', 'Surface',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', SurfaceAction(h, e, auxPanel.map3D.handle)));
	
	graphicsPanel.textAction.handle = uicontrol(
		graphicsPanel.handle,
		'string', 'Text',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', TextAction(h, e, auxPanel.map3D.handle)));
	
	organizePanel(graphicsPanel.handle, 2, 0);
end