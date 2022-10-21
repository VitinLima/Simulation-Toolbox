clc;

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

colors = {'r','g','b','y','m','c'};

if iscell(FNAME)
  N = length(FNAME);
  for i = 1:N
    fname = cell2mat(FNAME(i));
    program = load([FPATH, filesep, fname]);
    program = program.program;
    program.latitude = -23.361945;
    program.longitude = -48.005556;
    program.altitude = 640;
    fname = [program.nominalTrajectory.title, ".kml"];
    c = cell2mat(colors(i));
    program.nominalTrajectory.graphicalProperties.color = c;
    exportKML([FPATH,filesep,fname], program.nominalTrajectory, program);
    fname = [program.nominalTrajectory.title, "Dispersion", ".kml"];
    program.impactDispersion.graphicalProperties.color = c;
    exportKML([FPATH,filesep,fname], program.impactDispersion, program);
    fname = [program.nominalTrajectory.title, "DispersionEllipsis", ".kml"];
    program.impactDispersion.ellipsis.graphicalProperties.color = c;
    exportKML([FPATH,filesep,fname], program.impactDispersion.ellipsis, program);
  end
else
  program = load([FPATH, filesep, FNAME]);
  program = program.program;
  FNAME = [program.nominalTrajectory.title, ".kml"];
  exportKML([FPATH,filesep,FNAME], program.nominalTrajectory, program);
  FNAME = [program.nominalTrajectory.title, "Dispersion", ".kml"];
  exportKML([FPATH,filesep,FNAME], program.impactDispersion, program);
  FNAME = [program.nominalTrajectory.title, "DispersionEllipsis", ".kml"];
  exportKML([FPATH,filesep,FNAME], program.impactDispersion.ellipsis, program);
end