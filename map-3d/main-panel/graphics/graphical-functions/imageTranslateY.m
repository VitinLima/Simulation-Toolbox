function imageTranslateY(h)
  CSTR = inputdlg("Translate y:", "Translate image");
  if isempty(CSTR)
    return;
  end
  dy = str2double(cell2mat(CSTR));
  if isnan(dy)
    waitfor(msgbox("Not a number."));
  end
  ydata = get(h, 'ydata');
  ydata += dy;
  set(h, 'ydata', ydata);
end