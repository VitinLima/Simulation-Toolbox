function FILTERS = filterMenu(FILTERS, evts, variables)
	choices = {"Add", "Edit", "Remove"};
	while (choice = menu("Trajectory filters", choices)) > 0
		switch(choice)
			case 1
				[f, OK] = newFilter(evts, variables);
				if OK
					FILTERS(end+1) = f;
				end
			case 2
				s = {};
				for i = 1:length(FILTERS)
					f = cell2mat(FILTERS(i));
					s(end+1) = strjoin({num2str(f.h), f.evt, num2str(f.variable), num2str(f.value)},',');
				end
				if !isempty(s)
					SEL = menu("Select filter to edit", s);
					if SEL > 0
						[f, OK] = newFilter(evts, variables);
						if OK
							FILTERS(SEL) = f;
						end
					end
				else
					waitfor(msgbox("No filter to edit."));
				end
			case 3
				s = {};
				for i = 1:length(FILTERS)
					f = cell2mat(FILTERS(i));
					s(end+1) = strjoin({num2str(f.h), f.evt, num2str(f.variable), num2str(f.value)},',');
				end
				if !isempty(s)
					SEL = menu("Select filters to remove", s);
					if SEL > 0
						FILTERS(SEL) = [];
					end
				else
					waitfor(msgbox("No filter to remove."));
				end
		end
	end
end