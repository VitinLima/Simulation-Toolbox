function characteristics = characterizeEllipsis(ellipsis)
  centerEastPosition = mean(ellipsis(:,1));
  centerNorthPosition = mean(ellipsis(:,2));
  
	centeredEllipsis = ellipsis - [centerEastPosition, centerNorthPosition];
	covarianceEastNorth = cov(centeredEllipsis);
	[V, lambda] = eig(covarianceEastNorth);
	mainAxisRotationAngle = atan2(V(1), V(2));
  
  d = sqrt(sum(centeredEllipsis.*centeredEllipsis, 2));
  mainAxisRadius = max(d);
  secondaryAxisRadius = min(d);
  
  characteristics.mainAxisRadius = num2str(mainAxisRadius);
  characteristics.secondaryAxisRadius = num2str(secondaryAxisRadius);
  characteristics.mainAxisRotationAngle = num2str(mainAxisRotationAngle);
  characteristics.centerEastPosition = num2str(centerEastPosition);
  characteristics.centerNorthPosition = num2str(centerNorthPosition);
end