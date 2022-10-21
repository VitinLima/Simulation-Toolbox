function saveImage(FILENAME, map3D)
	set(map3D.canvas.handle, 'outerposition', [0 0 1 1]);
  saveas(map3D.handle, FILENAME, 'png');
  map3D.program.transient.lastSavedDirectory = FPATH;
	set(map3D.canvas.handle, 'outerposition', get(map3D.canvas.handle, 'userdata'));
endfunction