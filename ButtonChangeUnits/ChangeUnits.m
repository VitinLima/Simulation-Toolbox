function program = ChangeUnits(program)
	choices = {};
	for i = 1:length(program.file.units)
		f = true;
		for j = 1:length(choices)
			if strcmp(cell2mat(choices(j)), cell2mat(program.file.units(i)))
				f = false;
			end
		end
		if f
			choices(end+1) = cell2mat(program.file.units(i));
		end
	end
	choice = menu("Unit to change:", choices);
	if choice == 0
		return;
	end
	oldUnit = choices(choice);
	newUnitName = cell2mat(inputdlg("New unit name:"));
	newUnitConversionConstant = str2double(cell2mat(inputdlg("Unit conversion constant:")));
	if isnan(newUnitConversionConstant)
		waitfor(errordlg('Invalid number'));
		return;
	end
	for i = 1:length(program.file.units)
		if strcmp(cell2mat(oldUnit), cell2mat(program.file.units(i)))
			program.file.units(i) = ['(', cell2mat(oldUnit), ')'];
			program.file.data(:,i) /= newUnitConversionConstant;
		end
	end
end