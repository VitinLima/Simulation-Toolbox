function [val, ok, msg] = UtilFindValAt(file, targetVariable, targetEvent)
	ok = false;
	msg = "";
	
	evtTime = file.evtTimes(targetEvent);
	
	for i = [1:rows(file.data)]
		if file.data(i,1) > evtTime
			val = file.data(i,targetVariable);
			ok = true;
			return;
		end
	end
	msg = "Failed to find value";
end