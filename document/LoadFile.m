function program = LoadFile(program)
  flt = {"*.csv","ASCII file";"*.b","Octave binary"};
  [FNAME,FPATH,FLTIDX] = uigetfile(flt,"File name:", program.transient.lastLoadedDirectory);
  if FNAME==0
    return;
  end
  if FLTIDX == 1
    newProgram = LoadCSV([FPATH, filesep, FNAME]);
  else
    newProgram = load([FPATH, filesep, FNAME]);
    newProgram = newProgram.program;
  endif
  newProgram.transient = program.transient;
  newProgram.transient.lastLoadedDirectory = FPATH;
  program = newProgram;
end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  ##	title = "File formatting";
  ##	prompt = {"Field separator:", "Comment:"};
  ##	rowscols = [1, 1];
  ##	defaults = {",", "#"};
  ##	cstr = inputdlg(prompt, title, rowscols, defaults);
  ##	
  ##	if isempty(cstr)
  ##		return;
  ##	end
  ##	
  ##	fieldSeparator = cell2mat(cstr(1));
  ##	commentCharacter = cell2mat(cstr(2));
  ##	
  ##	NFieldSeparator = length(fieldSeparator);
  ##	NCommentCharacter = length(commentCharacter);
  ##	
  ##	[fid, MSG] = fopen(strjoin({FPATH, FNAME}, filesep));
  ##	if fid == -1
  ##		waitfor(msgbox(MSG));
  ##		return;
  ##	endif
  ##	
  ##	[nominalTrajectory, ok] = LoadSimulationFromFileID(fid, fieldSeparator, NFieldSeparator, commentCharacter, NCommentCharacter);
  ##	nominalTrajectory.description.header = "Nominal trajectory";
  ##	nominalTrajectory = FormatUnits(nominalTrajectory, program.defaultUnitSystem);
  ##	
  ##	impactDispersion = [];
  ##	impactDispersion.trajectories = {};
  ##	do
  ##		[trajectory, ok] = LoadSimulationFromFileID(fid, fieldSeparator, NFieldSeparator, commentCharacter, NCommentCharacter);
  ##		if ok
  ##			trajectory = FormatUnits(trajectory, program.defaultUnitSystem);
  ##			trajectory.description.header = "Impact dispersion trajectory";
  ##			trajectory.description.tags = {};
  ##			impactDispersion.trajectories(end+1) = trajectory;
  ##		endif
  ##	until !ok
  ##	
  ##	debrisDispersion = [];
  ##	
  ##	program.nominalTrajectory = nominalTrajectory;
  ##	program.impactDispersion = impactDispersion;
  ##	program.debrisDispersion = debrisDispersion;
  ##	
  ##	fclose(fid);