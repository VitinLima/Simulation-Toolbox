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

title = "File formatting";
prompt = {"Field separator:", "Comment:"};
rowscols = [1, 1];
defaults = {",", "#"};
cstr = inputdlg(prompt, title, rowscols, defaults);

if isempty(cstr)
  return;
end

fileFormat.fieldSeparator = cell2mat(cstr(1));
fileFormat.commentCharacter = cell2mat(cstr(2));

FLT = ".csv";
DIALOG_NAME = "Select files to load and save in binary";
MODE = "on";
[FNAME, FPATH, FLTIDX] = uigetfile(FLT, DIALOG_NAME, "MultiSelect", MODE);

if iscell(FNAME)
  N = length(FNAME);
  for i = 1:N
    fname = cell2mat(FNAME(i));
    program = LoadCSV([FPATH, filesep, fname], fileFormat);
    fname = [fname(1:strfind(fname,".")(end)), "b"];
    save('-binary', [FPATH, filesep, fname], "program");
  end
else
  program = LoadCSV([FPATH, filesep, FNAME], fileFormat);
  FNAME = [FNAME(1:strfind(FNAME,".")(end)), "b"];
  save('-binary', [FPATH, filesep, FNAME], "program");
end