function exportKMLLine(FID, X,Y,Z, NAME, COLOR, LW, DESCRIPTION, P0, D)
	if isempty(Z)
		altitudeMode = "clampToGround";
	else
		altitudeMode = "absolute";
	end
	
	fdisp(FID,"  <Placemark>");
	fdisp(FID,["    <name>",NAME,"</name>"]);
	fdisp(FID,["    <description><![CDATA[ ",DESCRIPTION," ]]></description>"]);
	fdisp(FID,"    <Style>");
	fdisp(FID,"      <IconStyle>");
	fdisp(FID,"        <Icon/>");
	fdisp(FID,"      </IconStyle>");
	fdisp(FID,"      <LineStyle>");
	alpha = "ff";
	c = round(255*COLOR);
	r = tolower(num2str(dec2hex(c(1),2)));
	g = tolower(num2str(dec2hex(c(2),2)));
	b = tolower(num2str(dec2hex(c(3),2)));
	fdisp(FID,["        <color>",alpha,b,g,r,"</color>"]);
	fdisp(FID,["        <width>",num2str(LW),"</width>"]);
	fdisp(FID,"      </LineStyle>");
	fdisp(FID,"    </Style>");
	fdisp(FID,"    <LineString>");
	fdisp(FID,["      <altitudeMode>",altitudeMode,"</altitudeMode>"]);
	fdisp(FID,"      <tessellate>1</tessellate>");
	fdisp(FID,"      <coordinates>");

	##for i = 1:rows(points)
	##	newLat = lat + ellipsis(i,2) / METERS_PER_DEGREE_LATITUDE;
	##	newLon = lon + ellipsis(i,1) / metersPerDegreeLongitude;
	##	fputs(FID,num2str(points(i,2),15));
	##	fputs(FID,",");
	##	fputs(FID,num2str(points(i,1),15));
	##	fputs(FID,",");
	##	fputs(FID,num2str(points(i,3),15));
	##	fputs(FID,"\r\n");
	##endfor
	if !isempty(Z)
		points = P0 + [X;Y;Z] ./ D;
		fprintf(FID, "        %.15f,%.15f,%.15f\r\n", points);
	else
		points = P0(1:2,:) + [X;Y] ./ D(1:2,:);
		fprintf(FID, "        %.15f,%.15f,0.0\r\n", points);
	end

	fdisp(FID,"      </coordinates>");
	fdisp(FID,"    </LineString>");
	fdisp(FID,"  </Placemark>");
##	format;
end