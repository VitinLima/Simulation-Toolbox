function map3D = addTrajectoryAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	
	choices = {
	"Nominal trajectory",
	"Impact dispersion",
	"Debris dispersion **"};
	
	while (choice = menu("Main menu", choices))
		switch(choice)
			case 1
				
			case 2
				
			case 3
				
		end
	end
end