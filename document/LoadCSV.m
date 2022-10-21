function program = LoadCSV(varargin)
##	TEMPLATE = "%s %f %s %s %s %s %f %s %s %f %s";
##	[~,v1,~,~,~,~,v2,~,~,v3,~, COUNT, ERRMSG] = fscanf (FID, TEMPLATE, "C");
  FILENAME = cell2mat(varargin(1));
  if length(varargin)==1
    title = "File formatting";
    prompt = {"Field separator:", "Comment:"};
    rowscols = [1, 1];
    defaults = {",", "#"};
    cstr = inputdlg(prompt, title, rowscols, defaults);
    
    if isempty(cstr)
      return;
    end
    
    fieldSeparator = cell2mat(cstr(1));
    commentCharacter = cell2mat(cstr(2));
  else
    FILEFORMAT = cell2mat(varargin(2));
    fieldSeparator = FILEFORMAT.fieldSeparator;
    commentCharacter = FILEFORMAT.commentCharacter;
  end
	
	NFieldSeparator = length(fieldSeparator);
	NCommentCharacter = length(commentCharacter);
	
	[FID, MSG] = fopen(FILENAME, "r");
	
	if FID == -1
		waitfor(msgbox(MSG));
		return;
	endif
  
	loadingCancelled = false;
  do
    s = fgetl(FID);
    if s(1) == "<" && s(end) == ">"
      s([1,end]) = [];
      s = strsplit(s,",");
      cmd = cell2mat(s(1));
      args = [];
      if length(s) > 1
        args = s(2:end);
      end
      if strcmp(cmd,"NominalTrajectory")
        nominalTrajectory = LoadTrajectoryFromCSV(FID);
        nominalTrajectory.graphicalProperties.lineWidth = 2;
        nominalTrajectory.graphicalProperties.color = 'red';
        nominalTrajectory.type = "nominal trajectory";
      elseif strcmp(cmd,"ImpactDispersion")
        N = str2double(args);
        wb = waitbar(0);
        for i = 1:N
          impactDispersion.trajectories(i) = LoadTrajectoryFromCSV(FID);
          if !ishandle(wb)
            waitfor(msgbox("Operation cancelled by user."));
            loadingCancelled = true;
            break;
          end
          waitbar(i/N, wb);
        end
        if loadingCancelled
          continue;
        end
        impactDispersion.title = "Total dispersion";
        impactDispersion.conditions = [];
        impactDispersion.graphicalProperties.lineWidth = 2;
        impactDispersion.graphicalProperties.color = 'green';
        impactDispersion.type = "dispersion";
        close(wb);
      end
    end
  until feof(FID) || loadingCancelled;
	
	fclose(FID);
  
  impactDispersion.ellipsis = createEllipsis(impactDispersion);
  
  id = find(strcmp(nominalTrajectory.conditions(:,1), "Launch rod longitude"));
  longitude = cell2mat(nominalTrajectory.conditions(id,2));
  id = find(strcmp(nominalTrajectory.conditions(:,1), "Launch rod latitude"));
  latitude = cell2mat(nominalTrajectory.conditions(id,2));
  id = find(strcmp(nominalTrajectory.conditions(:,1), "Launch rod altitude"));
  altitude = cell2mat(nominalTrajectory.conditions(id,2));
  
  program.nominalTrajectory = nominalTrajectory;
  program.longitude = longitude;
  program.latitude = latitude;
  program.altitude = altitude;
  program.impactDispersion = impactDispersion;
  program.variables = nominalTrajectory.variables;
end