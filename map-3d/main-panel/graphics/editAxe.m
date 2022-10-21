function editAxe(h)
	choices = {
		"Color",
		"Color order",
		"Camera position",
		"Camera position mode",
		"Camera target",
		"Camera target mode",
		"Camera view angle",
		"Camera view mode",
		"Data aspect ratio",
		"Data aspect ration mode",
		"Font angle",
		"Font name",
		"Font size",
		"Font weight",
		"Line width",
		"Minor grid line style"};
	
	while (choice = menu("Main menu", choices)) > 0
		switch(choice)
			case 1
				setColor(h);
			case 2
				setLineWidth(h);
			case 3
				setLineStyle(h);
		end
	end
end