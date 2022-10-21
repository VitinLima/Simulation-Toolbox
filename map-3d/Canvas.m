function canvas = Canvas(map3D)
  defaultSize = [.2 .0 .8 1];
	canvas.handle = axes(map3D.handle, 'tag', 'Canvas', 'outerposition', defaultSize);
	hold(canvas.handle, 'on');
	grid(canvas.handle, 'on');
	xlabel(canvas.handle, "East");
	ylabel(canvas.handle, "North");
	zlabel(canvas.handle, "Up");
  set(canvas.handle, 'userdata', defaultSize);
endfunction