function imageTranslateX(h)
  CSTR = inputdlg("Translate x:", "Translate image");
  if isempty(CSTR)
    return;
  end
  dx = str2double(cell2mat(CSTR));
  if isnan(dx)
    waitfor(msgbox("Not a number."));
  end
  xdata = get(h, 'xdata');
  xdata += dx;
  set(h, 'xdata', xdata);
end