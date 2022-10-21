function map3D = LineAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	
	choices = {"add", "edit", "delete"};
	
	while (choice = menu("Lines", choices)) > 0
		switch(choice)
			case 1
				addLine(map3D);
			case 2
				[h, OK] = handleChooser(findall(map3D.canvas.handle, 'type', 'line'));
				if OK
					editLine(h);
				end
			case 3
				[h, OK] = handleChooser(findall(map3D.canvas.handle, 'type', 'line'));
				if OK
					delete(h);
				end
		end
	end
end