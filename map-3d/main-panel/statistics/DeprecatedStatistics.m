function program = Statistics(program)
	evts = program.nominalTrajectory.evts;
	variables = program.nominalTrajectory.variables;
	units = program.nominalTrajectory.units;
	if !isempty(program.impactDispersion)
		program.impactDispersion.statistics = StatisticalAnalysis(program.impactDispersion, evts, variables, units);
	end
##	if !isempty(program.debrisDispersion)
##		program.debrisDispersion.statistics = StatisticalAnalysis(program.debrisDispersion, evts, variables, units);
##	end
	
	choices = {
		"Impact dispersion",
		"Debris dispersion"
	};
	
	KEYVALUE = {
		"ListString", choices,
		"SelectionMode", "Single",
		"InitialValue", 1,
		"Name", "Statistics functions",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "Back"
		}';

	do
		[SEL, OK] = listdlg(KEYVALUE{1:end});
		if OK
			switch(SEL)
				case 1
					if !isempty(program.impactDispersion)
						DispersionStatistics(program.impactDispersion.statistics);
					else
						waitfor(msgbox("No impact dispersion data found."));
					end
				case 2
					if !isempty(program.debrisDispersion)
						DispersionStatistics(program.debrisDispersion.statistics);
					else
						waitfor(msgbox("No debris dispersion data found."));
					end
			end
		end
	until !OK
end