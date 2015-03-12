clear;
clc;

TWO_TIME_STAMPS = false;
STARTING_ROW = 1;
FINAL_ROW = 1000;

load('/mnt/bigdata/icub/matej/skin_stimulations/right_palm/stimulation_by_experimenter_with_fingertip/data/skin/tactile_comp_right_hand/data.log');
if TWO_TIME_STAMPS
    SKIN_ACTIVATIONS = data(STARTING_ROW:FINAL_ROW,4:end);
else
     SKIN_ACTIVATIONS = data(STARTING_ROW:FINAL_ROW,4:end);
end

max_per_column = max(SKIN_ACTIVATIONS);
f1 = figure(1); clf;
    bar(max_per_column);


f2 = figure(2); clf;
hold on;
%for i=1:size(SKIN_ACTIVATIONS,2)
for i=97:144
    plot(i-1,SKIN_ACTIVATIONS(:,i),'xb'); % i-1 to go from row number to taxel ID
end
hold off;
