function ButtonCreateGraph(program)
	
	xAxis = menu("X axis", program.file.variables);
	if xAxis == 0
		return;
	endif;
	
	yAxis = [];
	do
		choice = menu("Y axis", ['done', program.file.variables]);
		if choice == 0
			return;
		elseif choice != 1
			yAxis(end+1) = choice-1;
		endif;
	until choice == 1
	
	if length(yAxis) < 1
		return;
	end
	
	figure;
	hold on;
	
	labels = {"", ""};
	cmap = hsv(length(yAxis));
	axisSide = [];
##	l = {};
	ax = [];
	corder = 2;
	for idx = 1:length(yAxis)
		axisSide(end+1) = 0;
		do
			axisSide(end) = menu(["Plot ", cell2mat(program.file.variables(yAxis(idx)))," on left or right y axis?"], {'left', 'right'});
		until axisSide(end) > 0
		if idx == 1
			if axisSide(end) == 1
				[ax, h, ~] = plotyy(program.file.data(:, xAxis), program.file.data(:,yAxis(idx)), [], []);
			else
				[ax, ~, h] = plotyy([], [], program.file.data(:, xAxis), program.file.data(:,yAxis(idx)));
			end
		else
			h = line(ax(axisSide(end)), program.file.data(:, xAxis), program.file.data(:,yAxis(idx)));
		end
		labels(axisSide(end)) = [cell2mat(labels(axisSide(end))), "\n", cell2mat(program.file.variables(yAxis(idx)))];
		set(h, 'color', cmap(idx,:), 'displayname', strjoin({cell2mat(program.file.variables(yAxis(idx))), cell2mat(program.file.units(yAxis(idx)))}, ' '));
##		l = [l, strjoin({cell2mat(program.file.variables(yAxis(idx))), cell2mat(program.file.units(yAxis(idx)))}, ' ')];
	end
	xlabel(strjoin({cell2mat(program.file.variables(xAxis)), cell2mat(program.file.units(xAxis))}, ' '));
	ylabel(ax(1), cell2mat(labels(1)));
	ylabel(ax(2), cell2mat(labels(2)));
	set(ax(1),'ycolor', 'black');
	set(ax(2),'ycolor', 'black');
	grid on;
	legend;
	##zlabel('Altitude (m)');

	s = inputdlg("Title:");
	if !isempty(s)
		title(s);
	end

	hold off;

	s = cell2mat(inputdlg("Save as:"));
	if !isempty(s)
		cd(strjoin({program.pwd, "Results"}, filesep));
		saveas(gcf, s);
	end
	
	waitfor(gcf);
endfunction