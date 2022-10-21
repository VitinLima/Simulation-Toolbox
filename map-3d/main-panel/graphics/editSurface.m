function editSurface(h)
	choices = {
		"C data mapping",
		"Line width",
		"Line style"};
	
	while (choice = menu("Main menu", choices)) > 0
		switch(choice)
			case 1
				setCDataMapping(h);
			case 2
				setLineWidth(h);
			case 3
				setLineStyle(h);
		end
	end
end