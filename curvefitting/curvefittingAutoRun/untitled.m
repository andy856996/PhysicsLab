LastName = {'EE' 'EEE' 'EEG' 'GE' 'GEG' 'GGE' 'EG' 'EGG' 'EGE' 'GG' 'GEE' 'GGG'};
Age = [38;43;38;40;49];
Height = [71;69;64;67;64];
Weight = [176;163;131;133;119];
BloodPressure = [124 93; 109 77; 125 83; 117 75; 122 80];

T = table(energy,lognsse,log,...
    'RowNames',LastName)