function imageScaleByValue(h)
  CSTR = inputdlg("Scale by:", "Scale image");
  if isempty(CSTR)
    delete(findall(ax, 'tag', 'tmp'));
    return;
  end
  s = str2double(cell2mat(CSTR));
  if isnan(s)
    waitfor(msgbox("Not a number."));
  end
  
  ydata = get(h, 'ydata');
  ydata *= s;
  set(h, 'ydata', ydata);
  xdata = get(h, 'xdata');
  xdata *= s;
  set(h, 'xdata', xdata);
end