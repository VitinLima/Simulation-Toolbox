function imageScaleToLength(h)
  ax = get(h,'parent');
  
  p = [0 0; 0 0];
  b1 = waitforbuttonpress;
  cp1 = get(ax, 'currentpoint');
  dz = cp1(2,3) - cp1(1,3);
  if abs(dz) > 0.1
    dx = cp1(2,1) - cp1(1,1);
    dy = cp1(2,2) - cp1(1,2);
    p(1,1) = cp1(1,1) - dx/dz*cp1(1,3);
    p(1,2) = cp1(1,2) - dy/dz*cp1(1,3);
  else
    p(1,1) = cp1(1,1);
    p(1,2) = cp1(1,2);
  end
  l1 = line(ax, p(1,1), p(1,2), 0, 'marker', '*', 'color', 'red', 'tag', "tmp", 'displayname', 'Scaler marker 1');
  b2 = waitforbuttonpress;
  cp2 = get(ax, 'currentpoint');
  dz = cp1(2,3) - cp1(1,3);
  if abs(dz) > 0.1
    dx = cp2(2,1) - cp2(1,1);
    dy = cp2(2,2) - cp2(1,2);
    p(2,1) = cp2(1,1) - dx/dz*cp2(1,3);
    p(2,2) = cp2(1,2) - dy/dz*cp2(1,3);
  else
    p(2,1) = cp2(1,1);
    p(2,2) = cp2(1,2);
  end
  l2 = line(ax, p(2,1), p(2,2), 0, 'marker', '*', 'color', 'red', 'tag', "tmp", 'displayname', 'Scaler marker 2');
  dx = p(2,1) - p(1,1);
  dy = p(2,2) - p(1,2);
  d = sqrt(dx*dx + dy*dy);
  
  CSTR = inputdlg("Scale:", "Scale image");
  if isempty(CSTR)
    delete([l1 l2]);
    return;
  end
  s = str2double(cell2mat(CSTR));
  if isnan(s)
    waitfor(msgbox("Not a number."));
  end
  
  s /= d;
  ydata = get(h, 'ydata');
  ydata *= s;
  set(h, 'ydata', ydata);
  xdata = get(h, 'xdata');
  xdata *= s;
  set(h, 'xdata', xdata);
  
  delete([l1 l2]);
end