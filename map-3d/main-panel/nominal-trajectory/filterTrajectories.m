function filteredChoices = filterTrajectories(trajectories, FILTERS, evts, variables)
	filteredChoices = true(length(trajectories),1);
	for i = 1:length(FILTERS)
		f = cell2mat(FILTERS(i));
		for j = 1:length(trajectories)
			trajectory = trajectories(j);
			evtID = find(strcmp(trajectory.evts, f.evt));
			variableID = find(strcmp(trajectory.variables, f.variable));
			if isempty(evtID) || isempty(variableID)
				continue;
			end
			evtRow = trajectory.evtRows(evtID);
			if f.h
				if !(trajectory.data(evtRow, variableID) > f.value)
					filteredChoices(j) = false;
				end
			else
				if trajectory.data(evtRow, variableID) > f.value
					filteredChoices(j) = false;
				end
			end
		end
	end
end