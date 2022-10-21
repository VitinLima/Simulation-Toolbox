function displayEllipsis(map3D)
  ellipsis = map3D.program.impactDispersion.ellipsis;
  graphicalProperties = ellipsis.graphicalProperties;
  
  line(map3D.canvas.handle, ellipsis.data(:,1), ellipsis.data(:,2), 'tag', "ellipsis", 'displayname', "Dispersion ellipsis", 'color', graphicalProperties.color, 'linewidth', graphicalProperties.lineWidth, 'userdata', map3D.program.impactDispersion);
end