function program = Graph(program)
	xAxis = menu("X axis", program.nominalTrajectory.variables);
	if xAxis == 0
		return;
	endif;
	
	yAxis = [];
	do
		choice = menu("Y axis", ['done', program.nominalTrajectory.variables]);
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
			axisSide(end) = menu(["Plot ", cell2mat(program.nominalTrajectory.variables(yAxis(idx)))," on left or right y axis?"], {'left', 'right'});
		until axisSide(end) > 0
		if idx == 1
			if axisSide(end) == 1
				[ax, h, ~] = plotyy(program.nominalTrajectory.data(:, xAxis), program.nominalTrajectory.data(:,yAxis(idx)), [], []);
			else
				[ax, ~, h] = plotyy([], [], program.nominalTrajectory.data(:, xAxis), program.nominalTrajectory.data(:,yAxis(idx)));
			end
		else
			h = line(ax(axisSide(end)), program.nominalTrajectory.data(:, xAxis), program.nominalTrajectory.data(:,yAxis(idx)));
		end
		labels(axisSide(end)) = [cell2mat(labels(axisSide(end))), "\n", cell2mat(program.nominalTrajectory.variables(yAxis(idx)))];
    unitsString = cell2mat(program.nominalTrajectory.units(yAxis(idx)));
    if strcmp(unitsString, "?")
      unitsString = "";
    else
      unitsString = ["[",unitsString,"]"];
    end
		set(h, 'color', cmap(idx,:), 'displayname', strjoin({cell2mat(program.nominalTrajectory.variables(yAxis(idx))), unitsString}, ' '));
##		l = [l, strjoin({cell2mat(program.nominalTrajectory.variables(yAxis(idx))), cell2mat(program.nominalTrajectory.units(yAxis(idx)))}, ' ')];
	end
	xlabel(strjoin({cell2mat(program.nominalTrajectory.variables(xAxis)), cell2mat(program.nominalTrajectory.units(xAxis))}, ' '));
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
  
	[FNAME, FPATH, FLTIDX] = uiputfile(".png", "Save as", program.transient.lastSavedDirectory);
	if FNAME!=0
    saveas(gcf, [FPATH, filesep, FNAME], 'png');
	endif
	
	waitfor(gcf);
endfunction