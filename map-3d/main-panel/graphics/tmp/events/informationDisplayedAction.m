function map3D = informationDisplayedAction(src, data, map3D)
	map3D = get(map3D, 'userdata');
	marker = get(map3D.auxPanel.eventsPanel.handle, 'userdata');
	listIdx = get(src, 'userdata');
	[listIdx, OK] = listdlg(
		'PromptString', "Variables",
		'SelectionMode', 'Multiple',
		'InitialValue', listIdx,
		'ListString', map3D.file.variables);
	if OK
		idx = get(marker, 'userdata');
		nString = cell2mat(strsplit(get(marker, 'displayname'), '\n')(1));
		for i = listIdx
			nString = strjoin({nString, strjoin({cell2mat(map3D.file.variables(i)), strjoin({num2str(map3D.file.data(idx, i)), cell2mat(map3D.file.units(i))}, ' ')}, ": ")}, '\n');
		end
		set(marker, 'displayname', nString);
		set(src, 'userdata', listIdx);
	end
end