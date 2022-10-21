function map3D = removeEventButtonAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	evts = findall(findobj(findobj(map3D.handle, 'tag', 'image'), 'type', 'axes'), 'tag', 'eventText');
	plts = findall(findobj(findobj(map3D.handle, 'tag', 'image'), 'type', 'axes'), 'tag', 'eventPlot');
	choices = {};
	for e = evts
		choices(end+1) = get(e, 'string');
	end
	if length(choices) < 1
		return;
	end
	choice = menu("Event to remove:", choices);
	if choice > 0
		delete(evts(choice));
		delete(plts(choice));
	end
end