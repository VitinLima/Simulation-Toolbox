function exportKML(FILENAME, SRC, program)
  xID = find(strcmp(program.variables, "Position East of launch"));
  yID = find(strcmp(program.variables, "Position North of launch"));
  zID = find(strcmp(program.variables, "Altitude"));
	
	%Cape Canavial: Latitude -23.37074, Longitude -48.01023, altitude 636 meters above sea level
	%earth sea level at equator radius 6378.137 km
	
  %LASC LAUNCH SITE
##	lat = -23.37074;
##	lon = -48.01023;
##	alt = 636;

	%FLAT EARTH APROXIMATION -- OpenRocket Source Code
	
	%Mean Earth radius
	REARTH = 6371000.0;
	%Sidearial Earth rotation rate
	EROT = 7.2921150e-5;
	
	METERS_PER_DEGREE_LATITUDE = 111325; % "standard figure"
	METERS_PER_DEGREE_LONGITUDE_EQUATOR = 111050;
	
	METERS_PER_DEGREE_LONGITUDE = METERS_PER_DEGREE_LONGITUDE_EQUATOR * cosd(program.latitude);
	% Limit to 1 meter per degree near poles
	METERS_PER_DEGREE_LONGITUDE = max(METERS_PER_DEGREE_LONGITUDE, 1);
	
	P0 = [program.longitude; program.latitude; program.altitude];
	D = [METERS_PER_DEGREE_LATITUDE; METERS_PER_DEGREE_LONGITUDE; 1.0];
	
  FID = fopen(FILENAME,'w');
  
	fdisp(FID,"<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
	fdisp(FID,"<kml xmlns=\"http://www.opengis.net/kml/2.2\">");
	fdisp(FID,"<Document>");
  #<description> <![CDATA[ <h1>CDATA Tags are useful!</h1> <p><font color="red">Text is <i>more readable</i> and <b>easier to write</b> when you can avoid using entity references.</font></p> ]]> </description>
	
	N_src = length(SRC);
  
	for i = 1:N_src
    src = SRC(i);
    if ishandle(src)
      h = src;
      TYPE = get(h, 'tag');
      COLOR = get(h, 'color');
      LW = get(h, 'linewidth');
      src = get(h, 'userdata');
    else
      TYPE = src.type;
      COLOR = src.graphicalProperties.color;
      LW = src.graphicalProperties.lineWidth;
    end
    if ischar(COLOR)
      cs = {"k","black","r","red","g","green","b","blue","y","yellow","m","magenta","c","cyan","w","white"};
      c = find(strcmp(cs,COLOR));
      switch c
        case {1 2}
          COLOR = [0 0 0];
        case {3 4}
          COLOR = [1 0 0];
        case {5 6}
          COLOR = [0 1 0];
        case {7 8}
          COLOR = [0 0 1];
        case {9 10}
          COLOR = [1 1 0];
        case {11 12}
          COLOR = [1 0 1];
        case {13 14}
          COLOR = [0 1 1];
        case {15 16}
          COLOR = [1 1 1];
      end
    end
    if strcmp(TYPE, "nominal trajectory")
      NAME = src.title;
      
      conditionsCells = {};
      for k = 1:rows(src.conditions);
        conditionsCells(k) = [cell2mat(src.conditions(k,1)), ": ", num2str(cell2mat(src.conditions(k,2)))];
      end
      conditionsString = strjoin(conditionsCells,"<br/>");
      kmlConditions = ["<font color=\"green\">",conditionsString,";</font>"];
      
      warningsString = strjoin(src.warnings,"<br/>");
      kmlWarnings = ["<font color=\"red\">",warningsString,";</font>"];
      
      apogeeID = find(strcmp(src.evts, "APOGEE"));
      apogeeVAL = src.data(src.evtRows(apogeeID), zID);
      apogeeUNITS = cell2mat(src.units(zID));
      apogeeString = ["Apogee at ", num2str(apogeeVAL), " ", apogeeUNITS];
      
      kmlApogee = ["<font color=\"blue\">",apogeeString,";</font>"];
      
      DESCRIPTION = ["<p>",strjoin({kmlApogee,kmlConditions,kmlWarnings},"<br/>"),"</p>"];
      
      X = src.data(:,xID);
      Y = src.data(:,yID);
      Z = src.data(:,zID);
      exportKMLLine(FID, X',Y',Z', NAME, COLOR, LW, DESCRIPTION, P0, D);
    elseif strcmp(TYPE, "dispersion")
      trajectories = src.trajectories;
      nt = length(trajectories);
      wb = waitbar(0);
      for j = 1:nt
        trajectory = trajectories(j);
        
        NAME = trajectory.title;
        
        conditionsCells = {};
        for k = 1:rows(trajectory.conditions);
          conditionsCells(k) = [cell2mat(trajectory.conditions(k,1)), ": ", num2str(cell2mat(trajectory.conditions(k,2)))];
        end
        conditionsString = strjoin(conditionsCells,"<br/>");
        kmlConditions = ["<font color=\"green\">",conditionsString,";</font>"];
        
        warningsString = strjoin(trajectory.warnings,"<br/>");
        kmlWarnings = ["<font color=\"red\">",warningsString,";</font>"];
        
        apogeeID = find(strcmp(trajectory.evts, "APOGEE"));
        apogeeVAL = trajectory.data(trajectory.evtRows(apogeeID), zID);
        apogeeUNITS = cell2mat(trajectory.units(zID));
        apogeeString = ["Apogee at ", num2str(apogeeVAL), " ", apogeeUNITS];
        
        kmlApogee = ["<font color=\"blue\">",apogeeString,";</font>"];
        
        DESCRIPTION = ["<p>",strjoin({kmlApogee,kmlConditions,kmlWarnings},"<br/>"),"</p>"];
        
        X = trajectory.data(:,xID);
        Y = trajectory.data(:,yID);
        Z = trajectory.data(:,zID);
        exportKMLLine(FID, X',Y',Z', NAME, COLOR, LW, DESCRIPTION, P0, D);
        if !ishandle(wb)
          waitfor(msgbox("Operation cancelled by user."));
        end
        waitbar(j/nt, wb);
      end
      close(wb);
    elseif strcmp(TYPE, "dispersion ellipsis")
      NAME = [src.title, " ellipsis"];
      
      if !isempty(src.conditions)
        conditionsCells = {};
        for k = 1:rows(src.conditions);
          conditionsCells(k) = [cell2mat(src.conditions(k,1)), ": ", num2str(cell2mat(src.conditions(k,2)))];
        end
        conditionsString = strjoin(conditionsCells,"<br/>");
        kmlConditions = ["<font color=\"blue\">",conditionsString,";</font>"];
      else
        kmlConditions = ["<font color=\"blue\">Total dispersion</font>"];
      end
      
      X = src.data(:,1);
      Y = src.data(:,2);
      characteristics = characterizeEllipsis([X, Y]);
      characteristicsCells = {};
      characteristicsCells(1) = ["Main axis radius: ", characteristics.mainAxisRadius];
      characteristicsCells(2) = ["Secondary axis radius: ", characteristics.secondaryAxisRadius];
      characteristicsCells(3) = ["Main axis rotation angle: ", characteristics.mainAxisRotationAngle];
      characteristicsCells(4) = ["Center east position: ", characteristics.centerEastPosition];
      characteristicsCells(5) = ["Center north position: ", characteristics.centerEastPosition];
      characteristicsString = strjoin(characteristicsCells,"<br/>");
      kmlCharacteristics = ["<font color=\"green\">",characteristicsString,";</font>"];
      
      DESCRIPTION = ["<p>",strjoin({kmlConditions,kmlCharacteristics},"<br/>"),"</p>"];
      
      exportKMLLine(FID, X',Y',[], NAME, COLOR, LW, DESCRIPTION, P0, D);
    elseif strcmp(TYPE, "impact points")
    end
	end
	fdisp(FID,"</Document>");
	fdisp(FID,"</kml>");
	fclose(FID);
end