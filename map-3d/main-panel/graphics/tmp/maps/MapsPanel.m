function mapsPanel = MapsPanel(auxPanel)
	mapsPanel.handle = uipanel(
		auxPanel.handle,
		'tag', 'auxCtrl',
		'visible', 'off');
	mapsPanel.pwd = pwd;
	addpath(pwd);

	mapsPanel.setMapButton = uicontrol(
		mapsPanel.handle,
		'string', "Set map",
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', setMapButtonAction(h, e, auxPanel.map3D.handle)),
		'tag', 'setMapButton');
	
##	function auxPanel.map3D = tixAction(src, data, auxPanel.map3D)
##		auxPanel.map3D = get(auxPanel.map3D, 'userdata');
##		control = findobj(mapsPanel.handle, 'tag', 'tixButton');
##		value = str2double(get(control, 'string'));
##		if !isnan(value)
##			xdata = get(auxPanel.map3D.canvas.map.handle, 'xdata');
##			xdata += value;
##			set(auxPanel.map3D.canvas.map.handle, 'xdata', xdata);
##		endif
##	end
##	tmp = uipanel(mapsPanel.handle);
##	mapsPanel.tixButton.handle = uicontrol(
##		tmp,
##		'style', 'edit',
##		'tag', 'tixButton');
##	uicontrol(
##		tmp,
##		'string', 'Translate canvas x',
##		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', tixAction(h, e, auxPanel.map3D.handle)));
##	organizePanel(tmp, 2, 1);
##	
##	function auxPanel.map3D = tiyAction(src, data, auxPanel.map3D)
##		auxPanel.map3D = get(auxPanel.map3D, 'userdata');
##		control = findobj(mapsPanel.handle, 'tag', 'tiyButton');
##		value = str2double(get(control, 'string'));
##		if !isnan(value)
##			ydata = get(auxPanel.map3D.canvas.map.handle, 'ydata');
##			ydata += value;
##			set(auxPanel.map3D.canvas.map.handle, 'ydata', ydata);
##		endif
##	end
##	tmp = uipanel(mapsPanel.handle);
##	mapsPanel.tiyButton.handle = uicontrol(
##		tmp,
##		'style', 'edit',
##		'tag', 'tiyButton');
##	uicontrol(
##		tmp,
##		'string', 'Translate canvas y',
##		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', tiyAction(h, e, auxPanel.map3D.handle)));
##	organizePanel(tmp, 2, 1);
	
	mapsPanel.rrButton.handle = uicontrol(
		mapsPanel.handle,
		'string', 'Rotate right',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', rrAction(h, e, auxPanel.map3D.handle)),
		'tag', 'rrButton');
	
	mapsPanel.rlButton.handle = uicontrol(
		mapsPanel.handle,
		'string', 'Rotate left',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', rlAction(h, e, auxPanel.map3D.handle)),
		'tag', 'rlButton');
	
##	function auxPanel.map3D = ssAction(src, data, auxPanel.map3D)
##		auxPanel.map3D = get(auxPanel.map3D, 'userdata');
##		control = findobj(mapsPanel.handle, 'tag', 'ssButton');
##		value = str2double(get(control, 'string'));
##		if !isnan(value)
##			if abs(value) < 0.1
##				return;
##			end
##			ydata = get(auxPanel.map3D.canvas.map.handle, 'ydata');
##			xdata = get(auxPanel.map3D.canvas.map.handle, 'xdata');
##			ydata *= value;
##			xdata *= value;
##			set(auxPanel.map3D.canvas.map.handle, 'ydata', ydata);
##			set(auxPanel.map3D.canvas.map.handle, 'xdata', xdata);
##		endif
##	end
##	tmp = uipanel(mapsPanel.handle);
##	mapsPanel.ssButton.handle = uicontrol(
##		tmp,
##		'style', 'edit',
##		'tag', 'ssButton');
##	uicontrol(
##		tmp,
##		'string', 'Set scale',
##		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', ssAction(h, e, auxPanel.map3D.handle)));
##	organizePanel(tmp, 2, 1);
	
	mapsPanel.sButton.handle = uicontrol(
		mapsPanel.handle,
		'string', 'Set launch site',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', slsAction(h, e, auxPanel.map3D.handle)),
		'tag', 'sButton');
	
	mapsPanel.sButton.handle = uicontrol(
		mapsPanel.handle,
		'string', 'Scale',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', sAction(h, e, auxPanel.map3D.handle)),
		'tag', 'sButton');
	
	mapsPanel.fyButton.handle = uicontrol(
		mapsPanel.handle,
		'string', 'Flip y',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', fyAction(h, e, auxPanel.map3D.handle)),
		'tag', 'fyButton');
	
	mapsPanel.fxButton.handle = uicontrol(
		mapsPanel.handle,
		'string', 'Flip x',
		'callback', @(h, e)set(auxPanel.map3D.handle, 'userdata', fxAction(h, e, auxPanel.map3D.handle)),
		'tag', 'fxButton');
	
	cd(strjoin({auxPanel.map3D.pwd, "util"}, filesep));
	organizePanel(mapsPanel.handle, 2, 0);
endfunction