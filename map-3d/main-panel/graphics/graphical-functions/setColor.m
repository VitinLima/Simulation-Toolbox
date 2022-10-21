function setColor(h)
	colors = {"red", "green", "blue", "yellow", "cyan", "magenta", "black", "white", "custom"};
	[SEL, OK] = listdlg("ListString", colors,
		"Name", "Colors",
		"PromptString", "Select a color",
		"OKString", "Select",
		"CancelString", "Cancel");
	if OK
		switch(SEL)
			case 1
				set(h, 'color', 'red');
			case 2
				set(h, 'color', 'green');
			case 3
				set(h, 'color', 'blue');
			case 4
				set(h, 'color', 'yellow');
			case 5
				set(h, 'color', 'cyan');
			case 6
				set(h, 'color', 'magenta');
			case 7
				set(h, 'color', 'black');
			case 8
				set(h, 'color', 'white');
			case 9
				dflt = get(h, 'color');
				dflt = strsplit(dflt);
				dflt = strjoin(dflt, ':');
				CSTR = inputdlg("Value in RGD (R:G:B):", "Set color", 1, {dflt});
				if !isempty(CSTR)
					CSTR = strsplit(cell2mat(CSTR), ':');
					if length(CSTR) == 3
						CSTR = str2double(CSTR);
						if isnan(CSTR(1)) && isnan(CSTR(2)) && isnan(CSTR(3))
							CSTR /= 255;
							set(h, 'color', CSTR);
						end
					end
				end
		end
	end
end