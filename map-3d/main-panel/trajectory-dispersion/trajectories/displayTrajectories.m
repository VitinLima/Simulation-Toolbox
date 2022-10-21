function displayTrajectories(map3D)
  variables = map3D.program.variables;
	impactDispersion = map3D.program.impactDispersion;
  graphicalProperties = impactDispersion.graphicalProperties;
  xID = find(strcmp(variables, "Position East of launch"));
  yID = find(strcmp(variables, "Position North of launch"));
  zID = find(strcmp(variables, "Altitude"));
  
  nt = length(impactDispersion.trajectories);
  x = {NaN, impactDispersion.trajectories(1).data(:,xID)'};
  y = {NaN, impactDispersion.trajectories(1).data(:,yID)'};
  z = {NaN, impactDispersion.trajectories(1).data(:,zID)'};
  for i = 2:nt
    x(end+1) = NaN;
    x(end+1) = impactDispersion.trajectories(i).data(:,xID)';
    y(end+1) = NaN;
    y(end+1) = impactDispersion.trajectories(i).data(:,yID)';
    z(end+1) = NaN;
    z(end+1) = impactDispersion.trajectories(i).data(:,zID)';
  end
  line(map3D.canvas.handle, cell2mat(x),cell2mat(y),cell2mat(z), 'tag', "dispersion trajectories", 'displayname', "Dispersion trajectories", 'color', graphicalProperties.color, 'linewidth', graphicalProperties.lineWidth, 'userdata', impactDispersion);
end