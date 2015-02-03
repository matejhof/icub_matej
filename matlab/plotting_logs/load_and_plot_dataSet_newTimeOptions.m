% This script plots data coming from different ports (sensors) from the
% iCub, as recorded by a collection of data dumpers
% The format of individual log files (data.log) is [pck id] [time  stamp]
% [bottle content]
% With special --txTime --rxTime option for dataDumper, it is [pck id]
% [time  stamp sender] [time stamp receiver]
% This script loads the data, adds extra time columns for diagnostics and
% then plots data
% The format of internal vectors of individual fields (e.g., joints.head,
% inertial,  skin.taxels_right_arm, forces_and_torques.right_arm) after
% preprocessing is:
%[time sender starting at 0] [delta time sender - this minus prev. time stamp]
%[time receiver starting at 0] [delta time receiver - this minus prev. time stamp]
%[pck id] [orig abs time stamp 1] [orig abs time stamp 2]
% if there was only one time stamp, respective columns are just copies
% ! need to set the TWO_TIME_STAMPS variable correctly

% Matej Hoffmann, matej.hoffmann@iit.it, March 2014

clear;
clc;

TWO_TIME_STAMPS = true; % USER EDIT
% the new data dumper with txTime and rxTime 
SAVE_FIGURES = true; % USER EDIT

TIME_FROM_ZERO_1_COLUMN = 1;
TIME_FROM_ZERO_DELTA_1_COLUMN = 2;
TIME_FROM_ZERO_2_COLUMN = 3;
TIME_FROM_ZERO_DELTA_2_COLUMN = 4;
PACKET_ID_COLUMN = 5;
TIME_ABS_1_COLUMN = 6;
TIME_ABS_2_COLUMN = 7;

% USER EDIT - user can choose 
% in the single time stamp case, they will be both the same
CHOSEN_TIME_COLUMN = TIME_FROM_ZERO_2_COLUMN; % user can choose - 2 is receiver
CHOSEN_TIME_DELTA_COLUMN = TIME_FROM_ZERO_DELTA_2_COLUMN;


%% load data
%PATH = '../app/scripts/data_archive/real/20131105_doubleTouchLogAllTest/data/';
%PATH = '/mnt/bigdata/icub/matej/skin_stimulations/right_palm/stimulation_by_experimenter_with_fingertip/data/';
PATH = '/mnt/bigdata/icub/matej/skin_stimulations/right_forearm/stimulation_by_experimenter_thumb/data/'; % USER EDIT
joints.head = load([PATH 'joints/head_joints/data.log']);
joints.left_arm = load([PATH 'joints/leftArm_joints/data.log']);
joints.left_leg = load([PATH 'joints/leftLeg_joints/data.log']);
joints.right_arm = load([PATH 'joints/rightArm_joints/data.log']);
joints.right_leg = load([PATH 'joints/rightLeg_joints/data.log']);
joints.torso = load([PATH 'joints/torso_joints/data.log']);
inertial = load([PATH 'inertial/data.log']);
images.left = load([PATH 'images/left/data.log']);
images.right = load([PATH 'images/right/data.log']);
%skin.contactList = load([PATH 'skin/skin_events/data.log']);
fid = fopen([PATH 'skin/skin_events/data.log']);
if (TWO_TIME_STAMPS==true)
    threecols = textscan(fid,'%f %f %f %*[^\n]');
    skin.contactListTimes = [threecols{1} threecols{2} threecols{3}];
else
    twocols = textscan(fid,'%f %f %*[^\n]');
    skin.contactListTimes = [twocols{1} twocols{2}];
end
fclose(fid);
skin.taxels_left_arm = load([PATH 'skin/tactile_comp_left_arm/data.log']);
skin.taxels_left_forearm = load([PATH 'skin/tactile_comp_left_forearm/data.log']);
skin.taxels_left_hand = load([PATH 'skin/tactile_comp_left_hand/data.log']);
skin.taxels_right_arm = load([PATH 'skin/tactile_comp_right_arm/data.log']);
skin.taxels_right_forearm = load([PATH 'skin/tactile_comp_right_forearm/data.log']);
skin.taxels_right_hand = load([PATH 'skin/tactile_comp_right_hand/data.log']);
skin.taxels_torso = load([PATH 'skin/tactile_comp_torso/data.log']);
forces_and_torques.left_arm = load([PATH 'forces_and_torques/leftArm_forces/data.log']);
forces_and_torques.left_leg = load([PATH 'forces_and_torques/leftLeg_forces/data.log']);
forces_and_torques.left_foot = load([PATH 'forces_and_torques/leftFoot_forces/data.log']);
forces_and_torques.right_arm = load([PATH 'forces_and_torques/rightArm_forces/data.log']);
forces_and_torques.right_leg = load([PATH 'forces_and_torques/rightLeg_forces/data.log']);
forces_and_torques.right_foot = load([PATH 'forces_and_torques/rightFoot_forces/data.log']);

%% print info
disp('Number of data points (rows) in individual files:');
disp(['Head joints:',num2str(size(joints.head,1))]);
disp(['Left arm joints:',num2str(size(joints.left_arm,1))]);
disp(['Left leg joints:',num2str(size(joints.left_leg,1))]);
disp(['Right arm joints:',num2str(size(joints.right_arm,1))]);
disp(['Right leg joints:',num2str(size(joints.right_leg,1))]);
disp(['Torso joints:',num2str(size(joints.torso,1))]);
disp(['Inertial:',num2str(size(inertial,1))]);
disp(['Left cam images:',num2str(size(images.left,1))]);
disp(['Right cam images:',num2str(size(images.right,1))]);
disp(['Skin Contact List readings:',num2str(size(skin.contactListTimes,1))]);
disp(['Skin taxels left arm readings:',num2str(size(skin.taxels_left_arm,1))]);
disp(['Skin taxels left forearm readings:',num2str(size(skin.taxels_left_forearm,1))]);
disp(['Skin taxels left hand readings:',num2str(size(skin.taxels_left_hand,1))]);
disp(['Skin taxels right arm readings:',num2str(size(skin.taxels_right_arm,1))]);
disp(['Skin taxels right forearm readings:',num2str(size(skin.taxels_right_forearm,1))]);
disp(['Skin taxels right hand readings:',num2str(size(skin.taxels_right_hand,1))]);
disp(['Skin taxels torso readings:',num2str(size(skin.taxels_torso,1))]);
disp(['Left arm forces:',num2str(size(forces_and_torques.left_arm,1))]);
disp(['Left leg forces:',num2str(size(forces_and_torques.left_leg,1))]);
disp(['Left foot forces:',num2str(size(forces_and_torques.left_foot,1))]);
disp(['Right arm forces:',num2str(size(forces_and_torques.right_arm,1))]);
disp(['Right leg forces:',num2str(size(forces_and_torques.right_leg,1))]);
disp(['Right foot forces:',num2str(size(forces_and_torques.right_foot,1))]);


%% create time columns for the runs
% joints
  FIELDNAMES = fieldnames(joints);
  for iField = 1:length(FIELDNAMES)
    dat_orig = [];  % in the orig data, second column is the absolute linux time (either from sender, or receiver --rxTime); 
    % newly, with --txTime --rxTime options (if enabled), second column is sender time,
    % third column is receiver time
    dat_new = []; % with extra first column with the time in seconds from start and second column with time increments between data points
    dat_orig = joints.(FIELDNAMES{iField});  
    nr_rows_dat = size(dat_orig,1);
    four_nan_columns = NaN(nr_rows_dat,4);
    dat_new = [four_nan_columns dat_orig];
    dat_new(1,1)=0; dat_new(1,2)=0;dat_new(1,3)=0; dat_new(1,4)=0;
    for i=2:nr_rows_dat
        dat_new(i,1)=dat_orig(i,2)-dat_orig(1,2);
        dat_new(i,2)=dat_new(i,1)-dat_new(i-1,1); % increment - to see if it is stable
        if (~TWO_TIME_STAMPS) 
            dat_new(i,3)=dat_new(i,1); % simply copy the extra time columns
            dat_new(i,4)=dat_new(i,2);
        else
            dat_new(i,3)=dat_orig(i,3)-dat_orig(1,3); % this would be the receiver time stamp
            dat_new(i,4)=dat_new(i,3)-dat_new(i-1,3); % increment - to see if it is stable
        end
    end
    if (~TWO_TIME_STAMPS)
       dat_new = [dat_new(:,1:6) dat_new(:,6) dat_new(:,7:end)]; % we copy the original abs. time column,
       %such that it has same format like the two time stamp version
    end
    joints.(FIELDNAMES{iField}) = dat_new;  
 
  end
  
  inertial_orig = inertial;  
  nr_rows_inertial = size(inertial_orig,1);
  four_nan_columns = NaN(nr_rows_inertial,4);
  inertial_new = [four_nan_columns inertial_orig];
  inertial_new(1,1)=0; inertial_new(1,2)=0;inertial_new(1,3)=0; inertial_new(1,4)=0;
  for i=2:nr_rows_inertial
        inertial_new(i,1)=inertial_orig(i,2)-inertial_orig(1,2);
        inertial_new(i,2)=inertial_new(i,1)-inertial_new(i-1,1); % increment - to see if it is stable
        if (~TWO_TIME_STAMPS) % simply copy them
            inertial_new(i,3)=inertial_new(i,1);
            inertial_new(i,4)=inertial_new(i,2);
        else
            inertial_new(i,3)=inertial_orig(i,3)-inertial_orig(1,3);
            inertial_new(i,4)=inertial_new(i,3)-inertial_new(i-1,3); % increment - to see if it is stable
        end
  end
  if (~TWO_TIME_STAMPS)
       inertial_new = [inertial_new(:,1:6) inertial_new(:,6) inertial_new(:,7:end)]; % we copy the original abs. time column,
       %such that it has same format like the two time stamp version
    end
  inertial = inertial_new;  
  
  FIELDNAMES2 = fieldnames(images);
  for iField = 1:length(FIELDNAMES2)
    dat_orig = [];  % in the orig data, second column is the absolute linux time;
    dat_new = []; % with extra first column with the time in seconds from start and second column with time increments between data points
    dat_orig = images.(FIELDNAMES2{iField});  
    nr_rows_dat = size(dat_orig,1);
    four_nan_columns = NaN(nr_rows_dat,4);
    dat_new = [four_nan_columns dat_orig];
    dat_new(1,1)=0; dat_new(1,2)=0;dat_new(1,3)=0; dat_new(1,4)=0;
    for i=2:nr_rows_dat
        dat_new(i,1)=dat_orig(i,2)-dat_orig(1,2);
        dat_new(i,2)=dat_new(i,1)-dat_new(i-1,1); % increment - to see if it is stable
        if (~TWO_TIME_STAMPS) % simply copy them
            dat_new(i,3)=dat_new(i,1);
            dat_new(i,4)=dat_new(i,2);
        else
            dat_new(i,3)=dat_orig(i,3)-dat_orig(1,3);
            dat_new(i,4)=dat_new(i,3)-dat_new(i-1,3); % increment - to see if it is stable
        end
    end
    if (~TWO_TIME_STAMPS)
       dat_new = [dat_new(:,1:6) dat_new(:,6) dat_new(:,7:end)]; % we copy the original abs. time column,
       %such that it has same format like the two time stamp version
    end
    images.(FIELDNAMES2{iField}) = dat_new;  
  end
 
  FIELDNAMES3 = fieldnames(skin);
  for iField = 1:length(FIELDNAMES3)
    dat_orig = [];  % in the orig data, second column is the absolute linux time;
    dat_new = []; % with extra first column with the time in seconds from start and second column with time increments between data points
    dat_orig = skin.(FIELDNAMES3{iField});  
    nr_rows_dat = size(dat_orig,1);
    four_nan_columns = NaN(nr_rows_dat,4);
    dat_new = [four_nan_columns dat_orig];
    dat_new(1,1)=0; dat_new(1,2)=0;dat_new(1,3)=0; dat_new(1,4)=0;
   
    for i=2:nr_rows_dat
        dat_new(i,1)=dat_orig(i,2)-dat_orig(1,2);
        dat_new(i,2)=dat_new(i,1)-dat_new(i-1,1); % increment - to see if it is stable
        if (~TWO_TIME_STAMPS) % simply copy them
            dat_new(i,3)=dat_new(i,1);
            dat_new(i,4)=dat_new(i,2);
        else
            dat_new(i,3)=dat_orig(i,3)-dat_orig(1,3);
            dat_new(i,4)=dat_new(i,3)-dat_new(i-1,3); % increment - to see if it is stable
        end
    end
    if (~TWO_TIME_STAMPS)
       if (size(dat_orig,2)>2)
        dat_new = [dat_new(:,1:6) dat_new(:,6) dat_new(:,7:end)]; % we copy the original abs. time column,
       %such that it has same format like the two time stamp version
       else
        dat_new = [dat_new(:,1:6) dat_new(:,6)]; % for the skin contact list, there is no data, just the times  
       end
    end
    skin.(FIELDNAMES3{iField}) = dat_new;  
 
  end
  
  FIELDNAMES4 = fieldnames(forces_and_torques);
  for iField = 1:length(FIELDNAMES4)
    dat_orig = [];  % in the orig data, second column is the absolute linux time;
    dat_new = []; % with extra first column with the time in seconds from start and second column with time increments between data points
    dat_orig = forces_and_torques.(FIELDNAMES4{iField});  
    nr_rows_dat = size(dat_orig,1);
    four_nan_columns = NaN(nr_rows_dat,4);
    dat_new = [four_nan_columns dat_orig];
    dat_new(1,1)=0; dat_new(1,2)=0;dat_new(1,3)=0; dat_new(1,4)=0;
    for i=2:nr_rows_dat
        dat_new(i,1)=dat_orig(i,2)-dat_orig(1,2);
        dat_new(i,2)=dat_new(i,1)-dat_new(i-1,1); % increment - to see if it is stable
        if (~TWO_TIME_STAMPS) % simply copy them
            dat_new(i,3)=dat_new(i,1);
            dat_new(i,4)=dat_new(i,2);
        else
            dat_new(i,3)=dat_orig(i,3)-dat_orig(1,3);
            dat_new(i,4)=dat_new(i,3)-dat_new(i-1,3); % increment - to see if it is stable
        end
    end
    if (~TWO_TIME_STAMPS)
       dat_new = [dat_new(:,1:6) dat_new(:,6) dat_new(:,7:end)]; % we copy the original abs. time column,
       %such that it has same format like the two time stamp version
    end
    forces_and_torques.(FIELDNAMES4{iField}) = dat_new;  
 
  end
  
  %% plot time diagnostics
  
  
   
  %time diagnostics
  if(TWO_TIME_STAMPS)
        
         f20 = figure(20); clf;
         set(f20,'Name','Absolute time');
         
         subplot(3,2,1);
             hold on;
             plot(joints.head(:,TIME_ABS_1_COLUMN),'b+');
             plot(joints.head(:,TIME_ABS_2_COLUMN),'k+');
             hold off;
             legend('joints (sender)','joints (receiver)');
             ylabel('Time (s)');

         subplot(3,2,2);
             hold on;
             plot(inertial(:,TIME_ABS_1_COLUMN),'bo');
             plot(inertial(:,TIME_ABS_2_COLUMN),'ko');
             hold off;
             legend('inertial (sender)','inertial (receiver)');
             
         subplot(3,2,3);
            hold on;
            plot(forces_and_torques.right_arm(:,TIME_ABS_1_COLUMN),'b*');
            plot(forces_and_torques.right_arm(:,TIME_ABS_2_COLUMN),'k*');
            hold off;
            legend('force/torque (sender)', 'force/torque (receiver)');
             ylabel('Time (s)');
             
         subplot(3,2,4);
            hold on;
            plot(skin.contactListTimes(:,TIME_ABS_1_COLUMN),'b^');
            plot(skin.contactListTimes(:,TIME_ABS_2_COLUMN),'k^');
            hold off;
            legend('skin events (sender)','skin events (receiver)');
            
         subplot(3,2,5);
            hold on;
            plot(skin.taxels_right_hand(:,TIME_ABS_1_COLUMN),'bv');
            plot(skin.taxels_right_hand(:,TIME_ABS_2_COLUMN),'kv');
            hold off;
            legend('skin comp (sender)','skin comp (receiver)');
            ylabel('Time (s)')
          
         subplot(3,2,6); 
            hold on;
            plot(images.right(:,TIME_ABS_1_COLUMN),'bs');
            plot(images.right(:,TIME_ABS_2_COLUMN),'ks');
            hold off;
            legend('images (sender)', 'images (receiver)');
                    
            
         f21 = figure(21); clf;
         set(f21,'Name','Time starting from 0');
         
         subplot(3,2,1);
             hold on;
             plot(joints.head(:,TIME_FROM_ZERO_1_COLUMN),'b+');
             plot(joints.head(:,TIME_FROM_ZERO_2_COLUMN),'k+');
             hold off;
             legend('joints (sender)','joints (receiver)');
             ylabel('Time (s)');

         subplot(3,2,2);
             hold on;
             plot(inertial(:,TIME_FROM_ZERO_1_COLUMN),'bo');
             plot(inertial(:,TIME_FROM_ZERO_2_COLUMN),'ko');
             hold off;
             legend('inertial (sender)','inertial (receiver)');
             
         subplot(3,2,3);
            hold on;
            plot(forces_and_torques.right_arm(:,TIME_FROM_ZERO_1_COLUMN),'b*');
            plot(forces_and_torques.right_arm(:,TIME_FROM_ZERO_2_COLUMN),'k*');
            hold off;
            legend('force/torque (sender)', 'force/torque (receiver)');
             ylabel('Time (s)');
             
         subplot(3,2,4);
            hold on;
            plot(skin.contactListTimes(:,TIME_FROM_ZERO_1_COLUMN),'b^');
            plot(skin.contactListTimes(:,TIME_FROM_ZERO_2_COLUMN),'k^');
            hold off;
            legend('skin events (sender)','skin events (receiver)');
            
         subplot(3,2,5);
            hold on;
            plot(skin.taxels_right_hand(:,TIME_FROM_ZERO_1_COLUMN),'bv');
            plot(skin.taxels_right_hand(:,TIME_FROM_ZERO_2_COLUMN),'kv');
            hold off;
            legend('skin comp (sender)','skin comp (receiver)');
            ylabel('Time (s)')
          
         subplot(3,2,6); 
            hold on;
            plot(images.right(:,TIME_FROM_ZERO_1_COLUMN),'bs');
            plot(images.right(:,TIME_FROM_ZERO_2_COLUMN),'ks');
            hold off;
            legend('images (sender)', 'images (receiver)');
           
                             
  end
  
  f22 = figure(22); clf;
  set(f22,'Name','Time increments');
         
         subplot(3,2,1);
             title(' head joints');
             hold on;
             plot(joints.head(2:end,TIME_FROM_ZERO_DELTA_1_COLUMN),'b+');
             if(TWO_TIME_STAMPS) 
                plot(joints.head(2:end,TIME_FROM_ZERO_DELTA_2_COLUMN),'k+');
                legend('joints (sender)','joints (receiver)');
             end
             hold off;
             ylabel('Sampling - delta time (s)');

         subplot(3,2,2);
             hold on;
             plot(inertial(2:end,TIME_FROM_ZERO_DELTA_1_COLUMN),'bo');
             if(TWO_TIME_STAMPS) 
                 plot(inertial(2:end,TIME_FROM_ZERO_DELTA_2_COLUMN),'ko');
                 legend('inertial (sender)','inertial (receiver)');
             end
             hold off;
             
         subplot(3,2,3);
            hold on;
            plot(forces_and_torques.right_arm(2:end,TIME_FROM_ZERO_DELTA_1_COLUMN),'b*');
            if(TWO_TIME_STAMPS) 
                plot(forces_and_torques.right_arm(2:end,TIME_FROM_ZERO_DELTA_2_COLUMN),'k*');
                legend('force/torque (sender)', 'force/torque (receiver)');
            end
            hold off;
            ylabel('Sampling - delta time (s)');
            
         subplot(3,2,4);
            hold on;
            plot(skin.contactListTimes(2:end,TIME_FROM_ZERO_DELTA_1_COLUMN),'b^');
            if(TWO_TIME_STAMPS) 
                plot(skin.contactListTimes(2:end,TIME_FROM_ZERO_DELTA_2_COLUMN),'k^');
                legend('skin events (sender)','skin events (receiver)');
            end
            hold off;
             
         subplot(3,2,5);
            hold on;
            plot(skin.taxels_right_hand(2:end,TIME_FROM_ZERO_DELTA_1_COLUMN),'bv');
            if(TWO_TIME_STAMPS) 
                plot(skin.taxels_right_hand(2:end,TIME_FROM_ZERO_DELTA_2_COLUMN),'kv');
                legend('skin comp (sender)','skin comp (receiver)');
            end
            hold off;
            ylabel('Sampling - delta time (s)');
          
         subplot(3,2,6); 
            hold on;
            plot(images.right(2:end,TIME_FROM_ZERO_DELTA_1_COLUMN),'bs');
            if(TWO_TIME_STAMPS) 
                plot(images.right(2:end,TIME_FROM_ZERO_DELTA_2_COLUMN),'ks');
                legend('images (sender)', 'images (receiver)');
            end
            hold off;
           
                   
  
  %% plot data
  
  f1 = figure(1); clf;
  set(f1,'Name','Head joints');
    subplot(3,3,1);
    %title('Time increments (s)');
        hold on;
        plot(joints.head(2:end,CHOSEN_TIME_COLUMN),joints.head(2:end,CHOSEN_TIME_DELTA_COLUMN));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
                       
    subplot(3,3,2);
        hold on;
         plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,8),'-r');
         plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,9),'--g');
         plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,10),'-.b');
         plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,11),'-c');
         plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,12),'--m');
         plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,13),'-.k');
         legend('Neck pitch','Neck roll','Neck yaw','Eyes tilt','Eyes version','Eyes vergence');
        xlabel('Time (s)');
        ylabel('All head joints (deg)');  
        hold off;
    
    subplot(3,3,4);
        plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,8));
        xlabel('Time (s)');
        ylabel('Neck pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,9));
        xlabel('Time (s)');
        ylabel('Neck roll (deg)');
        
    subplot(3,3,6);
        plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,10));
        xlabel('Time (s)');
        ylabel('Neck yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,11));
        xlabel('Time (s)');
        ylabel('Eyes tilt (deg)');
        
    subplot(3,3,8);
        plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,12));
        xlabel('Time (s)');
        ylabel('Eyes version (deg)');
        
    subplot(3,3,9);
        plot(joints.head(:,CHOSEN_TIME_COLUMN),joints.head(:,13));
        xlabel('Time (s)');
        ylabel('Eyes vergence (deg)');
        
        
  f2 = figure(2); clf;
  set(f2,'Name','Left arm joints');
    subplot(3,3,1);
        plot(joints.left_arm(2:end,CHOSEN_TIME_COLUMN),joints.left_arm(2:end,CHOSEN_TIME_DELTA_COLUMN));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
    subplot(3,3,2);    
        hold on;
           plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,8),'-r');
           plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,9),'--g');
           plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,10),'-.b');
           plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,11),'-y');
           plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,12),'--c');
           plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,13),'-.m');
           plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,14),'-k');
        legend('Shoulder pitch','Shoulder roll','Shoulder yaw','Elbow','Wrist pronos.','Wrist pitch','Wrist yaw');
        xlabel('Time (s)');
        ylabel('All arm joints (deg)'); 
        hold off;
    
    subplot(3,3,3);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,11));
        xlabel('Time (s)');
        ylabel('Elbow (deg)');
        
    subplot(3,3,4);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,8));
        xlabel('Time (s)');
        ylabel('Shoulder pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,9));
        xlabel('Time (s)');
        ylabel('Shoulder roll (deg)');
        
    subplot(3,3,6);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,10));
        xlabel('Time (s)');
        ylabel('Shoulder yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,12));
        xlabel('Time (s)');
        ylabel('Wrist pronosupination (deg)');
        
    subplot(3,3,8);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,13));
        xlabel('Time (s)');
        ylabel('Wrist pitch (deg)');
        
    subplot(3,3,9);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,14));
        xlabel('Time (s)');
        ylabel('Wrist yaw (deg)');
        
        
  f3 = figure(3); clf;
  set(f3,'Name','Left arm fingers');
    subplot(3,3,1);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,15));
        xlabel('Time (s)');
        ylabel('Finger adduction (deg)');
    
    subplot(3,3,2);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,16));
        xlabel('Time (s)');
        ylabel('Thumb opposition (deg)');
         
    subplot(3,3,3);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,17));
        xlabel('Time (s)');
        ylabel('Thumb proximal (deg)');
        
    subplot(3,3,4);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,18));
        xlabel('Time (s)');
        ylabel('Thum distal (deg)');
        
    subplot(3,3,5);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,19));
        xlabel('Time (s)');
        ylabel('Index proximal (deg)');
        
    subplot(3,3,6);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,20));
        xlabel('Time (s)');
        ylabel('Index distal (deg)');
        
    subplot(3,3,7);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,21));
        xlabel('Time (s)');
        ylabel('Middle proximal (deg)');
        
    subplot(3,3,8);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,22));
        xlabel('Time (s)');
        ylabel('Middle distal (deg)');
        
    subplot(3,3,9);
        plot(joints.left_arm(:,CHOSEN_TIME_COLUMN),joints.left_arm(:,23));
        xlabel('Time (s)');
        ylabel('Pinky (deg)');
              
  f4 = figure(4); clf;
  set(f4,'Name','Right arm joints');
    subplot(3,3,1);
        plot(joints.right_arm(2:end,CHOSEN_TIME_COLUMN),joints.right_arm(2:end,CHOSEN_TIME_DELTA_COLUMN));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
     subplot(3,3,2);    
        hold on;
           plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,8),'-r');
           plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,9),'--g');
           plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,10),'-.b');
           plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,11),'-y');
           plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,12),'--c');
           plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,13),'-.m');
           plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,14),'-k');
        legend('Shoulder pitch','Shoulder roll','Shoulder yaw','Elbow','Wrist pronos.','Wrist pitch','Wrist yaw');
        xlabel('Time (s)');
        ylabel('All arm joints (deg)'); 
        hold off;    
        
    subplot(3,3,3);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,11));
        xlabel('Time (s)');
        ylabel('Elbow (deg)');
        
    subplot(3,3,4);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,8));
        xlabel('Time (s)');
        ylabel('Shoulder pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,9));
        xlabel('Time (s)');
        ylabel('Shoulder roll (deg)');
        
    subplot(3,3,6);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,10));
        xlabel('Time (s)');
        ylabel('Shoulder yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,12));
        xlabel('Time (s)');
        ylabel('Wrist pronosupination (deg)');
        
    subplot(3,3,8);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,13));
        xlabel('Time (s)');
        ylabel('Wrist pitch (deg)');
        
    subplot(3,3,9);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,14));
        xlabel('Time (s)');
        ylabel('Wrist yaw (deg)');
        
        
  f5 = figure(5); clf;
  set(f5,'Name','Right arm fingers');
    subplot(3,3,1);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,15));
        xlabel('Time (s)');
        ylabel('Finger adduction (deg)');
    
    subplot(3,3,2);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,16));
        xlabel('Time (s)');
        ylabel('Thumb opposition (deg)');
         
    subplot(3,3,3);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,17));
        xlabel('Time (s)');
        ylabel('Thumb proximal (deg)');
        
    subplot(3,3,4);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,18));
        xlabel('Time (s)');
        ylabel('Thum distal (deg)');
        
    subplot(3,3,5);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,19));
        xlabel('Time (s)');
        ylabel('Index proximal (deg)');
        
    subplot(3,3,6);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,20));
        xlabel('Time (s)');
        ylabel('Index distal (deg)');
        
    subplot(3,3,7);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,21));
        xlabel('Time (s)');
        ylabel('Middle proximal (deg)');
        
    subplot(3,3,8);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,22));
        xlabel('Time (s)');
        ylabel('Middle distal (deg)');
        
    subplot(3,3,9);
        plot(joints.right_arm(:,CHOSEN_TIME_COLUMN),joints.right_arm(:,23));
        xlabel('Time (s)');
        ylabel('Pinky (deg)');
              
  
  f6 = figure(6); clf;
  set(f6,'Name','Torso joints');
    subplot(2,2,1);
    %title('Time increments (s)');
        plot(joints.torso(2:end,CHOSEN_TIME_COLUMN),joints.torso(2:end,CHOSEN_TIME_DELTA_COLUMN));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
    subplot(2,2,2);
        plot(joints.torso(:,CHOSEN_TIME_COLUMN),joints.torso(:,8));
        xlabel('Time (s)');
        ylabel('Torso yaw (deg)');
        
    subplot(2,2,3);
        plot(joints.torso(:,CHOSEN_TIME_COLUMN),joints.torso(:,9));
        xlabel('Time (s)');
        ylabel('Torso roll (deg)');
        
    subplot(2,2,4);
        plot(joints.torso(:,CHOSEN_TIME_COLUMN),joints.torso(:,10));
        xlabel('Time (s)');
        ylabel('Torso pitch (deg)');
                   
                 
   
  f7 = figure(7); clf;
  set(f7,'Name','Left leg joints');
    subplot(3,3,1);
    %title('Time increments (s)');
        plot(joints.left_leg(2:end,CHOSEN_TIME_COLUMN),joints.left_leg(2:end,CHOSEN_TIME_DELTA_COLUMN));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
    subplot(3,3,4);
        plot(joints.left_leg(:,CHOSEN_TIME_COLUMN),joints.left_leg(:,8));
        xlabel('Time (s)');
        ylabel('Hip pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.left_leg(:,CHOSEN_TIME_COLUMN),joints.left_leg(:,9));
        xlabel('Time (s)');
        ylabel('Hip roll (deg)');
        
    subplot(3,3,6);
        plot(joints.left_leg(:,CHOSEN_TIME_COLUMN),joints.left_leg(:,10));
        xlabel('Time (s)');
        ylabel('Hip yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.left_leg(:,CHOSEN_TIME_COLUMN),joints.left_leg(:,11));
        xlabel('Time (s)');
        ylabel('Knee (deg)');
        
    subplot(3,3,8);
        plot(joints.left_leg(:,CHOSEN_TIME_COLUMN),joints.left_leg(:,12));
        xlabel('Time (s)');
        ylabel('Angle pitch (deg)');
        
    subplot(3,3,9);
        plot(joints.left_leg(:,CHOSEN_TIME_COLUMN),joints.left_leg(:,13));
        xlabel('Time (s)');
        ylabel('Angle roll (deg)');
              
        
  f8 = figure(8); clf;
  set(f8,'Name','Right leg joints');
    subplot(3,3,1);
    %title('Time increments (s)');
        plot(joints.right_leg(2:end,CHOSEN_TIME_COLUMN),joints.right_leg(2:end,CHOSEN_TIME_DELTA_COLUMN));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
    subplot(3,3,4);
        plot(joints.right_leg(:,CHOSEN_TIME_COLUMN),joints.right_leg(:,8));
        xlabel('Time (s)');
        ylabel('Hip pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.right_leg(:,CHOSEN_TIME_COLUMN),joints.right_leg(:,9));
        xlabel('Time (s)');
        ylabel('Hip roll (deg)');
        
    subplot(3,3,6);
        plot(joints.right_leg(:,CHOSEN_TIME_COLUMN),joints.right_leg(:,10));
        xlabel('Time (s)');
        ylabel('Hip yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.right_leg(:,CHOSEN_TIME_COLUMN),joints.right_leg(:,11));
        xlabel('Time (s)');
        ylabel('Knee (deg)');
        
    subplot(3,3,8);
        plot(joints.right_leg(:,CHOSEN_TIME_COLUMN),joints.right_leg(:,12));
        xlabel('Time (s)');
        ylabel('Angle pitch (deg)');
        
    subplot(3,3,9);
        plot(joints.right_leg(:,CHOSEN_TIME_COLUMN),joints.right_leg(:,13));
        xlabel('Time (s)');
        ylabel('Angle roll (deg)');
        
  f9 = figure(9); clf;
  set(f9,'Name','Inertial sensors');     
        
     subplot(5,3,1);
      plot(inertial(2:end,CHOSEN_TIME_COLUMN),inertial(2:end,CHOSEN_TIME_DELTA_COLUMN));
      xlabel('Time (s)');
      ylabel('Sampling - Delta t (s)');
    
     subplot(5,3,4);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,8));
        xlabel('Time (s)');
        ylabel('Euler 1  (deg)');
        
     subplot(5,3,5);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,9));
        xlabel('Time (s)');
        ylabel('Euler 2  (deg)');
     
     subplot(5,3,6);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,10));
        xlabel('Time (s)');
        ylabel('Euler  3  (deg)');   
        
     subplot(5,3,7);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,11));
        xlabel('Time (s)');
        ylabel('Lin. acc. 1  (m/s^2)');      
        
     subplot(5,3,8);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,12));
        xlabel('Time (s)');
        ylabel('Lin. acc. 2  (m/s^2)');        
        
     subplot(5,3,9);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,13));
        xlabel('Time (s)');
        ylabel('Lin. acc. 3  (m/s^2)');         
        
     subplot(5,3,10);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,14));
        xlabel('Time (s)');
        ylabel('Ang. vel. 1  (deg/s)');  
        
     subplot(5,3,11);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,15));
        xlabel('Time (s)');
        ylabel('Ang. vel. 2  (deg/s)');     
    
     subplot(5,3,12);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,16));
        xlabel('Time (s)');
        ylabel('Ang. vel. 3  (deg/s)');     
    
     subplot(5,3,13);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,17));
        xlabel('Time (s)');
        ylabel('Magn. 1');  
   
      subplot(5,3,14);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,18));
        xlabel('Time (s)');
        ylabel('Magn. 2');  
        
       subplot(5,3,15);
        plot(inertial(:,CHOSEN_TIME_COLUMN),inertial(:,19));
        xlabel('Time (s)');
        ylabel('Magn. 3');    

  f10 = figure(10); clf;
  set(f10,'Name','Images log');     
        
    subplot(2,1,1);
      plot(images.left(2:end,CHOSEN_TIME_COLUMN),images.left(2:end,CHOSEN_TIME_DELTA_COLUMN));
      xlabel('Time (s)');
      ylabel('Sampling - Time increments (s)');
      title('Images left - timing');
      
    subplot(2,1,2);
      plot(images.right(2:end,CHOSEN_TIME_COLUMN),images.right(2:end,CHOSEN_TIME_DELTA_COLUMN));
      xlabel('Time (s)');
      ylabel('Sampling - Time increments (s)');
      title('Images right - timing');
      
  f11 = figure(11); clf;
  set(f11,'Name','Skin sampling');     
        
    subplot(3,3,1);
      plot(skin.contactListTimes(2:end,CHOSEN_TIME_COLUMN),skin.contactListTimes(2:end,CHOSEN_TIME_DELTA_COLUMN),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - contactList (s)');
      
    subplot(3,3,2);
      plot(skin.taxels_torso(2:end,CHOSEN_TIME_COLUMN),skin.taxels_torso(2:end,CHOSEN_TIME_DELTA_COLUMN),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - torso (s)');      
      
     subplot(3,3,4);
      plot(skin.taxels_left_arm(2:end,CHOSEN_TIME_COLUMN),skin.taxels_left_arm(2:end,CHOSEN_TIME_DELTA_COLUMN),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - left arm (s)');   
      
     subplot(3,3,5);
      plot(skin.taxels_left_forearm(2:end,CHOSEN_TIME_COLUMN),skin.taxels_left_forearm(2:end,CHOSEN_TIME_DELTA_COLUMN),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - left fore arm (s)');
      
      subplot(3,3,6);
      plot(skin.taxels_left_hand(2:end,CHOSEN_TIME_COLUMN),skin.taxels_left_hand(2:end,CHOSEN_TIME_DELTA_COLUMN),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - left hand (s)');    
      
      subplot(3,3,7);
      plot(skin.taxels_right_arm(2:end,CHOSEN_TIME_COLUMN),skin.taxels_right_arm(2:end,CHOSEN_TIME_DELTA_COLUMN),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - right arm (s)');   
      
      subplot(3,3,8);
      plot(skin.taxels_right_forearm(2:end,CHOSEN_TIME_COLUMN),skin.taxels_right_forearm(2:end,CHOSEN_TIME_DELTA_COLUMN),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - right fore arm (s)');
      
      subplot(3,3,9);
      plot(skin.taxels_right_hand(2:end,CHOSEN_TIME_COLUMN),skin.taxels_right_hand(2:end,CHOSEN_TIME_DELTA_COLUMN),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - right hand (s)');    
      
  f12 = figure(12); clf;
  set(f12,'Name','Forces and torques - left arm');
    subplot(3,3,1);
        plot(forces_and_torques.left_arm(2:end,CHOSEN_TIME_COLUMN),forces_and_torques.left_arm(2:end,CHOSEN_TIME_DELTA_COLUMN));
        title('Left arm sampling')
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
        
    subplot(3,3,4);
        plot(forces_and_torques.left_arm(:,CHOSEN_TIME_COLUMN),forces_and_torques.left_arm(:,8));
        xlabel('Time (s)');
        ylabel('F x (N)');
        
    subplot(3,3,5);
        plot(forces_and_torques.left_arm(:,CHOSEN_TIME_COLUMN),forces_and_torques.left_arm(:,9));
        xlabel('Time (s)');
        ylabel('F y (N)');
        
    subplot(3,3,6);
        plot(forces_and_torques.left_arm(:,CHOSEN_TIME_COLUMN),forces_and_torques.left_arm(:,10));
        xlabel('Time (s)');
        ylabel('F z (N)');
        
     subplot(3,3,7);
        plot(forces_and_torques.left_arm(:,CHOSEN_TIME_COLUMN),forces_and_torques.left_arm(:,11));
        xlabel('Time (s)');
        ylabel('Tau x (Nm)');
        
    subplot(3,3,8);
        plot(forces_and_torques.left_arm(:,CHOSEN_TIME_COLUMN),forces_and_torques.left_arm(:,12));
        xlabel('Time (s)');
        ylabel('Tau y (Nm)');
        
    subplot(3,3,9);
        plot(forces_and_torques.left_arm(:,CHOSEN_TIME_COLUMN),forces_and_torques.left_arm(:,13));
        xlabel('Time (s)');
        ylabel('Tau z (Nm)');
    
   
 %% SAVING
 if SAVE_FIGURES
     saveas(f20,'output/abs_time.fig');
     print -f20 -djpeg 'output/abs_time.jpg';
     saveas(f21,'output/time_from_0.fig');
     print -f21 -djpeg 'output/time_from_0.jpg';
     saveas(f22,'output/time_deltas.fig');
     print -f22 -djpeg 'output/time_deltas.jpg';
     saveas(f1,'output/head_joints.fig');
     print -f1 -djpeg 'output/head_joints.jpg';
     saveas(f2,'output/left_arm_joints.fig');
     print -f2 -djpeg 'output/left_arm_joints.jpg';
     saveas(f3,'output/left_arm_fingers.fig');
     print -f3 -djpeg 'output/left_arm_fingers.jpg';
     saveas(f4,'output/right_arm_joints.fig');
     print -f4 -djpeg 'output/right_arm_joints.jpg';
     saveas(f5,'output/right_arm_fingers.fig');
     print -f5 -djpeg 'output/right_arm_fingers.jpg';
     saveas(f6,'output/torso_joints.fig');
     print -f6 -djpeg 'output/torso_joints.jpg';
     saveas(f7,'output/left_leg_joints.fig');
     print -f7 -djpeg 'output/left_leg_joints.jpg';
     saveas(f8,'output/right_leg_joints.fig');
     print -f8 -djpeg 'output/right_leg_joints.jpg';
     saveas(f9,'output/inertial_sensors.fig');
     print -f9 -djpeg 'output/inertial_sensors.jpg';
     saveas(f10,'output/images_timing.fig');
     print -f10 -djpeg 'output/images_timing.jpg';
     saveas(f11,'output/skin_timing.fig');
     print -f11 -djpeg 'output/skin_timing.jpg';
     saveas(f12,'output/forces_and_torques.fig');
     print -f12 -djpeg 'output/forces_and_torques.jpg';
          
 end
   