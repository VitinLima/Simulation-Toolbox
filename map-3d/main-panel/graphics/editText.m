function editText(h)
	choices = {
		"Color",
		"Line width",
		"Line style",
		"Font",
		"Font size",
		"Font weight",
		"Horizontal alignment",
		"Vertical alignment",
		"Rotation"};
	
	while (choice = menu("Main menu", choices)) > 0
		switch(choice)
			case 1
				setColor(h);
			case 2
				setLineWidth(h);
			case 3
				setLineStyle(h);
			case 4
				setFont(h);
			case 5
				setFontSize(h);
			case 6
				setFontWeight(h);
			case 7
				setHorizontalAlignment(h);
			case 8
				setVerticalAlignment(h);
			case 9
				setRotation(h);
		end
	end
end