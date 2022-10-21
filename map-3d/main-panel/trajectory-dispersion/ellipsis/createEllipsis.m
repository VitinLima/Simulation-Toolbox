function ellipsis = createEllipsis(impactDispersion);
  trajectories = impactDispersion.trajectories;
	impactPoints = zeros(length(trajectories),2);
	for i = 1:rows(impactPoints)
		trajectory = trajectories(i);
		eastPositionID = find(strcmp(trajectory.variables, "Position East of launch"));
		northPositionID = find(strcmp(trajectory.variables, "Position North of launch"));
		impactPoints(i,:) = [trajectory.data(end,eastPositionID),trajectory.data(end,northPositionID)];
	endfor
	
	meanEast = mean(impactPoints(:,1));
	meanNorth = mean(impactPoints(:,2));
	meanedImpactPoints = impactPoints - [meanEast, meanNorth];

	covarianceEastNorth = cov(meanedImpactPoints);
	[V, lambda] = eig(covarianceEastNorth);
	rotationAngle = atan2(V(1), V(2));
	c = cos(rotationAngle);
	s = sin(rotationAngle);
	meanedRotatedImpactPoints = [c*meanedImpactPoints(:,1) + s*meanedImpactPoints(:,2), c*meanedImpactPoints(:,2) - s*meanedImpactPoints(:,1)];
	
	stdX = std(meanedRotatedImpactPoints(:,1));
	stdY = std(meanedRotatedImpactPoints(:,2));
	
	ellipsis.data = 3*[cosd(0:10:360)'*stdX, sind(0:10:360)'*stdY];
	ellipsis.data = [c*ellipsis.data(:,1) - s*ellipsis.data(:,2), c*ellipsis.data(:,2) + s*ellipsis.data(:,1)];
	ellipsis.data += [meanEast, meanNorth];
  ellipsis.graphicalProperties.lineWidth = 2;
  ellipsis.graphicalProperties.color = 'blue';
  ellipsis.type = "dispersion ellipsis";
  ellipsis.title = [impactDispersion.title, " ellipsis"];
  ellipsis.conditions = impactDispersion.conditions;
	
##	cstr = inputdlg({"Latitude coordinates:", "Longitude coordinates:"}, "Launch site coordinates");
##	if isempty(cstr)
##		return;
##	end
##	lat = str2double(cstr(1));
##	lon = str2double(cstr(2));
##	if isnan(lat) || isnan(lon)
##		return;
##	end
##	exportKMLFile(lat, lon, ellipsis);
	
##	[FileName,FilePath,Fileltidx] = uigetfile(".txt","File name:");
##	if FileName == 0
##		return;
##	endif
##	[fid, MSG] = fopen(FileName);
##	if fid == -1
##		waitfor(msgbox(MSG));
##		return;
##	endif

##	details = {};
##	data = {};
##	while (s = fgetl(fid)) != -1
##		details(end+1) = s;
##		if !isempty(s = fgetl(fid)) && s != -1
##			vals = strsplit(s,";");
##			data(end+1) = [str2double(vals(1)),str2double(vals(2))];
##			while !isempty(s = fgetl(fid)) && s != -1
##				vals = strsplit(s,";");
##				data(end) = [cell2mat(data(end));str2double(vals(1)),str2double(vals(2))];
##			endwhile
##		endif
##	endwhile
##	fclose(fid);
##
##	dataMeaned = data;
##	Mean_east = 1:length(details);
##	Mean_north = 1:length(details);
##	for i = 1:length(details)
##		points = cell2mat(data(i));
##		Mean_east(i) = mean(points(:,1));
##		Mean_north(i) = mean(points(:,2));
##		dataMeaned(i) = points - [Mean_east(i),Mean_north(i)];
##	endfor
##
##	dataRotated = data;
##	rotationAngle = 1:length(details);
##	deviation_east = 1:length(details);
##	deviation_north = 1:length(details);
##	ellipsis = {};
##	t = 0:0.1:2*pi;
##	for i = 1:length(details)
##		points = cell2mat(dataMeaned(i));
##		Covariance = cov(points);
##		[V, lambda] = eig(Covariance);
##		rotationAngle(i) = atan(V(1)/V(2));
##		pointsRotated = points;
##		for j = 1:rows(points)
##			pointsRotated(j,:) = [cos(-rotationAngle(i)),-sin(-rotationAngle(i));sin(-rotationAngle(i)),cos(-rotationAngle(i))]*points(j,:)';
##		endfor
##		dataRotated(i) = pointsRotated;
##		deviation_east(i) = std(pointsRotated(:,1));
##		deviation_north(i) = std(pointsRotated(:,2));
##		points = [3*deviation_east(i)*cos(t);3*deviation_north(i)*sin(t)]';
##		for j = 1:rows(points)
##			points(j,:) = [cos(rotationAngle(i)),-sin(rotationAngle(i));sin(rotationAngle(i)),cos(rotationAngle(i))]*points(j,:)';
##		endfor
##		points += [Mean_east(i),Mean_north(i)];
##		ellipsis(i) = points;
##	endfor

####	##details_resume = {};
####	##handles = [];
####	##figure('visible','off');
####	##grid on;
####	##axis auto;
####	##hold on;
####	##for i = 1:length(details)
####	##  s = strsplit(cell2mat(details(i)),"; ");
####	##  s1 = strsplit(cell2mat(s(1)));
####	##  s2 = strsplit(cell2mat(s(2)));
####	##  s3 = strsplit(cell2mat(s(3)));
####	##  s4 = strsplit(cell2mat(s(4)));
####	##  ellipsePoints = cell2mat(ellipsis(i));
####	##  points = cell2mat(data(i));
####	##  handles(end+1) = plot([ellipsePoints(:,1); ellipsePoints(1,1)],[ellipsePoints(:,2); ellipsePoints(1,2)],'-','tag',"line");
####	##  plot(points(:,1),points(:,2),'*','color',get(handles(end),'color'));
####	##  details_resume(end+1) = strjoin({cell2mat(s1(4)),cell2mat(s2(3)),cell2mat(s3(4)),cell2mat(s4(4))},';');
####	####  details_resume(end+1) = strjoin({cell2mat(s1(4)),cell2mat(s2(3)),cell2mat(s3(4)),cell2mat(s4(4))},';');
####	##endfor
####	##legend(handles,details_resume);
####	##set(gcf,'visible','on');
####	##hold off;
####	##
####	##filename = "elipses_points.txt";
####	##fid = fopen(filename,'w');
####	##for i = 1:length(details)
####	##  fputs(fid,strjoin(details(i),';'));
####	##  fputs(fid,"\r\n");
####	##  fputs(fid,"ellipsis");
####	##  fputs(fid,"\r\n");
####	##  points = cell2mat(ellipsis(i));
####	##  for j = 1:rows(points)
####	##    fputs(fid,num2str(points(j,1)));
####	##    fputs(fid,";");
####	##    fputs(fid,num2str(points(j,2)));
####	##    fputs(fid,"\r\n");
####	##  endfor
####	##  fputs(fid,"\r\n");
####	##  fputs(fid,"impact points");
####	##  fputs(fid,"\r\n");
####	##  points = cell2mat(data(i));
####	##  for j = 1:rows(points)
####	##    fputs(fid,num2str(points(j,1)));
####	##    fputs(fid,";");
####	##    fputs(fid,num2str(points(j,2)));
####	##    fputs(fid,"\r\n");
####	##  endfor
####	##  fputs(fid,"\r\n");
####	##endfor
####	##fclose(fid);
####
####	##elipsePadraoA = {};
####	##elipsePadraoB = {};
####	##fidkml = fopen("elipse padrao.kml",'r');
####	##while (s = fgetl(fidkml)) != -1 && !strcmp(s, "	<coordinates>")
####	##  elipsePadraoA(end+1) = s;
####	##endwhile
####	##elipsePadraoA(end+1) = s;
####	##while (s = fgetl(fidkml)) != -1 || strcmp(s,'')
####	##  elipsePadraoB(end+1) = s;
####	##endwhile
####	##fclose(fidkml);
endfunction