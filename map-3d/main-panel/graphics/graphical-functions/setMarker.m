function setMarker(h)
	ms = {"*", "+", ".", "<", ">", "^", "d", "diamond", "h", "hexagram", "none", "o", "p", "pentagram", "s", "square", "v", "x"};
	[SEL, OK] = listdlg("ListString", ms,
		"Name", "Marker",
		"PromptString", "Select a marker",
		"OKString", "Select",
		"CancelString", "Cancel");
	if OK
		set(h, 'marker', cell2mat(ms(SEL)));
	end
end