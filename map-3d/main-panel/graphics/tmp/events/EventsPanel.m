function eventsPanel = EventsPanel(auxPanel)
	eventsPanel.handle = uipanel(
		auxPanel.handle,
		'tag', 'auxCtrl',
		'visible', 'off');
	eventsPanel.pwd = pwd;
	addpath(pwd);
	
	eventsPanel.insertEventButton = uicontrol(
		eventsPanel.handle,
		'string', "Insert event",
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', insertEventAction(h, e, auxPanel.map3D.handle)),
		'tag', 'insertEventButton');
	
	eventsPanel.removeEventButton = uicontrol(
		eventsPanel.handle,
		'string', "Remove event",
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', removeEventAction(h, e, auxPanel.map3D.handle)),
		'tag', 'removeEventButton');
	
	eventsPanel.colorControl.handle = uicontrol(
		eventsPanel.handle,
		'string', 'Set color',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', colorAction(h, e, auxPanel.map3D.handle)),
		'tag', 'colorControl');
	
	eventsPanel.markerControl.handle = uicontrol(
		eventsPanel.handle,
		'string', 'Set marker',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', markerAction(h, e, auxPanel.map3D.handle)),
		'tag', 'markerControl');
	
	eventsPanel.markerSizeControl.handle = uipanel(eventsPanel.handle);
		eventsPanel.markerSizeControl.textHandle = uicontrol(
			eventsPanel.markerSizeControl.handle,
			'units', 'normalized', 'position', [.0, .5, 1, .5],
			'style', 'edit',
			'tag', 'MarkerSizeControl');
		eventsPanel.markerSizeControl.buttonHandle = uicontrol(
			eventsPanel.markerSizeControl.handle,
			'units', 'normalized', 'position', [.0, .0, 1, .5],
			'string', 'Set marker size',
			'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', markerSizeAction(h, e, auxPanel.map3D.handle)));
	
	eventsPanel.informationDisplayedControl.handle = uicontrol(
		eventsPanel.handle,
		'string', 'Information displayed',
		'userdata', [],
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', informationDisplayedAction(h, e, auxPanel.map3D.handle)));
	
	eventsPanel.titleControl.handle = uipanel(eventsPanel.handle);
		eventsPanel.titleControl.textHandle = uicontrol(
			eventsPanel.titleControl.handle,
			'units', 'normalized', 'position', [.0, .5, 1, .5],
			'style', 'edit',
			'tag', 'TitleControl');
		eventsPanel.titleControl.buttonHandle = uicontrol(
			eventsPanel.titleControl.handle,
			'units', 'normalized', 'position', [.0, .0, 1, .5],
			'string', 'Set title',
			'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', titleAction(h, e, auxPanel.map3D.handle)));
	
	cd(strjoin({auxPanel.map3D.pwd, "util"}, filesep));
	organizePanel(eventsPanel.handle, 2, 0);
end