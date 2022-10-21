function editLine(h)
	choices = {
		"Color",
		"Line width",
		"Line style",
		"Marker size",
		"Marker"};
  
  KEYVALUE = {
    "ListString", choices,
    "SelectionMode", "Single",
    "InitialValue", 1,
    "Name", "Main menu",
    "PromptString", {},
    "OKString", "OK",
    "CancelString", "Back"
  }';
	
	do
    [SEL, OK] = listdlg(KEYVALUE{1:end});
    if OK
      switch(choice)
        case 1
          setColor(h);
        case 2
          setLineWidth(h);
        case 3
          setLineStyle(h);
        case 4
          setMarkerSize(h);
        case 5
          setMarker(h);
      end
    end
	until !OK
end