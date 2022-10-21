close('all');
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
if isempty(find(strcmp(strsplit(path,';'), pwd)))
  addAllPaths(pwd);
end

if exist('program') == 0
  clear;
  clc;
  program.transient.pwd = pwd;
  program.transient.lastLoadedDirectory = program.transient.pwd;
  program.transient.lastSavedDirectory = program.transient.pwd;
  program.defaultUnitSystem = "SI";
end

choices = {
  "Load file",
  "Save",
  "Graph",
  "Map"
};

KEYVALUE = {
  "ListString", choices,
  "SelectionMode", "Single",
  "InitialValue", 1,
  "Name", "Main menu",
  "PromptString", {},
  "OKString", "OK",
  "CancelString", "Exit"
}';

try
  do
    [SEL, OK] = listdlg(KEYVALUE{1:end});
    if OK
      switch(SEL)
        case 1
          program = LoadFile(program);
          program = verifyProgram(program);
        case 2
          program = SaveFile(program);
        case 3
          program = Graph(program);
        case 4
          program = Map3D(program);
        otherwise
          choice = 0;
      endswitch
    end
  until !OK
catch VALUE
  cd(program.transient.pwd);
  disp(["error: ", VALUE.message]);
  disp("error: called from ");
  for i = 1:length(VALUE.stack)
    e = VALUE.stack(i);
    disp(["\t", cell2mat(strsplit(e.file, '\')(end)), " at line ", num2str(e.line), " column ", num2str(e.column)]);
  end
end

##restoredefaultpath;