function imageDisplay(ax)
  [FNAME,FPATH,Fileltidx] = uigetfile({"*.jpg","Digital image format which contains compressed image data";"*.png","Portable Network Graphic"},"Select image:");
	if FNAME == 0
		return;
	end
	[IMG, MAP, ALPHA] = imread([FPATH,filesep,FNAME]);
	if IMG == -1
		return;
	end
  h = findobj(ax, 'tag', "map");
  if isempty(h)
    image(IMG, 'parent', ax, 'tag', "map");
  else
    set(h, 'cdata', IMG);
  end
end