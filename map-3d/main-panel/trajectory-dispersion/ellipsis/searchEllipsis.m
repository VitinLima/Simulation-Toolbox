function searchEllipsis(ellipsis, lengthUnit)
  characteristics = characterizeEllipsis(ellipsis.data)
  
  choices = {
    "main axis radius",
		"secondary axis radius",
    "main axis rotation angle",
		"center east position",
		"center north position"};
  
	KEYVALUE = {
		"ListString", choices,
		"SelectionMode", "Single",
		"InitialValue", 1,
		"Name", "Statistics functions",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "Back"
		}';
  
	[SEL, OK] = listdlg(KEYVALUE{1:end});
	
	if OK
		switch(SEL)
			case 1
        waitfor(msgbox(["Main axis radius is ", characteristics.mainAxisRadius," ", lengthUnit]));
      case 2
        waitfor(msgbox(["Secondary axis radius is ", characteristics.secondaryAxisRadius," º"]));
      case 3
        waitfor(msgbox(["Main axis rotation angle is ", characteristics.mainAxisRotationAngle," ", angleUnit]));
      case 4
        waitfor(msgbox(["Center east position is ", characteristics.centerEastPosition," ", lengthUnit]));
      case 5
        waitfor(msgbox(["Center north position is ", characteristics.centerNorthPosition," ", lengthUnit]));
		end
	end
end