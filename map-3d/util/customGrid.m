function customGrid(file, figureHandle)
	XLow = min(X) - 100;
	XHigh = max(X) + 100;
	YLow = min(Y) - 100;
	YHigh = max(Y) + 100;
	ZLow = min(Z) - 100;
	ZHigh = max(Z) + 100;

	view(-50,17)
	xlim([XLow XHigh]);
	ylim([YLow YHigh]);
	zlim([ZLow ZHigh]);

	hold on;

	% GET TICKS
	X=get(gca,'Xtick');
	Y=get(gca,'Ytick');
	Z=get(gca,'Ztick');

	% GET LABELS
	XL=get(gca,'XtickLabel');
	YL=get(gca,'YtickLabel');
	ZL=get(gca,'ZtickLabel');

	% REMOVE TICKS
	set(gca,'Xtick',[]);
	set(gca,'Ytick',[]);
	set(gca,'Ztick',[]);

	% GET OFFSETS
	Xoff=diff(get(gca,'XLim'))./30;
	Yoff=diff(get(gca,'YLim'))./30;
	Zoff=diff(get(gca,'ZLim'))./30;

	% DRAW TICKS
	%%%%%%% THIS COULD BE VECTORiZeD %%%%%%%
	for i=1:length(X)
		 plot3([X(i) X(i)],[-XLow XHigh],[0 0],'Color',[0.8 0.8 0.8]);
		 plot3([X(i) X(i)],[0 0],[YLow YHigh],'Color',[0.8 0.8 0.8]);
		 plot3([X(i) X(i)],[0 0],[-Zoff Zoff],'k');
	end
	for i=1:length(Y)
		 plot3([YLow YHigh],[Y(i) Y(i)],[0 0],'Color',[0.8 0.8 0.8]);
		 plot3([-Xoff Xoff],[Y(i) Y(i)],[0 0],'k');
	end
	for i=1:length(Z)
		 plot3([YLow YHigh],[0 0],[Z(i) Z(i)],'Color',[0.8 0.8 0.8]);
		 plot3([-Xoff Xoff],[0 0],[Z(i) Z(i)],'k');
	end

	% DRAW AXIS LINEs
	plot3([YLow YHigh],[0 0],[0 0],'k');
	plot3([0 0],[0 0],[YLow YHigh],'k');
	plot3([0 0],[-XLow XHigh],[0 0],'k');

	% DRAW LABELS
	%text(X,zeros(size(X)),zeros(size(X))-3.*Zoff,XL);
	text(zeros(size(Y))-3.*Xoff,Y,zeros(size(Y)),YL);
	text(zeros(size(Z))-3.*Xoff,zeros(size(Z)),Z,ZL);


	xlabel(strjoin({cell2mat(file.variables(eastIdx)), cell2mat(file.units(eastIdx))}, ' '));
	ylabel(strjoin({cell2mat(file.variables(northIdx)), cell2mat(file.units(northIdx))}, ' '));
	zlabel(strjoin({cell2mat(file.variables(altitudeIdx)), cell2mat(file.units(altitudeIdx))}, ' '));
endfunction