function displayNominalTrajectory(map3D)
  variables = map3D.program.variables;
	nominalTrajectory = map3D.program.nominalTrajectory;
  graphicalProperties = nominalTrajectory.graphicalProperties;
  xID = find(strcmp(variables, "Position East of launch"));
  yID = find(strcmp(variables, "Position North of launch"));
  zID = find(strcmp(variables, "Altitude"));
  
  conditions = nominalTrajectory.conditions;
  data = nominalTrajectory.data;
  x = data(:,xID);
  y = data(:,yID);
  z = data(:,zID);
  line(map3D.canvas.handle, x, y, z, 'displayname', "Nominal trajectory", 'tag', "nominal trajectory", 'color', graphicalProperties.color, 'linewidth', graphicalProperties.lineWidth, 'userdata', nominalTrajectory);
end