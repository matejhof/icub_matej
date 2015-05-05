clear all;

SAVE_FIGURES = false;
%% Init taxel positions from Andrea's calibration and CAD

load left_forearm_taxel_pos_mesh.mat; % the no_mesh is also possible, but there are no normals, so you can't overlay the triangular modules
taxel_pos = left_forearm_taxel_pos_mesh; 
[M,N] = size(taxel_pos);

load left_forearm_upper_patch_7triangleMidpointsPos_iCubV1_CAD.mat;
triangle_centers_CAD_upperPatch_arbitraryFoR = left_forearm_upper_patch_7triangleMidpointsPos_iCubV1_xmlFoR_m;
triangle_centers_CAD_upperPatch_wristFoR8 = [];

load left_forearm_assembly_18coverHolesPos_iCubV1_CAD.mat;
% note, this CAD data contains also the upper patch - could be used to
% double check
triangle_centers_CAD_lowerPatches_assemblyFoR = left_forearm_lower_patch_18coverHoles_iCubV1_xmlFoR_m  ; % this FoR is also kind of arbitrary, but different than in the previous set;
triangle_centers_CAD_lowerPatches_wristFoR8 = [];

for j=1:size(triangle_centers_CAD_upperPatch_arbitraryFoR,1)
   row_vector =  triangle_centers_CAD_upperPatch_arbitraryFoR(j,:);
   column_vector = row_vector';
   column_vector_translated = column_vector - toWristFoR8_transl_m;
   column_vector_translatedAndRotated = (toWristFoR8_rotMatrix)' * column_vector_translated;
   triangle_centers_CAD_upperPatch_wristFoR8(j,:) = column_vector_translatedAndRotated';     
end

for j=1:size(triangle_centers_CAD_lowerPatches_assemblyFoR,1)
   row_vector =  triangle_centers_CAD_lowerPatches_assemblyFoR(j,:);
   column_vector = row_vector';
   column_vector_translated = column_vector - forearmAssemblytoWristFoR8_translVector_m;
   column_vector_translatedAndRotated = (forearmAssemblytoWristFoR8_rotMatrix)' * column_vector_translated;
   triangle_centers_CAD_lowerPatches_wristFoR8(j,:) = column_vector_translatedAndRotated';     
end
%% Plot positions of calibrated taxels - Andrea



f32 = figure(32);
clf(f32);
title('Positions of foreram taxels with their IDs (delPrete with CAD overlayed) - upper patch (in 1st wrist FoR - FoR_8)');
hold on;

for i=193:M
    if (nnz(taxel_pos(i,:)) > 1) % it's not an all-zero row
       plot3(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),'xb');
       if (i==208 || i==340 || i==352 || i==292 || i==304 || i==316 || i==256)
         text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1),'BackgroundColor','green'); 
       else
             text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1)); 
       end
    end
end

triangle_centers_CAD = triangle_centers_CAD_upperPatch_wristFoR8;

       plot3(triangle_centers_CAD(1,1),triangle_centers_CAD(1,2),triangle_centers_CAD(1,3),'or');
       text(triangle_centers_CAD(1,1),triangle_centers_CAD(1,2),triangle_centers_CAD(1,3),'207','BackgroundColor','red'); 
       
       plot3(triangle_centers_CAD(2,1),triangle_centers_CAD(2,2),triangle_centers_CAD(2,3),'or');
       text(triangle_centers_CAD(2,1),triangle_centers_CAD(2,2),triangle_centers_CAD(2,3),'339','BackgroundColor','red'); 
       
       plot3(triangle_centers_CAD(3,1),triangle_centers_CAD(3,2),triangle_centers_CAD(3,3),'or');
       text(triangle_centers_CAD(3,1),triangle_centers_CAD(3,2),triangle_centers_CAD(3,3),'351','BackgroundColor','red'); 
       
       plot3(triangle_centers_CAD(4,1),triangle_centers_CAD(4,2),triangle_centers_CAD(4,3),'or');
       text(triangle_centers_CAD(4,1),triangle_centers_CAD(4,2),triangle_centers_CAD(4,3),'291','BackgroundColor','red'); 
       
       plot3(triangle_centers_CAD(5,1),triangle_centers_CAD(5,2),triangle_centers_CAD(5,3),'or');
       text(triangle_centers_CAD(5,1),triangle_centers_CAD(5,2),triangle_centers_CAD(5,3),'303','BackgroundColor','red'); 
       
       plot3(triangle_centers_CAD(6,1),triangle_centers_CAD(6,2),triangle_centers_CAD(6,3),'or');
       text(triangle_centers_CAD(6,1),triangle_centers_CAD(6,2),triangle_centers_CAD(6,3),'315','BackgroundColor','red');  
       
       plot3(triangle_centers_CAD(7,1),triangle_centers_CAD(7,2),triangle_centers_CAD(7,3),'or');
       text(triangle_centers_CAD(7,1),triangle_centers_CAD(7,2),triangle_centers_CAD(7,3),'255','BackgroundColor','red');
       
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% edit by Martin Varga 16. march 2015

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% translation of sensor cordinates to match red centers
    translated_coordinates = zeros(384, 3); % new coordinates (x, y, z)
    min_max = zeros(7, 6);
    pom = [1, 1, 1, -1, -1, -1];
    for i= 1:7, 
        min_max(i,:) = pom;
    end    
% triangle center 207
    trans_207 = zeros(1,3);
    trans_207(1,1) = taxel_pos(208,1) - triangle_centers_CAD(1,1);
    trans_207(1,2) = taxel_pos(208,2) - triangle_centers_CAD(1,2);
    trans_207(1,3) = taxel_pos(208,3) - triangle_centers_CAD(1,3);
    
    for i= 205:216,
        for j=1:3
            translated_coordinates(i, j) = taxel_pos(i,j) - trans_207(1,j);
        end
    end
    
    for i= 205:216,
        for j=1:3
            if translated_coordinates(i, j) < min_max(1, j)
                min_max(1, j) = translated_coordinates(i, j);
            end
            if translated_coordinates(i, j) > min_max(1, j + 3)
                min_max(1, j + 3) = translated_coordinates(i, j);
            end    
        end
    end
    
% triangle center 255
    trans_255 = zeros(1,3);
    trans_255(1,1) = taxel_pos(256,1) - triangle_centers_CAD(7,1);
    trans_255(1,2) = taxel_pos(256,2) - triangle_centers_CAD(7,2);
    trans_255(1,3) = taxel_pos(256,3) - triangle_centers_CAD(7,3);
    
    for i= 253:264,
        for j=1:3
            translated_coordinates(i, j) = taxel_pos(i,j) - trans_255(1,j);
        end
    end
    
    for i= 253:264,
        for j=1:3
            if translated_coordinates(i, j) < min_max(2, j)
                min_max(2, j) = translated_coordinates(i, j);
            end
            if translated_coordinates(i, j) > min_max(2, j + 3)
                min_max(2, j + 3) = translated_coordinates(i, j);
            end    
        end
    end    
    

% triangle center 291
    trans_291 = zeros(1,3);
    trans_291(1,1) = taxel_pos(292,1) - triangle_centers_CAD(4,1);
    trans_291(1,2) = taxel_pos(292,2) - triangle_centers_CAD(4,2);
    trans_291(1,3) = taxel_pos(292,3) - triangle_centers_CAD(4,3);
    
    for i= 289:300,
        for j=1:3
            translated_coordinates(i, j) = taxel_pos(i,j) - trans_291(1,j);
        end
    end
    
    for i= 289:300,
        for j=1:3
            if translated_coordinates(i, j) < min_max(3, j)
                min_max(3, j) = translated_coordinates(i, j);
            end
            if translated_coordinates(i, j) > min_max(3, j + 3)
                min_max(3, j + 3) = translated_coordinates(i, j);
            end    
        end
    end 
    
% triangle center 303
    trans_303 = zeros(1,3);
    trans_303(1,1) = taxel_pos(304,1) - triangle_centers_CAD(5,1);
    trans_303(1,2) = taxel_pos(304,2) - triangle_centers_CAD(5,2);
    trans_303(1,3) = taxel_pos(304,3) - triangle_centers_CAD(5,3);
    
    for i= 301:312,
        for j=1:3
            translated_coordinates(i, j) = taxel_pos(i,j) - trans_303(1,j);
        end
    end
    
    for i= 301:312,
        for j=1:3
            if translated_coordinates(i, j) < min_max(4, j)
                min_max(4, j) = translated_coordinates(i, j);
            end
            if translated_coordinates(i, j) > min_max(4, j + 3)
                min_max(4, j + 3) = translated_coordinates(i, j);
            end    
        end
    end 
    
% triangle center 315
    trans_315 = zeros(1,3);
    trans_315(1,1) = taxel_pos(316,1) - triangle_centers_CAD(6,1);
    trans_315(1,2) = taxel_pos(316,2) - triangle_centers_CAD(6,2);
    trans_315(1,3) = taxel_pos(316,3) - triangle_centers_CAD(6,3);
    
    for i= 313:324,
        for j=1:3
            translated_coordinates(i, j) = taxel_pos(i,j) - trans_315(1,j);
        end
    end
    
    for i= 313:324,
        for j=1:3
            if translated_coordinates(i, j) < min_max(5, j)
                min_max(5, j) = translated_coordinates(i, j);
            end
            if translated_coordinates(i, j) > min_max(5, j + 3)
                min_max(5, j + 3) = translated_coordinates(i, j);
            end    
        end
    end
   
% triangle center 339
    trans_339 = zeros(1,3);
    trans_339(1,1) = taxel_pos(340,1) - triangle_centers_CAD(2,1);
    trans_339(1,2) = taxel_pos(340,2) - triangle_centers_CAD(2,2);
    trans_339(1,3) = taxel_pos(340,3) - triangle_centers_CAD(2,3);
    
    for i= 337:348,
        for j=1:3
            translated_coordinates(i, j) = taxel_pos(i,j) - trans_339(1,j);
        end
    end
    
    for i= 337:348,
        for j=1:3
            if translated_coordinates(i, j) < min_max(6, j)
                min_max(6, j) = translated_coordinates(i, j);
            end
            if translated_coordinates(i, j) > min_max(6, j + 3)
                min_max(6, j + 3) = translated_coordinates(i, j);
            end    
        end
    end
     
% triangle center 351
    trans_351 = zeros(1,3);
    trans_351(1,1) = taxel_pos(352,1) - triangle_centers_CAD(3,1);
    trans_351(1,2) = taxel_pos(352,2) - triangle_centers_CAD(3,2);
    trans_351(1,3) = taxel_pos(352,3) - triangle_centers_CAD(3,3);
    
    for i= 349:360,
        for j=1:3
            translated_coordinates(i, j) = taxel_pos(i,j) - trans_351(1,j);
        end
    end
    
    for i= 349:360,
        for j=1:3
            if translated_coordinates(i, j) < min_max(7, j)
                min_max(7, j) = translated_coordinates(i, j);
            end
            if translated_coordinates(i, j) > min_max(7, j + 3)
                min_max(7, j + 3) = translated_coordinates(i, j);
            end    
        end
    end    
    
% plot new coordinates    
for i=193:M
    if (nnz(translated_coordinates(i,:)) > 1) % it's not an all-zero row
       plot3(translated_coordinates(i,1),translated_coordinates(i,2),translated_coordinates(i,3),'ob');
       text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1)); 
    end
end

%manual corections
%291 351 x
a  = mean([min_max(3, 1);min_max(7, 4)]);
min_max(3, 1) = a;
min_max(7, 4) = a;
%303 291 x
a  = mean([min_max(4, 1 );min_max(3, 4)]);
min_max(4, 1) = a;
min_max(3, 4) = a;
%303 315 y
a  = mean([min_max(4, 2 );min_max(5, 5)]);
min_max(4, 2) = a;
min_max(5, 5) = a;
%255 315 x
a  = mean([min_max(2, 1 );min_max(5, 4)]);
min_max(2, 1) = a;
min_max(5, 4) = a;
%351 339 y
a  = mean([min_max(7, 2 );min_max(6, 5)]);
min_max(7, 2) = a;
min_max(6, 5) = a;
%339 207 x
a  = mean([min_max(6, 1 );min_max(1, 4)]);
min_max(6, 1) = a;
min_max(1, 4) = a;

%manual corrections 2 (x acording to y axis)

% 3 middle triangles
a  = mean([ - min_max(3, 1);min_max(3, 4)]);
min_max(3, 1) = - a;
min_max(3, 4) = a;
min_max(7, 4) = - a;
min_max(4, 1) = a;

% 315 330
min_max(5, 1) = - min_max(6, 4);
min_max(5, 4) = - min_max(6, 1);

% 315 255
min_max(2, 1) =  min_max(5, 4);

% 255 207 
a  = mean([min_max(2, 4); - min_max(1, 1)]);
a = a;
min_max(2, 4) = a;
min_max(1, 1) = - a;

% 315 339 max y 303 351 min y
a  = mean([min_max(5, 5);  min_max(6, 5)]);
min_max(5, 5) = a;
min_max(6, 5) = a;
min_max(7, 2) = a;
min_max(4, 2) = a;

%255 207 y
a  = max([min_max(1, 5);  min_max(2, 5)]);
min_max(1, 5) = a;
min_max(2, 5) = a;

a  = min([min_max(1, 2);  min_max(2, 2)]);
min_max(1, 2) = a;
min_max(2, 2) = a;

%315 339 min y
a  = min([min_max(5, 2);  min_max(6, 2)]);
min_max(5, 2) = a;
min_max(6, 2) = a;

%303 351 max y
min_max(4, 5) = min_max(7, 5);

%351 min x
min_max(7, 1) = - min_max(4, 4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%maybe unnecesary no gaps correction (you can delete this block)

% 291
min_max(3, 2) = min_max(5, 5);

% 207
min_max(1, 5) = min_max(5, 5);

%255
min_max(2, 5) = min_max(5, 5);

%315
min_max(5, 1) = 0;

%339
min_max(6, 4) = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% draws "rectangles"
for i= 1:7
    %uncoment to see line conecting minimal and maximal point of rectangle 
    %plot3([min_max(i,1) min_max(i,4)],[min_max(i,2) min_max(i,5)],[min_max(i,3) min_max(i,6)]);
    
    plot3([min_max(i,1) min_max(i,4)],[min_max(i,5) min_max(i,5)],[min_max(i,3) min_max(i,3)]);
    plot3([min_max(i,4) min_max(i,4)],[min_max(i,5) min_max(i,5)],[min_max(i,3) min_max(i,6)]);
    plot3([min_max(i,4) min_max(i,1)],[min_max(i,5) min_max(i,5)],[min_max(i,6) min_max(i,6)]);
    plot3([min_max(i,1) min_max(i,1)],[min_max(i,5) min_max(i,5)],[min_max(i,3) min_max(i,6)]);
    
    plot3([min_max(i,1) min_max(i,4)],[min_max(i,2) min_max(i,2)],[min_max(i,3) min_max(i,3)]);
    plot3([min_max(i,4) min_max(i,4)],[min_max(i,2) min_max(i,2)],[min_max(i,3) min_max(i,6)]);
    plot3([min_max(i,4) min_max(i,1)],[min_max(i,2) min_max(i,2)],[min_max(i,6) min_max(i,6)]);
    plot3([min_max(i,1) min_max(i,1)],[min_max(i,2) min_max(i,2)],[min_max(i,3) min_max(i,6)]);
    
    plot3([min_max(i,1) min_max(i,1)],[min_max(i,2) min_max(i,5)],[min_max(i,3) min_max(i,3)]);
    plot3([min_max(i,4) min_max(i,4)],[min_max(i,2) min_max(i,5)],[min_max(i,3) min_max(i,3)]);
    plot3([min_max(i,4) min_max(i,4)],[min_max(i,2) min_max(i,5)],[min_max(i,6) min_max(i,6)]);
    plot3([min_max(i,1) min_max(i,1)],[min_max(i,2) min_max(i,5)],[min_max(i,6) min_max(i,6)]);
    
    
    
end


m_m = zeros(3, 6);

% merge rects 3 , 4 , 7 into m_m[1]

m_m(1,1) = min_max(7,1); 
m_m(1,2) = min_max(3,2);
m_m(1,3) = min_max(3,3);
m_m(1,4) = min_max(4,4);
m_m(1,5) = min_max(3,5);
m_m(1,6) = min_max(4,6);

% merge rects 1, 6 into m_m[2]

m_m(2,1) = min_max(1,1); 
m_m(2,2) = min_max(1,2);
m_m(2,3) = min_max(6,3);
m_m(2,4) = min_max(6,4);
m_m(2,5) = min_max(1,5);
m_m(2,6) = min_max(1,6);

% merge rects 2, 5 into m_m[3]

m_m(3,1) = min_max(5,1); 
m_m(3,2) = min_max(2,2);
m_m(3,3) = min_max(5,3);
m_m(3,4) = min_max(2,4);
m_m(3,5) = min_max(2,5);
m_m(3,6) = min_max(2,6);


%final adjustments

m_m(2,3) = m_m(3,3);
m_m(2,6) = m_m(3,6);

%z
m_m(1,3) = m_m(1,3) - 0.005;
m_m(2,3) = m_m(2,3) - 0.005;
m_m(3,3) = m_m(3,3) - 0.005;

m_m(1,6) = m_m(1,6) + 0.005;
m_m(2,6) = m_m(2,6) + 0.005;
m_m(3,6) = m_m(3,6) + 0.005;

%x
m_m(1,1) = m_m(1,1) - 0.005;
m_m(2,1) = m_m(2,1) - 0.005;

m_m(1,4) = m_m(1,4) + 0.005;
m_m(3,4) = m_m(3,4) + 0.005;

%y
m_m(1,5) = m_m(1,5) + 0.005;

m_m(2,2) = m_m(2,2) - 0.005;
m_m(3,2) = m_m(3,2) - 0.005;

for i= 1:3
    %uncoment to see line conecting minimal and maximal point of rectangle 
    %plot3([min_max(i,1) min_max(i,4)],[min_max(i,2) min_max(i,5)],[min_max(i,3) min_max(i,6)]);
    
    plot3([m_m(i,1) m_m(i,4)],[m_m(i,5) m_m(i,5)],[m_m(i,3) m_m(i,3)], 'Color', 'r');
    plot3([m_m(i,4) m_m(i,4)],[m_m(i,5) m_m(i,5)],[m_m(i,3) m_m(i,6)], 'Color', 'r');
    plot3([m_m(i,4) m_m(i,1)],[m_m(i,5) m_m(i,5)],[m_m(i,6) m_m(i,6)], 'Color', 'r');
    plot3([m_m(i,1) m_m(i,1)],[m_m(i,5) m_m(i,5)],[m_m(i,3) m_m(i,6)], 'Color', 'r');
    
    plot3([m_m(i,1) m_m(i,4)],[m_m(i,2) m_m(i,2)],[m_m(i,3) m_m(i,3)], 'Color', 'r');
    plot3([m_m(i,4) m_m(i,4)],[m_m(i,2) m_m(i,2)],[m_m(i,3) m_m(i,6)], 'Color', 'r');
    plot3([m_m(i,4) m_m(i,1)],[m_m(i,2) m_m(i,2)],[m_m(i,6) m_m(i,6)], 'Color', 'r');
    plot3([m_m(i,1) m_m(i,1)],[m_m(i,2) m_m(i,2)],[m_m(i,3) m_m(i,6)], 'Color', 'r');
    
    plot3([m_m(i,1) m_m(i,1)],[m_m(i,2) m_m(i,5)],[m_m(i,3) m_m(i,3)], 'Color', 'r');
    plot3([m_m(i,4) m_m(i,4)],[m_m(i,2) m_m(i,5)],[m_m(i,3) m_m(i,3)], 'Color', 'r');
    plot3([m_m(i,4) m_m(i,4)],[m_m(i,2) m_m(i,5)],[m_m(i,6) m_m(i,6)], 'Color', 'r');
    plot3([m_m(i,1) m_m(i,1)],[m_m(i,2) m_m(i,5)],[m_m(i,6) m_m(i,6)], 'Color', 'r');
    
    
    
end




   [ vystup, extremes ] = Translation(taxel_pos, 1, 1 + 11, triangle_centers_CAD_lowerPatches_wristFoR8(10,:));
   


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% end of Martin Varga 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 h = quiver3(0 ,0, 0,0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 text(0.01,0,0,'x');
 h2 = quiver3(0,0,0, 0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 text(0,0.01,0,'y');
 h3 = quiver3(0,0,0, 0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 text(0,0,0.01,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Here starts figure 33

f33 = figure(33);
clf(f33);
title('Positions of forearm taxels with their IDs (delPrete with CAD overlayed) - lower patch (in 1st wrist FoR - FoR_8)');
hold on;

for i=1:192
    if (nnz(taxel_pos(i,:)) > 1) % it's not an all-zero row
       plot3(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),'xb');
       if (mod(i,12) == 4) % should be triangle midpoints
         text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1),'BackgroundColor','green'); 
       else
             text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1)); 
       end
    end
end

triangle_centers_CAD = triangle_centers_CAD_lowerPatches_wristFoR8;
for i=1:size(triangle_centers_CAD,1)
       plot3(triangle_centers_CAD(i,1),triangle_centers_CAD(i,2),triangle_centers_CAD(i,3),'or');
       text(triangle_centers_CAD(i,1),triangle_centers_CAD(i,2),triangle_centers_CAD(i,3), int2str(i) ,'BackgroundColor','red'); 
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

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;


f4 = figure(4);
clf(f4);
set(f4,'Name','Positions of foreram taxels - upper patch - all + individual triangles (number ~ taxelID) (in 1st wrist FoR - FoR_8)');


subplot(3,3,1);
hold on;
for i=193:M
    if (nnz(taxel_pos(i,:)) > 1) % it's not an all-zero row
       plot3(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),'xb');
       if (i==208 || i==340 || i==352 || i==292 || i==304 || i==316 || i==256)
         text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1),'BackgroundColor','green'); 
       else
             text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1)); 
       end
    end
   
end

triangle_centers_CAD = triangle_centers_CAD_wristFoR8;

plot3(triangle_centers_CAD(1,1),triangle_centers_CAD(1,2),triangle_centers_CAD(1,3),'or');
text(triangle_centers_CAD(1,1),triangle_centers_CAD(1,2),triangle_centers_CAD(1,3),'207','BackgroundColor','red'); 
       
plot3(triangle_centers_CAD(2,1),triangle_centers_CAD(2,2),triangle_centers_CAD(2,3),'or');
text(triangle_centers_CAD(2,1),triangle_centers_CAD(2,2),triangle_centers_CAD(2,3),'339','BackgroundColor','red'); 
       
plot3(triangle_centers_CAD(3,1),triangle_centers_CAD(3,2),triangle_centers_CAD(3,3),'or');
text(triangle_centers_CAD(3,1),triangle_centers_CAD(3,2),triangle_centers_CAD(3,3),'351','BackgroundColor','red'); 
       
plot3(triangle_centers_CAD(4,1),triangle_centers_CAD(4,2),triangle_centers_CAD(4,3),'or');
text(triangle_centers_CAD(4,1),triangle_centers_CAD(4,2),triangle_centers_CAD(4,3),'291','BackgroundColor','red'); 
       
plot3(triangle_centers_CAD(5,1),triangle_centers_CAD(5,2),triangle_centers_CAD(5,3),'or');
text(triangle_centers_CAD(5,1),triangle_centers_CAD(5,2),triangle_centers_CAD(5,3),'303','BackgroundColor','red'); 
       
plot3(triangle_centers_CAD(6,1),triangle_centers_CAD(6,2),triangle_centers_CAD(6,3),'or');
text(triangle_centers_CAD(6,1),triangle_centers_CAD(6,2),triangle_centers_CAD(6,3),'315','BackgroundColor','red');  
      
plot3(triangle_centers_CAD(7,1),triangle_centers_CAD(7,2),triangle_centers_CAD(7,3),'or');
text(triangle_centers_CAD(7,1),triangle_centers_CAD(7,2),triangle_centers_CAD(7,3),'255','BackgroundColor','red'); 

 h = quiver3(0 ,0, 0,0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 text(0.01,0,0,'x');
 h2 = quiver3(0,0,0, 0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 text(0,0.01,0,'y');
 h3 = quiver3(0,0,0, 0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 text(0,0,0.01,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;

subplot(3,3,2);
hold on;
first_taxel_ID = 252; 
for i=1:12; % with i starting from 1, we get the conversion from taxel ID to row number in file
    if (nnz(taxel_pos(first_taxel_ID+i,:)) > 1) % it's not an all-zero row
       if ((i==7) || (i==11)) %thermal pad
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'.b');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'FontSize',8); 
       elseif (i==4) %ytriangle midpoint
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'BackgroundColor','green'); 
       else % normal taxel
         plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');  
         text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1)); 
       end
       
    end
end
plot3(triangle_centers_CAD(7,1),triangle_centers_CAD(7,2),triangle_centers_CAD(7,3),'or');
text(triangle_centers_CAD(7,1),triangle_centers_CAD(7,2),triangle_centers_CAD(7,3),'255','BackgroundColor','red'); 

 h = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 %text(0.001,0,0,'x');
 h2 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0.001,0,'y');
 h3 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0,0.001,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;


subplot(3,3,3);
hold on;
first_taxel_ID = 312;
for i=1:12;
    if (nnz(taxel_pos(first_taxel_ID+i,:)) > 1) % it's not an all-zero row
       if ((i==7) || (i==11)) %thermal pad
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'.b');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'FontSize',8); 
       elseif (i==4) %ytriangle midpoint
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'BackgroundColor','green'); 
       else % normal taxel
         plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');  
         text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1)); 
       end
    end
end
plot3(triangle_centers_CAD(6,1),triangle_centers_CAD(6,2),triangle_centers_CAD(6,3),'or');
text(triangle_centers_CAD(6,1),triangle_centers_CAD(6,2),triangle_centers_CAD(6,3),'315','BackgroundColor','red');  

 h = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 %text(0.001,0,0,'x');
 h2 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0.001,0,'y');
 h3 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0,0.001,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;

subplot(3,3,4);
hold on;
first_taxel_ID = 300;
for i=1:12;
    if (nnz(taxel_pos(first_taxel_ID+i,:)) > 1) % it's not an all-zero row
       if ((i==7) || (i==11)) %thermal pad
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'.b');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'FontSize',8); 
       elseif (i==4) %ytriangle midpoint
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'BackgroundColor','green'); 
       else % normal taxel
         plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');  
         text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1)); 
       end
    end
end
plot3(triangle_centers_CAD(5,1),triangle_centers_CAD(5,2),triangle_centers_CAD(5,3),'or');
text(triangle_centers_CAD(5,1),triangle_centers_CAD(5,2),triangle_centers_CAD(5,3),'303','BackgroundColor','red'); 

 h = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 %text(0.001,0,0,'x');
 h2 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0.001,0,'y');
 h3 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0,0.001,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;

subplot(3,3,5);
hold on;
first_taxel_ID = 288;
for i=1:12;
    if (nnz(taxel_pos(first_taxel_ID+i,:)) > 1) % it's not an all-zero row
       if ((i==7) || (i==11)) %thermal pad
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'.b');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'FontSize',8); 
       elseif (i==4) %ytriangle midpoint
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'BackgroundColor','green'); 
       else % normal taxel
         plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');  
         text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1)); 
       end
    end
end
plot3(triangle_centers_CAD(4,1),triangle_centers_CAD(4,2),triangle_centers_CAD(4,3),'or');
text(triangle_centers_CAD(4,1),triangle_centers_CAD(4,2),triangle_centers_CAD(4,3),'291','BackgroundColor','red'); 

 h = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 %text(0.001,0,0,'x');
 h2 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0.001,0,'y');
 h3 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0,0.001,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;

subplot(3,3,6);
hold on;
first_taxel_ID = 348;
for i=1:12;
    if (nnz(taxel_pos(first_taxel_ID+i,:)) > 1) % it's not an all-zero row
       if ((i==7) || (i==11)) %thermal pad
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'.b');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'FontSize',8); 
       elseif (i==4) %ytriangle midpoint
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'BackgroundColor','green'); 
       else % normal taxel
         plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');  
         text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1)); 
       end
    end
end
plot3(triangle_centers_CAD(3,1),triangle_centers_CAD(3,2),triangle_centers_CAD(3,3),'or');
text(triangle_centers_CAD(3,1),triangle_centers_CAD(3,2),triangle_centers_CAD(3,3),'351','BackgroundColor','red'); 

 h = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 %text(0.001,0,0,'x');
 h2 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0.001,0,'y');
 h3 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0,0.001,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;

subplot(3,3,7);
hold on;
first_taxel_ID = 336;
for i=1:12;
    if (nnz(taxel_pos(first_taxel_ID+i,:)) > 1) % it's not an all-zero row
       if ((i==7) || (i==11)) %thermal pad
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'.b');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'FontSize',8); 
       elseif (i==4) %ytriangle midpoint
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'BackgroundColor','green'); 
       else % normal taxel
         plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');  
         text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1)); 
       end
    end
end
plot3(triangle_centers_CAD(2,1),triangle_centers_CAD(2,2),triangle_centers_CAD(2,3),'or');
text(triangle_centers_CAD(2,1),triangle_centers_CAD(2,2),triangle_centers_CAD(2,3),'339','BackgroundColor','red'); 

 h = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 %text(0.001,0,0,'x');
 h2 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0.001,0,'y');
 h3 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0,0.001,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;

subplot(3,3,8);
hold on;
first_taxel_ID = 204;
for i=1:12;
    if (nnz(taxel_pos(first_taxel_ID+i,:)) > 1) % it's not an all-zero row
       if ((i==7) || (i==11)) %thermal pad
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'.b');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'FontSize',8); 
       elseif (i==4) %ytriangle midpoint
        plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');
        text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1),'BackgroundColor','green'); 
       else % normal taxel
         plot3(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),'xb');  
         text(taxel_pos(first_taxel_ID+i,1),taxel_pos(first_taxel_ID+i,2),taxel_pos(first_taxel_ID+i,3),int2str(first_taxel_ID+i-1)); 
       end
    end
end
plot3(triangle_centers_CAD(1,1),triangle_centers_CAD(1,2),triangle_centers_CAD(1,3),'or');
text(triangle_centers_CAD(1,1),triangle_centers_CAD(1,2),triangle_centers_CAD(1,3),'207','BackgroundColor','red'); 

 h = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 %text(0.001,0,0,'x');
 h2 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0.001,0,'y');
 h3 = quiver3(taxel_pos(first_taxel_ID+1,1),taxel_pos(first_taxel_ID+1,2),taxel_pos(first_taxel_ID+1,3),0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 2, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0,0.001,'z');

xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
axis equal;
hold off;


%% Taxel positions from calibration vs. projection of triangular modules

%% UPPER PATCH ON FOREARM
% note, it is the small patch on top of forearm, but in Marco's files, this
% is called lower

% transform canonical triangle to the position and orientation of the triangle on the outer side of the forearm 
% (if we need a triangle mirrored in x (see the forearm_ini_generator.xlsx -
% mirror set to 1 for all this patch; note in the xlsx this patch is called upper, even if it is kind of lower in the home posture) 
% see /media/DATA/my_matlab/skin/singleTriangle for plots 

% get taxel normal of corresponding triangle midpoint
middle_taxel_ID = 291;
first_taxel_ID = middle_taxel_ID-3;

% We will transform the canonical triangle into the correct position and
% orientation, such that its mid-taxel coincides with that from Andrea's
% calibration - the position is known from the positions file; then the
% taxel normal is known

% first the translation
Homo_translation_wristToHat = [1 0 0 taxel_pos(middle_taxel_ID+1,1); 0 1 0 taxel_pos(middle_taxel_ID+1,2); 0 0 1 taxel_pos(middle_taxel_ID+1,3); 0 0 0 1];

taxel_normal = [taxel_pos(middle_taxel_ID+1,4) taxel_pos(middle_taxel_ID+1,5) taxel_pos(middle_taxel_ID+1,6)]; 
% define taxel orientation
% idea: take the normal of the taxel as the new z; for y, try to stay as
% close as possible to the original y, but perpendicular to the z axis -
% therefore, project onto the plane perpendicular to the normal vector;
% x then comes automatically as the remaining orthogonal axis

x = [1 0 0]; % original axes
y = [0 1 0];
z = [0 0 1];

z_hat = taxel_normal;
z_hat = z_hat / norm(z_hat);
y_projeted_onto_z_hat = norm(y) * dot(y,z_hat) * z_hat; % this is a "difference vector" from the orig. y-axis to the target plane (perpendicular to z_hat) 
y_hat = y - y_projeted_onto_z_hat;
y_hat = y_hat / norm(y_hat);
x_hat = -cross(z_hat,y_hat);
x_hat = x_hat / norm(x_hat);
% hat is the new taxel FoR

Homo_rotation_wristToHat = [x_hat(1) y_hat(1) z_hat(1) 0;...
                 x_hat(2) y_hat(2) z_hat(2) 0;...  
                 x_hat(3) y_hat(3) z_hat(3) 0;...
                 0          0       0       1];
                 
 
% first additional rotations for triangle to lend in the right orientation

% a bit around z
theta2 = 60;
Homo_Rot_About_Z = [cosd(theta2) -sind(theta2) 0 0; sind(theta2) cosd(theta2) 0 0; 0 0 1 0; 0 0 0 1];

Homo_OrigToHatFoR = Homo_translation_wristToHat*Homo_rotation_wristToHat*Homo_Rot_About_Z; % ! has to be in this order
%Homo_OrigToHatFoR = eye(4)*Homo_translation;
%Homo_OrigToHatFoR = Homo_rotation; 
canonTaxels_newPosAndOri_origFoR = transformNominalTriangle(first_taxel_ID,Homo_OrigToHatFoR,false);  

f6 = figure(6);
clf(f6);
title('Positions of foreram taxels with their IDs - upper patch + 1 triangle overlayed (in 1st wrist FoR - FoR_8)');
hold on;

% plot all the taxels from Andrea's calibration
for i=193:M
    if (nnz(taxel_pos(i,:)) > 1) % it's not an all-zero row
       plot3(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),'xb');
       text(taxel_pos(i,1),taxel_pos(i,2),taxel_pos(i,3),int2str(i-1)); 
    end
end
% 1st wrist FoR
 h = quiver3(0 ,0, 0,0.02,0,0);
 set(h, 'Color', 'r', 'LineWidth', 3, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 text(0.01,0,0,'x');
 h2 = quiver3(0,0,0, 0,0.02,0);
 set(h2, 'Color', 'g', 'LineWidth', 3, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 text(0,0.01,0,'y');
 h3 = quiver3(0,0,0, 0,0,0.02);
 set(h3, 'Color', 'b', 'LineWidth', 3, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 text(0,0,0.01,'z');

 % overlay the canonical triangle
 for i = 1:length(canonTaxels_newPosAndOri_origFoR)
        if (i==7) || (i==11) % thermal pads
            %radius = rtaxel/2;
        else
             plot3(canonTaxels_newPosAndOri_origFoR(i).Pos(1),canonTaxels_newPosAndOri_origFoR(i).Pos(2),canonTaxels_newPosAndOri_origFoR(i).Pos(3),'Marker','o','MarkerSize',15,'Color','g');
             text(canonTaxels_newPosAndOri_origFoR(i).Pos(1),canonTaxels_newPosAndOri_origFoR(i).Pos(2),canonTaxels_newPosAndOri_origFoR(i).Pos(3),int2str(canonTaxels_newPosAndOri_origFoR(i).ID),'Color','green');
            %radius = rtaxel;
        end
        %x      = radius*cos(ang) + transf_taxels(i).Pos(1);
        %y      = radius*sin(ang) + transf_taxels(i).Pos(2);
        %z      =  repmat(transf_taxels(i).Pos(3),1,length(ang));
        %  ht = plot3(x,y,z,'--.r');
     
 end
 plot3(triangle_centers_CAD(4,1),triangle_centers_CAD(4,2),triangle_centers_CAD(4,3),'or');
text(triangle_centers_CAD(4,1),triangle_centers_CAD(4,2),triangle_centers_CAD(4,3),'291','BackgroundColor','red'); 
 
% triangle midpoint FoR
AXIS_LENGTH_MULTIPLIER = 1/100; % downsize normal axes length to match scale
 h = quiver3(taxel_pos(middle_taxel_ID+1,1) ,taxel_pos(middle_taxel_ID+1,2), taxel_pos(middle_taxel_ID+1,3),x_hat(1)*AXIS_LENGTH_MULTIPLIER,x_hat(2)*AXIS_LENGTH_MULTIPLIER,x_hat(3)*AXIS_LENGTH_MULTIPLIER);
 set(h, 'Color', 'r', 'LineWidth', 3, 'MaxHeadSize', 4, 'ShowArrowHead', 'on');
 %text(0.01,0,0,'x');
 h2 = quiver3(taxel_pos(middle_taxel_ID+1,1) ,taxel_pos(middle_taxel_ID+1,2), taxel_pos(middle_taxel_ID+1,3),y_hat(1)*AXIS_LENGTH_MULTIPLIER,y_hat(2)*AXIS_LENGTH_MULTIPLIER,y_hat(3)*AXIS_LENGTH_MULTIPLIER);
 set(h2, 'Color', 'g', 'LineWidth', 3, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %text(0,0.01,0,'y');
 h3 = quiver3(taxel_pos(middle_taxel_ID+1,1) ,taxel_pos(middle_taxel_ID+1,2), taxel_pos(middle_taxel_ID+1,3),z_hat(1)*AXIS_LENGTH_MULTIPLIER,z_hat(2)*AXIS_LENGTH_MULTIPLIER,z_hat(3)*AXIS_LENGTH_MULTIPLIER);
 set(h3, 'Color', 'b', 'LineWidth', 3, 'MaxHeadSize', 4, 'ShowArrowHead', 'on')
 %  text(0,0,0.01,'z'); 
 
xlabel('Taxel position x (m)');
set(gca,'XDir','reverse');
ylabel('Taxel position y (m)');
zlabel('Taxel position z (m)');
set(gca,'ZDir','reverse');
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