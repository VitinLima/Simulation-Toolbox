function imageSetOrigin(h)
  ax = get(h,'parent');
  
  p = [0 0];
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
  
  xdata = get(h, 'xdata');
  xdata -= p(1);
  set(h, 'xdata', xdata);
  ydata = get(h, 'ydata');
  ydata -= p(2);
  set(h, 'ydata', ydata);
end