function searchStatistics(trajectories, evts, variables, units)
  statistics = analyseStatistics(trajectories, evts, variables, units);
  
  eChoices = evts;
  vChoices = variables;

  while (fChoice = menu("Function", {"Mean", "Standard deviation"})) > 0
    if (vChoice = menu("Variable", vChoices)) > 0
      if (eChoice = menu("Event", eChoices)) > 0
        e = cell2mat(eChoices(eChoice));
        v = cell2mat(vChoices(vChoice));
        if fChoice == 1
            s = "Mean ";
            f = statistics.meanData(vChoice, eChoice);
        else
            s = "Standard deviation of ";
            f = statistics.stdData(vChoice, eChoice);
        end
        u = cell2mat(statistics.units(vChoice));
        s = [s, v, " at ", e, " is ", num2str(f), " ", u];
        waitfor(msgbox(s));
      end
    end
  end
end