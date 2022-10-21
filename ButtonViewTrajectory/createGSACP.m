function program = createGSACP(program)
	function program = colorCallback(src, data, program)
		program = get(program, 'userdata');
		marker = findobj(program.image.handle, 'tag', 'GSmarker');
		choices = {"yellow", "blue", "black", "cyan", "green", "magenta", "red", "white"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(marker, 'color', value);
	end
	program.gsacp.colorControl.handle = uicontrol(
		program.gsacp.handle,
		'string', 'Set color',
		'callback', @(h, e)set(program.handle, 'userdata', colorCallback(h, e, program.handle)));
	
	function program = setGSCallback(src, data, program)
		program = get(program, 'userdata');
		if get(src, 'value')
			function program = windowButtonDownCallback(src, data, program)
				program = get(program, 'userdata');
				function program = windowButtonCallback(src, data, program)
					program = get(program, 'userdata');
					cp = get(program.image.handle, 'currentpoint');
					dz = cp(2,3) - cp(1,3);
					z = 0;
					if abs(dz) < 0.1
						x = cp(1,1);
						y = cp(1,2);
					else
						dxdz = (cp(2,1) - cp(1,1))/dz;
						x = cp(1,1) - cp(1,3)*dxdz;
						dydz = (cp(2,2) - cp(1,2))/dz;
						y = cp(1,2) - cp(1,3)*dydz;
					end
					
					xdata = get(program.image.trajectory.handle, 'xdata');
					ydata = get(program.image.trajectory.handle, 'ydata');
					zdata = get(program.image.trajectory.handle, 'zdata');
					xdata -= x;
					ydata -= y;
					zdata -= z;
					cosData = ones(length(xdata));
					dist = zeros(length(xdata), 1);
					for i = 1:(length(xdata)-1)
						for j = 2:length(xdata)
							p1 = [xdata(i) ydata(i) zdata(i)];
							p2 = [xdata(j) ydata(j) zdata(j)];
							cosData(i, j) = abs(dot(p1, p2)/(norm(p1)*norm(p2)));
						end
					end
					for i = 1:length(xdata)
						p = [xdata(i) ydata(i) zdata(i)];
						dist(i) = norm(p);
					end
					[~, p1] = min(min(cosData));
					[~, p2] = min(cosData(:,p1));
					
					set(program.image.gsMarker.handle, 'xdata', [x], 'ydata', [y], 'zdata', [z+1], 'visible', 'on');
					set(program.image.gsConeLine1.handle,
						'xdata', [x, (xdata(p1)+x)],
						'ydata', [y, (ydata(p1)+y)],
						'zdata', [z, (zdata(p1)+z)],
						'visible', 'on');
					set(program.image.gsConeLine2.handle,
						'xdata', [x, (xdata(p2)+x)],
						'ydata', [y, (ydata(p2)+y)],
						'zdata', [z, (zdata(p2)+z)],
						'visible', 'on');
					
					maxAngle = num2str(acosd(cosData(p2, p1)));
					maxDist = num2str(max(dist));
					set(findobj(program.handle, 'tag', 'ApertureAngle'), 'string', maxAngle);
					set(program.image.gsMarker.handle, 'userdata', maxAngle);
					set(findobj(program.handle, 'tag', 'MaxDistance'), 'string', maxDist);
					set(program.image.gsConeLine1.handle, 'userdata', maxDist);
				end
				if isnumeric(data)
					switch(data)
						case 1
##							set(program.handle, 'windowbuttonmotionfcn', @(h, e)set(program.handle, 'userdata', windowButtonCallback(h, e, program.handle)));
							windowButtonCallback(src, data, program.handle);
						case 3
							set(program.image.gsMarker.handle, 'xdata', [NaN], 'ydata', [NaN], 'zdata', [NaN], 'visible', 'off');
							set(program.image.gsConeLine1.handle, 'xdata', [NaN NaN], 'ydata', [NaN NaN], 'zdata', [NaN NaN], 'visible', 'off');
							set(program.image.gsConeLine2.handle, 'xdata', [NaN NaN], 'ydata', [NaN NaN], 'zdata', [NaN NaN], 'visible', 'off');
						otherwise
							
					end
					set(findobj(program.handle, 'tag', 'SetMarkerSizeControl'), 'string', num2str(get(program.image.gsMarker.handle, 'markersize')));
				end
			end
##			function program = windowButtonUpCallback(src, data, program)
##				set(program.handle, 'windowbuttonmotionfcn', {});
##			end
			set(program.handle, 'windowbuttondownfcn', @(h, e)set(program.handle, 'userdata', windowButtonDownCallback(h, e, program.handle)));
##			set(program.handle, 'windowbuttonupfcn', @(h, e)set(program.handle, 'userdata', windowButtonUpCallback(h, e, program.handle)));
##			set(program.handle, 'interruptible', 'off');
##			set(program.handle, 'busyaction', 'cancel');
		else
			set(program.handle, 'windowbuttondownfcn', {});
##			set(program.handle, 'windowbuttonupfcn', {});
##			set(program.handle, 'interruptible', 'on');
##			set(program.handle, 'busyaction', 'queue');
		endif	
	end
	program.gsacp.GSControl.handle = uicontrol(
		program.gsacp.handle,
		'style', 'togglebutton',
		'string', 'Set GS',
		'callback', @(h, e)set(program.handle, 'userdata', setGSCallback(h, e, program.handle)));
	
	function program = markerCallback(src, data, program)
		program = get(program, 'userdata');
		marker = findobj(program.image.handle, 'tag', 'GSmarker');
		choices = {"*", "+", ".", "<", ">", "^", "d", "diamond", "h", "hexagram", "none", "o", "p", "pentagram", "s", "square", "v", "x"};
		choice = menu("Set location:", choices);
		value = cell2mat(choices(choice));
		set(marker, 'marker', value);
	end
	program.gsacp.markerControl.handle = uicontrol(
		program.gsacp.handle,
		'string', 'Set marker',
		'callback', @(h, e)set(program.handle, 'userdata', markerCallback(h, e, program.handle)));
	
	function program = markerSizeCallback(src, data, program)
		program = get(program, 'userdata');
		marker = findobj(program.image.handle, 'tag', 'GSmarker');
		control = findobj(program.gsacp.handle, 'tag', 'SetMarkerSizeControl');
		set(marker, 'markersize', str2double(get(control, 'string')));
	end
	tmp = uipanel(program.gsacp.handle);
	program.gsacp.markerSizeControl.handle = uicontrol(
		tmp,
		'style', 'edit',
		'tag', 'SetMarkerSizeControl');
	uicontrol(
		tmp,
		'string', 'Set marker size',
		'callback', @(h, e)set(program.handle, 'userdata', markerSizeCallback(h, e, program.handle)));
	organizePanel(tmp, 2, 1);
	
	tmp = uipanel(program.gsacp.handle);
	uicontrol(
		tmp,
		'style', 'text',
		'string', 'Aperture angle');
	program.gsacp.apertureAngleControl.handle = uicontrol(
		tmp,
		'style', 'text',
		'tag', 'ApertureAngle');
	organizePanel(tmp, 2, 1);
	
	tmp = uipanel(program.gsacp.handle);
	uicontrol(
		tmp,
		'style', 'text',
		'string', 'Maximum distance');
	program.gsacp.maxDistanceControl.handle = uicontrol(
		tmp,
		'style', 'text',
		'tag', 'MaxDistance');
	organizePanel(tmp, 2, 1);
	
	organizePanel(program.gsacp.handle, 2, 0);
##	program.gsacp
endfunction