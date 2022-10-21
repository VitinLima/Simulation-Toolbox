function setMarkerSize(h)
	if length(h) == 1
		def = {num2str(get(h, 'markersize'))};
	else
		def = {""};
	end
	CSTR = inputdlg("Marker size:", "Edit marker size", 1, def);
	if !isempty(CSTR)
		CSTR = str2double(CSTR);
		if !isnan(CSTR)
			set(h, 'markersize', CSTR);
		end
	end
end