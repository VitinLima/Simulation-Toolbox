function FILTERS = handleFilters(FILTERS)
	choices = {"add", "edit", "remove"};
	
	while (choice = menu("Filters", choices)) > 0
		switch(choice)
			case 1
				CSTR = inputdlg({"Filter value:"}, "New filter");
				if !isempty(CSTR)
					FILTERS(end+1) = cell2mat(CSTR);
				end
			case 2
				if isempty(FILTERS)
					waitfor(msgbox("No filters found"));
				else
					[SEL, OK] = listdlg("ListString", FILTERS);
					if OK
						CSTR = inputdlg({"Filter value:"}, "Edit filter", [], cell2mat(FILTERS(SEL)));
						if !isempty(CSTR)
							FILTERS(SEL) = cell2mat(CSTR);
						end
					end
				end
			case 3
				if isempty(FILTERS)
					waitfor(msgbox("No filters found"));
				else
					[SEL, OK] = listdlg("ListString", FILTERS, "Name", "Remove filter");
					if OK
						FILTERS(SEL) = [];
					end
				end
		end
	end
end