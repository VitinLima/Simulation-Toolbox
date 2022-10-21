function statistics = analyseStatistics(trajectories, evts, variables, units)
	nv = length(variables);
	ne = length(evts);
	nt = length(trajectories);
	meanData = nan(nv,ne);
	stdData = nan(nv,ne);
	data = nan(nt,nv,ne);

	for i = 1:nt
		trajectory = trajectories(i);
		for j = 1:length(trajectory.evts)
			evt = cell2mat(trajectory.evts(j));
			evtID = find(strcmp(evts, evt));
			evtRow = trajectory.evtRows(j);
			if isempty(evtID)
				continue;
			end
      if evtRow > rows(trajectory.data)
        continue;
      end
			data(i,:,evtID) = trajectory.data(evtRow,:);
		end
	end

	for i = 1:nv;
		for j = 1:ne;
			d = data(:,i,j);
			d = d(!isnan(d));
			if isempty(d)
				continue;
			end
			meanData(i,j) = mean(d);
			stdData(i,j) = std(d);
		end
	end
	
	statistics.meanData = meanData;
	statistics.stdData = stdData;
	statistics.data = data;
	statistics.evts = evts;
	statistics.variables = variables;
	statistics.units = units;
end