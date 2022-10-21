function [f, OK] = newFilter(evts, variables)
	OK = false;
	choice = menu("Type of filter:", {"Higher than", "Lower than"});
	if choice == 0
		f = [];
		return;
	end
	if choice == 1
		f.h = true;
	else
		f.h = false;
	end
	choice = menu("Event of filter:", evts);
	if choice == 0
		f = [];
		return;
	end
	f.evt = cell2mat(evts(choice));
	choice = menu("Variable of filter:", variables);
	if choice == 0
		f = [];
		return;
	end
	f.variable = cell2mat(variables(choice));
	CSTR = inputdlg("Value of filter:");
	if isempty(CSTR)
		f = [];
		return;
	end
	f.value = str2double(CSTR);
	OK = true;
end