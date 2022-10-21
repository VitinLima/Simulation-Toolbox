function setLineStyle(h)
	ls = {"-", "--", "-.", ":", "none"};
	[SEL, OK] = listdlg("ListString", ls,
		"Name", "Line style",
		"PromptString", "Select a style",
		"OKString", "Select",
		"CancelString", "Cancel");
	if OK
		set(h, 'linestyle', cell2mat(ls(SEL)));
	end
end