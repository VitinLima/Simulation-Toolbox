function searchNominalTrajectoryValue(nominalTrajectory)
	VARIABLES_KEYVALUE = {
		"ListString", nominalTrajectory.variables,
		"SelectionMode", "Single",
		"InitialValue", 1,
		"Name", "Statistics functions",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "back"
		}';
	EVTS_KEYVALUE = {
		"ListString", nominalTrajectory.evts,
		"SelectionMode", "Single",
		"InitialValue", 1,
		"Name", "Statistics functions",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "back"
		}';
  
  do
    [VARIABLE_SEL, OK] = listdlg(VARIABLES_KEYVALUE{1:end});
    if !OK
      continue;
    end
    [EVT_SEL, OK] = listdlg(EVTS_KEYVALUE{1:end});
    if !OK
      OK = true;
      continue;
    end
    VARIABLE = cell2mat(nominalTrajectory.variables(VARIABLE_SEL));
    EVT = cell2mat(nominalTrajectory.evts(EVT_SEL));
    id = nominalTrajectory.evtRows(EVT_SEL);
    VALUE = num2str(nominalTrajectory.data(id,VARIABLE_SEL));
    UNIT = cell2mat(nominalTrajectory.units(VARIABLE_SEL));
    MSG = ["Variable ", VARIABLE, " at event ", EVT, " is ", VALUE, " ", UNIT];
    waitfor(msgbox(MSG));
  until !OK
end