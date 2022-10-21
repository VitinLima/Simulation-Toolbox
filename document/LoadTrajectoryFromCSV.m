function trajectory = LoadTrajectoryFromCSV(FID)
  trajectory = [];
  choices = {"title", "\\title"; ...
    "header", "\\header"; ...
    "conditions", "\\conditions"; ...
    "events", "\\events"; ...
    "warnings", "\\warnings"; ...
    "variables", "\\variables"; ...
    "data", "\\data"};
  choice = false(6,2);
  title = [];
  status = [];
  header = [];
  conditions = {};
  evts = {};
  evtTimes = [];
  evtRows = [];
  warnings = {};
  variables = {};
  units = {};
  data = [];
  do
    do
      s = fgetl(FID);
    until !isempty(s);
    if s(1) == "<" && s(end) == ">"
      s([1,end]) = [];
      s = strsplit(s,",");
      cmd = cell2mat(s(1));
      args = [];
      if length(s) > 1
        args = s(2:end);
      end
      sel = find(strcmp(cmd,choices));
      switch sel
        case 1
          s = fgetl(FID);
          s = strsplit(s);
          status = cell2mat(s(end));
          status([1,end]) = [];
          s(end) = [];
          title = strjoin(s);
        case 2
          header = fgetl(FID)(3:end);
        case 3
          N = str2double(args);
          conditions = cell(N,2);
          for i = 1:N
            s = fgetl(FID)(3:end);
            s = strsplit(s);
            conditions(i,2) = str2double(s(end));
            s(end) = [];
            s = strjoin(s);
            s(end) = [];
            conditions(i,1) = s;
          end
        case 4
          N = str2double(args);
          evts = cell(1,N);
          evtTimes = zeros(1,N);
          evtRows = zeros(1,N);
          for i = 1:N
            s = fgetl(FID)(3:end);
            s = strsplit(s);
            evts(i) = cell2mat(s(2));
            evtTimes(i) = str2double(s(5));
            evtRows(i) = str2double(s(9))+1;
          end
        case 5
          N = str2double(args);
          warnings = cell(1,N);
          for i = 1:N
            warnings(i) = fgetl(FID)(3:end);
          end
        case 6
          N = str2double(args);
          for i = 1:N
            s = fgetl(FID)(3:end);
            s = strsplit(s);
            units(i) = cell2mat(s(end))(2:end-1);
            s(end) = [];
            variables(i) = strjoin(s);
          end
        case 7
          N = str2double(args);
          TEMPLATE = repmat({"%f"},1,length(variables));
          TEMPLATE = strjoin(TEMPLATE, ",");
          [VAL, COUNT, ERRMSG] = fscanf(FID, TEMPLATE, [length(variables), N]);
          data = VAL';
      end
    end
  until sel==14
  trajectory.title = title;
  trajectory.status = status;
  trajectory.header = header;
  trajectory.conditions = conditions;
  trajectory.evts = evts;
  trajectory.evtTimes = evtTimes;
  trajectory.evtRows = evtRows;
  trajectory.warnings = warnings;
  trajectory.variables = variables;
  trajectory.units = units;
  trajectory.data = data;
end