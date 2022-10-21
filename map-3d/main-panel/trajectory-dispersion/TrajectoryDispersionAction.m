function map3D = TrajectoryDispersionAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
  variables = map3D.program.variables;
	impactDispersion = map3D.program.impactDispersion;
  xID = find(strcmp(variables, "Position East of launch"));
  yID = find(strcmp(variables, "Position North of launch"));
  zID = find(strcmp(variables, "Altitude"));
  
	choices = {
    "trajectories",
		"ellipsis",
		"impact points"};
	
	KEYVALUE = {
		"ListString", choices,
		"SelectionMode", "Single",
		"InitialValue", 1,
		"Name", "Statistics functions",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "Back"
		}';
  
  do
    [SEL, OK] = listdlg(KEYVALUE{1:end});
    if !OK
      continue;
    end
    switch SEL
      case 1
        Trajectories(map3D);
      case 2
        Ellipsis(map3D);
      case 3
        ImpactPoints(map3D);
    end
  until !OK
end