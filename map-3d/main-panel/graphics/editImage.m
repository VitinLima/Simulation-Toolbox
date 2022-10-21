function editImage(h)
	choices = {
		"set image data",
		"rotate clockwise",
		"rotate counter-clockwise",
    "flip x",
    "flip y",
    "translate x",
    "translate y",
    "scale",
    "set origin"};
	
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
    if !OK
      continue;
    end
		switch SEL
			case 1
				imageDisplay(get(h, 'parent'));
			case 2
        cdata = get(h, 'cdata');
        cdata = rot90(cdata);
        set(h, 'cdata', cdata);
			case 3
        cdata = get(h, 'cdata');
        cdata = rot90(cdata,-1);
        set(h, 'cdata', cdata);
      case 4
        cdata = get(h, 'cdata');
        cdata = flip(cdata,2);
        set(h, 'cdata', cdata);
      case 5
        cdata = get(h, 'cdata');
        cdata = flip(cdata);
        set(h, 'cdata', cdata);
      case 6
        imageTranslateX(h);
      case 7
        imageTranslateY(h);
      case 8
        imageScale(h);
      case 9
        imageSetOrigin(h);
		end
	until !OK
end