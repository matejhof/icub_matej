% Matej Hoffmann, 12.5.2015, adapted from the script for left forearm which
% is much more comprehensive

clear all;

SAVE_FIGURES = false;
%% Init taxel positions from Andrea's calibration

load right_forearm_taxel_pos_mesh.mat; % the no_mesh is also possible, but there are no normals, so you can't overlay the triangular modules
taxel_pos = right_forearm_taxel_pos_mesh; 
[M,N] = size(taxel_pos);


%% Plot positions of calibrated taxels - Andrea

f1 = figure(1);
clf(f1);
title('Positions of taxels with their IDs (in 1st wrist FoR - FoR_8)');
hold on;

for i=1:M
    if (nnz(taxel_pos(i,:)) > 1) % it's not an all-zero row
       plot3(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),'xb');
       text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1)); % taxel ID = row nr. -1
    end
end
 h = quiver3(0 ,0, 0,0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 text(0.01,0,0,'x');
 h2 = quiver3(0,0,0, 0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 text(0,0.01,0,'y');
 h3 = quiver3(0,0,0, 0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 text(0,0,0.01,'z');

%ylim([-45 15]);
%xlim([-30 30]);
xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
set(gca,'YDir','reverse');
zlabel('Taxel position z (m)');
%set(gca,'ZDir','reverse');
axis equal;
hold off;





%% save figures
if SAVE_FIGURES
    saveas(f1,'Taxel_positions_left_forearm.fig');
    print -f1 -djpeg 'Taxel_positions_left_forearm.jpg';
    saveas(f2,'Taxel_positions_left_forearm_lowerBigPatch.fig');
    print -f2 -djpeg 'Taxel_positions_left_forearm_lowerBigPatch.jpg';
    saveas(f3,'Taxel_positions_left_forearm_upperSmallPatch.fig');
    print -f3 -djpeg 'Taxel_positions_left_forearm_upperSmallPatch.jpg';
    saveas(f31,'TriangleCenters_left_forearm_upperSmallPatch_CAD.fig');
    print -f31 -djpeg 'TriangleCenters_left_forearm_upperSmallPatch_CAD.jpg';
    saveas(f32,'Taxel_positions_left_forearm_upperSmallPatch_delPreteAndCAD.fig');
    print -f32 -djpeg 'Taxel_positions_left_forearm_upperSmallPatch_delPreteAndCAD.jpg';
    saveas(f4,'Taxel_positions_left_forearm_upperSmallPatch_allPlusFirstThreeTrianglesIndividually.fig');
    print -f4 -djpeg 'Taxel_positions_left_forearm_upperSmallPatch_allPlusFirstThreeTrianglesIndividually.jpg';
    saveas(f4,'Taxel_positions_left_forearm_upperSmallPatch_lastFourTrianglesIndividually.fig');
    print -f4 -djpeg 'Taxel_positions_left_forearm_upperSmallPatch_lastFourTrianglesIndividually.jpg';
    saveas(f6,'Taxel_positions_left_forearm_upperSmallPatch_OneTriangularModuleOverlayed.fig');
    print -f6 -djpeg 'Taxel_positions_left_forearm_upperSmallPatch_OneTriangularModuleOverlayed.jpg';
    saveas(f61,'Taxel_positions_left_forearm_lowerBigPatch_OneTriangularModuleOverlayed.fig');
    print -f61 -djpeg 'Taxel_positions_left_forearm_lowerBigPatch_OneTriangularModuleOverlayed.jpg';
end