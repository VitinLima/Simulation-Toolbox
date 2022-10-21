function editPatch(h)
	choices = {
		"C data mapping",
		"Line width",
		"Line style",
		"Face color"};
	
	while (choice = menu("Main menu", choices)) > 0
		switch(choice)
			case 1
				setCDataMapping(h);
			case 2
				setLineWidth(h);
			case 3
				setLineStyle(h);
			case 4
				setFaceColor(h);
		end
	end
end