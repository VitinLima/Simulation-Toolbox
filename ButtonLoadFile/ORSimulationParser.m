function program = ORSimulationParser(program, varargin)
	if length(varargin) < 1
		cd(strjoin({program.pwd, "Simulations"}, filesep));
		[FileName,FilePath,Fileltidx] = uigetfile(".csv","File name:");%strjoin({input("File name:\n", "s"),".csv"},'');
		if FileName == 0
			program.file = -1;
			return;
		endif
	elseif length(varargin) == 1
		FileName = cell2mat(varargin(1));
		FilePath = "";
	elseif length(varargin) == 2
		FileName = cell2mat(varargin(1));
		FilePath = cell2mat(varargin(2));
	endif
##	FileName = "A15.csv";
	[fid, MSG] = fopen(strjoin({FilePath, FileName}, filesep));
	if fid == -1
		waitfor(msgbox(MSG));
		program.file = -1;
		return;
	endif

	lines = {};
	while (s=fgetl(fid)) != -1
		lines(end+1) = s;
	end
	fclose(fid);

	title = (cell2mat(lines(1)))(3:end);
	info = (cell2mat(lines(2)))(3:end);
	
	idx = 3;
	
	warnings = {};
	if strcmp("# Simulation warnings:", cell2mat(lines(3)))
		while !strcmp(l=lines(idx++), "#")
			warnings(end+1) = cell2mat(l)(3:end);
		end
	end
	
	l = (cell2mat(lines(idx++)))(3:end);
	variables = strsplit(l, ';');
	
	units = {};
	for i = 1:length(variables)
		s = cell2mat(variables(i));
		s = strsplit(s, ' ');
		units(end+1) = s(end);
		variables(i) = strjoin(s(1:end-1), ' ');
	end
	
	cd(strjoin({program.pwd, "ButtonLoadFile"}, filesep));
	variables = translateToEnglish(variables);

	evts = {};
	evtTime = [];
	data = zeros(str2double(cell2mat((strsplit(info))(1))), str2double(cell2mat((strsplit(info))(6))));
	
	k = 1;
	for i = [idx:length(lines)]
		l = cell2mat(lines(i));
		if l(1) == '#'
			tmp = l(3:end);
			tmp = strsplit(l(3:end), ' ');
			evts(end+1) = tmp(2);
			tmp = tmp(5);
			tmp = cell2mat(tmp);
			tmp = tmp(3:end);
			evtTime(end+1) = str2double(tmp);
			continue;
		end
		data(k++, :) = str2double(strsplit(l, ';'));
	end
	
	program.file.title = title;
	program.file.info = info;
	program.file.warnings = warnings;
	program.file.variables = variables;
	program.file.units = units;
	program.file.evts = evts;
	program.file.evtTimes = evtTime;
	program.file.data = data;
endfunction