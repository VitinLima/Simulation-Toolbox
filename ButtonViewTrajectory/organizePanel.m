function organizePanel(panel, m, n)
	c = get(panel, 'children');
	c = c(find(strcmp(get(c, 'type'), 'uicontrol') + strcmp(get(c, 'type'), 'uipanel')));
	if m < 1
		m = ceil(length(c)/n);
	elseif n < 1
		n = ceil(length(c)/m);
	end
	set(c, 'units', 'normalized');
	dm = 1/m;
	dn = 1/n;
	if m > n
		for i = 1:m
			for j = 1:n
				if (i-1)*n + j > length(c)
					return;
				end
				set(c((i-1)*n + j), 'position', [(j-1)*dn (i-1)*dm dn dm]);
			end
		end
	else
		for i = 1:m
			for j = 1:n
				if (j-1)*m + i > length(c)
					return;
				end
				set(c((j-1)*m + i), 'position', [(j-1)*dn (i-1)*dm dn dm]);
			end
		end
	end
end