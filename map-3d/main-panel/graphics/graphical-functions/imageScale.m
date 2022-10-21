function imageScale(h)
  choices = {
		"Scale by value",
		"Scale to length"};
	
	KEYVALUE = {
		"ListString", choices,
		"SelectionMode", "Single",
		"InitialValue", 1,
		"Name", "Scale image",
		"PromptString", {},
		"OKString", "OK",
		"CancelString", "Cancel"
		}';
  
  [SEL, OK] = listdlg(KEYVALUE{1:end});
  
  if OK
    switch SEL
      case 1
        imageScaleByValue(h);
      case 2
        imageScaleToLength(h);
    end
  end
end