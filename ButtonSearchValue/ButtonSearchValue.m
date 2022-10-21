function ButtonSearchValue(file)
	##while (targetVariable = menu("Variables", strsplit(["Thrust-Mass ratio;", strjoin(file.variables, ';')], ';')) > 0) && (targetEvent = menu("Events", file.evts))
	while (targetVariable = menu("Variables", file.variables)) && (targetEvent = menu("Events", file.evts))
		[val, ok, msg] = UtilFindValAt(file, targetVariable, targetEvent);
		if ok
			disp(strjoin({"Variable", cell2mat(file.variables(targetVariable)), "at event", cell2mat(file.evts(targetEvent)), "is", num2str(val), cell2mat(file.units(targetVariable))}, ' '));
		else
			waitfor(msgbox(msg));
		endif
	endwhile
endfunction