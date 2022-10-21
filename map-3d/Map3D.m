function program = Map3D(program)
	map3D.handle = figure('visible', 'off');
	map3D.program = program;
	
	map3D.canvas = Canvas(map3D);
	map3D.mainPanel = MainPanel(map3D);
##	map3D.auxPanel = AuxPanel(map3D);
	
	set(map3D.handle, 'userdata', map3D);
	set(map3D.handle, 'visible', 'on');
	waitfor(map3D.handle);
	
	program.map3D = map3D;
endfunction