function auxPanel = AuxPanel(map3D)
	auxPanel.handle = uipanel(
		map3D.handle,
		'position', [.0 .0 1 .2],
		'tag', 'auxPanel');
	auxPanel.map3D = map3D;
	
##	cd(strjoin({auxPanel.pwd, "events-panel"}, filesep));
##	auxPanel.eventsPanel = EventsPanel(auxPanel);
##	set(auxPanel.eventsPanel.handle, 'units', 'normalized', 'position', [.0 .0 1 1]);
##	cd(strjoin({auxPanel.pwd, "legends-panel"}, filesep));
##	auxPanel.legendsPanel = LegendsPanel(auxPanel);
##	set(auxPanel.legendsPanel.handle, 'units', 'normalized', 'position', [.0 .0 1 1]);
##	cd(strjoin({auxPanel.pwd, "maps-panel"}, filesep));
##	auxPanel.mapsPanel = MapsPanel(auxPanel);
##	set(auxPanel.mapsPanel.handle, 'units', 'normalized', 'position', [.0 .0 1 1]);
##	cd(strjoin({auxPanel.pwd, "trajectories-panel"}, filesep));
##	auxPanel.trajectoriesPanel = TrajectoriesPanel(auxPanel);
##	set(auxPanel.trajectoriesPanel.handle, 'units', 'normalized', 'position', [.0 .0 1 1]);
##	cd(strjoin({auxPanel.pwd, "graphics-panel"}, filesep));
	
	auxPanel.graphicsPanel = GraphicsPanel(auxPanel);
	set(auxPanel.graphicsPanel.handle, 'units', 'normalized', 'position', [.0 .0 1 1]);
endfunction