function program = verifyProgram(program)
##	if isfield(program, "version")
##		if strcmp(program.version, "1.1");
##			return;
##		end
##	else
##		program.version = "1.1";
##	end
	
  if isfield(program, "nominalTrajectory")
    trajectory = program.nominalTrajectory;
    ne = length(trajectory.evts);
    for i = 1:ne
      e = cell2mat(trajectory.evts(i));
      ids = find(strcmp(trajectory.evts, e));
      if length(ids) == 1
        continue;
      end
      for j = 1:length(ids)
        trajectory.evts(ids(j)) = [e, num2str(j)];
      end
    end
    program.nominalTrajectory = trajectory;
  end
  
  if isfield(program, "impactDispersion")
    trajectories = program.impactDispersion.trajectories;
    nt = length(trajectories);
    for i = 1:nt
      evts = trajectories(i).evts;
      ne = length(evts);
      for j = 1:ne
        e = cell2mat(evts(j));
        ids = find(strcmp(evts, e));
        if length(ids) == 1
          continue;
        end
        for k = 1:length(ids)
          evts(ids(k)) = [e, " (", num2str(k), ")"];
        end
      end
      trajectories(i).evts = evts;
    end
    
    s = struct2cell(trajectories);
    ttls = s(find(strcmp(fieldnames(trajectories), "title")),1,:)(:);
    for i = 1:nt
      ttl = cell2mat(ttls(i));
      ids = find(strcmp(ttls, ttl));
      if length(ids) == 1
        trajectories(i).title = cell2mat(ttls(i));
        continue;
      end
      for j = 1:length(ids)
        ttls(ids(j)) = [ttl, " (", num2str(j), ")"];
      end
      trajectories(i).title = cell2mat(ttls(i));
    end
    program.impactDispersion.trajectories = trajectories;
  end
end