function setLineWidth(h)
	if length(h) == 1
		def = {num2str(get(h, 'linewidth'))};
	else
		def = {""};
	end
	CSTR = inputdlg({"Line width:"}, "Edit line width", 1, def);
	if !isempty(CSTR)
		CSTR = str2double(CSTR);
		if !isnan(CSTR)
			set(h, 'linewidth', CSTR);
		end
	end
end