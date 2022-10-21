function [SEL, OK] = chooseTrajectories(trajectories, evts, variables)
	choices = {};
	for i = 1:length(trajectories)
		choices(end+1) = trajectories(i).title;
	end
	if isempty(choices)
		waitfor(msgbox("No trajectories found."));
		SEL = [];
		OK = false;
	end
	FILTERS = {};
	f = false;
	do
		filteredChoices = filterTrajectories(trajectories, FILTERS, evts, variables);
		[SEL, OK] = listdlg("ListString", ["Filters", choices(filteredChoices)]);
		SEL--;
		if !OK
			f = true;
		elseif SEL == 0
			FILTERS = filterMenu(FILTERS, evts, variables);
			continue;
		else
			SEL = find(filteredChoices)(SEL);
			f = true;
		end
	until f
end