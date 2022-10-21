function MapAction(src, data, map3D)
  map3D = get(map3D, 'userdata');
	
	choices = {
    "display",
    "remove",
		"graphics settings"};
	
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
        imageDisplay(map3D.canvas.handle);
      case 2
        h = findobj(map3D.canvas.handle, 'tag', "map");
        if !isempty(h)
          delete(h);
        else
          waitfor(msgbox("No map found."));
        end
      case 3
        h = findobj(map3D.canvas.handle, 'tag', "map");
        if !isempty(h)
          editImage(h);
        else
          waitfor(msgbox("No map found."));
        end
    end
  until !OK
end