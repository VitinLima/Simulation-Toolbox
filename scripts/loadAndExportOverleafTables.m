clc;

% TROCAR _ POR ESPAÇO
% TIRAR ÚLTIMOS \\
% TIRAR % DA LABEL E SUBSTITUIR POR \% NA CAPTION

function writeMeanData(FID, program, VARIABLES, EVTS)
  s1 = "\\begin{table}";
  s2 = "    \\centering";
  s7 = "        \\hline";
  s9 = "    \\end{tabular}";
  s10 = "\\end{table}";
  variables = program.variables;
  units = program.nominalTrajectory.units;
  evts = program.nominalTrajectory.evts;
  statistics = analyseStatistics(program.impactDispersion.trajectories, evts, variables, units);
  VARIABLEIDXS = [];
  for j = 1:length(VARIABLES)
    VARIABLE = cell2mat(VARIABLES(j));
    VARIABLEIDXS(end+1) = find(strcmp(variables,VARIABLE));
  end
  title = program.nominalTrajectory.title;
  CAPTION = ["Mean ", title, " Data"];
  LABEL = ["tab:Aerodinâmica:",title(title!=" "),"MeanData"];
  
  s3 = ["    \\caption{",CAPTION,"}"];
  s4 = ["    \\label{tab:Aerodinâmica:",LABEL,"}"];
  s5 = ["    \\begin{tabular}{",strjoin(repmat({"c"},1,length(VARIABLES)+1),"|"),"}"];
  s6 = ["        Event & ",strjoin(VARIABLES, " & ")," \\\\"];
  fdisp(FID,s1);
  fdisp(FID,s2);
  fdisp(FID,s3);
  fdisp(FID,s4);
  fdisp(FID,s5);
  fdisp(FID,s6);
  fdisp(FID,s7);
  for j = 1:length(EVTS)
    EVT = cell2mat(EVTS(j));
    EVTIDX = find(strcmp(evts,EVT));
    VALUES = strcat("$",strsplit(num2str(statistics.meanData(VARIABLEIDXS,EVTIDX)')," "),units(VARIABLEIDXS),"$");
    s8 = ["        ",EVT," & ",strjoin(VALUES," & ")," \\\\"];
    fdisp(FID,s8);
  end
  fdisp(FID,s9);
  fdisp(FID,s10);
end
function writeStdData(FID, program, VARIABLES, EVTS)
  s1 = "\\begin{table}";
  s2 = "    \\centering";
  s7 = "        \\hline";
  s9 = "    \\end{tabular}";
  s10 = "\\end{table}";
  variables = program.variables;
  units = program.nominalTrajectory.units;
  evts = program.nominalTrajectory.evts;
  statistics = analyseStatistics(program.impactDispersion.trajectories, evts, variables, units);
  VARIABLEIDXS = [];
  for j = 1:length(VARIABLES)
    VARIABLE = cell2mat(VARIABLES(j));
    VARIABLEIDXS(end+1) = find(strcmp(variables,VARIABLE));
  end
  title = program.nominalTrajectory.title;
  CAPTION = [title, " Standard Deviation Data"];
  LABEL = ["tab:Aerodinâmica:",title(title!=" "),"StdData"];
  
  s3 = ["    \\caption{",CAPTION,"}"];
  s4 = ["    \\label{tab:Aerodinâmica:",LABEL,"}"];
  s5 = ["    \\begin{tabular}{",strjoin(repmat({"c"},1,length(VARIABLES)+1),"|"),"}"];
  s6 = ["        Event & ",strjoin(VARIABLES, " & ")," \\\\"];
  fdisp(FID,s1);
  fdisp(FID,s2);
  fdisp(FID,s3);
  fdisp(FID,s4);
  fdisp(FID,s5);
  fdisp(FID,s6);
  fdisp(FID,s7);
  for j = 1:length(EVTS)
    EVT = cell2mat(EVTS(j));
    EVTIDX = find(strcmp(evts,EVT));
    VALUES = strcat("$",strsplit(num2str(statistics.stdData(VARIABLEIDXS,EVTIDX)')," "),units(VARIABLEIDXS),"$");
    s8 = ["        ",EVT," & ",strjoin(VALUES," & ")," \\\\"];
    fdisp(FID,s8);
  end
  fdisp(FID,s9);
  fdisp(FID,s10);
end

function addAllPaths(f)
  addpath(f);
  LIST = dir(f);
  nl = length(LIST);
  for i = 1:nl
    l = LIST(i);
    if l.isdir
      if l.name(1) == "."
        continue;
      end
      if strcmp(l.name, "tmp")
        continue;
      end
      addAllPaths([l.folder,filesep,l.name]);
    end
  end
end
addAllPaths("..");

FLT = ".b";
DIALOG_NAME = "Select files to load and save in binary";
MODE = "on";
[FNAME, FPATH, FLTIDX] = uigetfile(FLT, DIALOG_NAME, "MultiSelect", MODE);

if !ischar(FNAME) && !iscell(FNAME)
  return;
end

EVTS = {"BURNOUT","APOGEE","GROUND_HIT"};
VARIABLES = {"Time", "Altitude", "Total velocity"};
FID = fopen([FPATH,filesep,"Tables.txt"], "w");

if iscell(FNAME)
  N = length(FNAME);
  for i = 1:N
    fname = cell2mat(FNAME(i));
    program = load([FPATH, filesep, fname]);
    program = program.program;
    program = verifyProgram(program);
    program.latitude = -23.361945;
    program.longitude = -48.005556;
    program.altitude = 640;
    writeMeanData(FID,program,VARIABLES,EVTS);
    writeStdData(FID,program,VARIABLES,EVTS);
  end
else
  program = load([FPATH, filesep, FNAME]);
  program = program.program;
  program = verifyProgram(program);
  program.latitude = -23.361945;
  program.longitude = -48.005556;
  program.altitude = 640;
  writeMeanData(FID,program,VARIABLES,EVTS);
  writeStdData(FID,program,VARIABLES,EVTS);
end

fclose(FID);