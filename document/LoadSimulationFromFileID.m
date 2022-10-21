function [trajectory, ok] = LoadSimulationFromFileID(FID, fieldSeparator, NFieldSeparator, commentCharacter, NCommentCharacter)
	trajectory = [];
	ok = false;
	
	l = fgetl(FID);
	if feof(FID)
		return;
	end
	title = l(3:end);
	info = fgetl(FID)(3:end)
	
	warnings = {};
	if length(l) > NCommentCharacter
		while length(l=fgetl(FID)) > NCommentCharacter
			warnings(end+1) = l(NCommentCharacter+2:end);
		end 
	endif
	
	variables = strsplit(fgetl(FID)(NCommentCharacter+2:end), fieldSeparator);
	
	units = {};
	for i = 1:length(variables)
		l = cell2mat(variables(i));
		l = strsplit(l, ' ');
		units(end+1) = cell2mat(l(end))(2:end-1);
		if strcmp(units(end), "?")
			units(end) = " ";
		end
		variables(i) = strjoin(l(1:end-1), ' ');
	end

	evts = {};
	evtTimes = [];
	evtRows = [];
	data = zeros(str2double(cell2mat((strsplit(info))(1))), str2double(cell2mat((strsplit(info))(6))));
	
	k = 0;
	while k < rows(data)
		l = fgetl(FID);
		if strncmp(l, commentCharacter, NCommentCharacter)
			l = l(3:end);
			l = strsplit(l, ' ');
			evts(end+1) = l(2);
			l = cell2mat(l(5));
			evtTimes(end+1) = str2double(l(3:end));
			evtRows(end+1) = k+1;
			continue;
		endif
		data(++k, :) = str2double(strsplit(l, fieldSeparator));
	endwhile
	
	trajectory.title = title;
	trajectory.info = info;
	trajectory.warnings = warnings;
	trajectory.variables = variables;
	trajectory.units = units;
	trajectory.evts = evts;
	trajectory.evtTimes = evtTimes;
	trajectory.evtRows = evtRows;
	trajectory.data = data;
	trajectory.tags = {};
	
	ok = true;
endfunction