function [h, OK] = handleChooser(H)
	h = [];
	OK = false;
	choices = get(H, 'displayname');
	
	if isempty(choices)
		waitfor(msgbox("No lines found."));
		return;
	end
	
	FILTERS = {};
	F = false;
	
	do
		fH = H;
		for i = 1:length(FILTERS)
			fH = findall(fH, 'tag', cell2mat(FILTERS(i)));
		end
		choices = get(fH, 'displayname');
		[SEL, OK] = listdlg("ListString", ["Filters"; choices],
			"Name", "Lines",
			"PromptString", "Select line to edit",
			"OKString", "Select",
			"CancelString", "Back");
		SEL--;
		if OK
			if SEL == 0
				FILTERS = handleFilters(FILTERS);
			else
				h = fH(SEL);
				F = true;
				continue;
			end
		else
			F = true;
			continue;
		end
	until F
end