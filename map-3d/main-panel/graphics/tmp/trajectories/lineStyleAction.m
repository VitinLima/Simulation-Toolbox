function map3D = lineStyleAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	choices = {"-", "--", "-.", ":", "none"};
	choice = menu("Set location:", choices);
	value = cell2mat(choices(choice));
	set(map3D.canvas.trajectory.handle, 'linestyle', value);
end