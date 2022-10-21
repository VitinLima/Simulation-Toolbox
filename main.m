close('all');
clear;
clc;

program.pwd = pwd;
choices = {
	"Load file",
	"Change units",
	"Search value",
	"Create graph",
	"View Trajectory"
};

##cd(strjoin({program.pwd, "ButtonLoadFile"}, filesep));
##program.file = ORSimulationParser("Nominal_13.csv", program.pwd);
##cd(strjoin({program.pwd, "ButtonViewTrajectory"}, filesep));
##program = ButtonViewTrajectory(program);
##return;

while choice = menu("Main menu", choices)
	switch(choice)
		case 1
			cd(strjoin({program.pwd, "ButtonLoadFile"}, filesep));
			program = ORSimulationParser(program);
		case 2
			cd(strjoin({program.pwd, "ButtonChangeUnits"}, filesep));
			program = ChangeUnits(program);
		case 3
			cd(strjoin({program.pwd, "ButtonSearchValue"}, filesep));
			ButtonSearchValue(program.file);
		case 4
			cd(strjoin({program.pwd, "ButtonCreateGraph"}, filesep));
			ButtonCreateGraph(program);
		case 5
			cd(strjoin({program.pwd, "ButtonViewTrajectory"}, filesep));
			program = ButtonViewTrajectory(program);
		otherwise
			choice = 0;
	endswitch
endwhile