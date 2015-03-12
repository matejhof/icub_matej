clear; clc;

%% load data
%PATH = '../app/scripts/data_archive/real/20131105_doubleTouchLogAllTest/data/';
PATH = '/mnt/bigdata/icub/matej/skin_stimulations/right_palm/stimulation_by_experimenter_with_fingertip/data/';
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
    twocols = textscan(fid,'%f %f %*[^\n]');
fclose(fid);
skin.contactListTimes = [twocols{1} twocols{2}];
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
    dat_orig = [];  % in the orig data, second column is the absolute linux time;
    dat_new = []; % with extra first column with the time in seconds from start and second column with time increments between data points
    dat_orig = joints.(FIELDNAMES{iField});  
    nr_rows_dat = size(dat_orig,1);
    two_nan_columns = NaN(nr_rows_dat,2);
    dat_new = [two_nan_columns dat_orig];
    dat_new(1,1)=0; dat_new(1,2)=0;
    for i=2:nr_rows_dat
        dat_new(i,1)=dat_orig(i,2)-dat_orig(1,2);
        dat_new(i,2)=dat_new(i,1)-dat_new(i-1,1); % increment - to see if it is stable
    end
    joints.(FIELDNAMES{iField}) = dat_new;  
 
  end
  
  inertial_orig = inertial;  
  nr_rows_inertial = size(inertial_orig,1);
  two_nan_columns = NaN(nr_rows_inertial,2);
  inertial_new = [two_nan_columns inertial_orig];
  inertial_new(1,1)=0; inertial_new(1,2)=0;
  for i=2:nr_rows_inertial
        inertial_new(i,1)=inertial_orig(i,2)-inertial_orig(1,2);
        inertial_new(i,2)=inertial_new(i,1)-inertial_new(i-1,1); % increment - to see if it is stable
  end
  inertial = inertial_new;  
  
  FIELDNAMES2 = fieldnames(images);
  for iField = 1:length(FIELDNAMES2)
    dat_orig = [];  % in the orig data, second column is the absolute linux time;
    dat_new = []; % with extra first column with the time in seconds from start and second column with time increments between data points
    dat_orig = images.(FIELDNAMES2{iField});  
    nr_rows_dat = size(dat_orig,1);
    two_nan_columns = NaN(nr_rows_dat,2);
    dat_new = [two_nan_columns dat_orig];
    dat_new(1,1)=0; dat_new(1,2)=0;
    for i=2:nr_rows_dat
        dat_new(i,1)=dat_orig(i,2)-dat_orig(1,2);
        dat_new(i,2)=dat_new(i,1)-dat_new(i-1,1); % increment - to see if it is stable
    end
    images.(FIELDNAMES2{iField}) = dat_new;  
  end
 
  FIELDNAMES3 = fieldnames(skin);
  for iField = 1:length(FIELDNAMES3)
    dat_orig = [];  % in the orig data, second column is the absolute linux time;
    dat_new = []; % with extra first column with the time in seconds from start and second column with time increments between data points
    dat_orig = skin.(FIELDNAMES3{iField});  
    nr_rows_dat = size(dat_orig,1);
    two_nan_columns = NaN(nr_rows_dat,2);
    dat_new = [two_nan_columns dat_orig];
    dat_new(1,1)=0; dat_new(1,2)=0;
    for i=2:nr_rows_dat
        dat_new(i,1)=dat_orig(i,2)-dat_orig(1,2);
        dat_new(i,2)=dat_new(i,1)-dat_new(i-1,1); % increment - to see if it is stable
    end
    skin.(FIELDNAMES3{iField}) = dat_new;  
 
  end
  
  FIELDNAMES4 = fieldnames(forces_and_torques);
  for iField = 1:length(FIELDNAMES4)
    dat_orig = [];  % in the orig data, second column is the absolute linux time;
    dat_new = []; % with extra first column with the time in seconds from start and second column with time increments between data points
    dat_orig = forces_and_torques.(FIELDNAMES4{iField});  
    nr_rows_dat = size(dat_orig,1);
    two_nan_columns = NaN(nr_rows_dat,2);
    dat_new = [two_nan_columns dat_orig];
    dat_new(1,1)=0; dat_new(1,2)=0;
    for i=2:nr_rows_dat
        dat_new(i,1)=dat_orig(i,2)-dat_orig(1,2);
        dat_new(i,2)=dat_new(i,1)-dat_new(i-1,1); % increment - to see if it is stable
    end
    forces_and_torques.(FIELDNAMES4{iField}) = dat_new;  
 
  end
  
  %% plotting
  f1 = figure(1); clf;
  set(f1,'Name','Head joints');
    subplot(3,3,1);
    %title('Time increments (s)');
        plot(joints.head(2:end,1),joints.head(2:end,2));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
        
    subplot(3,3,2);
        hold on;
         plot(joints.head(:,1),joints.head(:,5),'-r');
         plot(joints.head(:,1),joints.head(:,6),'--g');
         plot(joints.head(:,1),joints.head(:,7),'-.b');
         plot(joints.head(:,1),joints.head(:,8),'-c');
         plot(joints.head(:,1),joints.head(:,9),'--m');
         plot(joints.head(:,1),joints.head(:,10),'-.k');
         legend('Neck pitch','Neck roll','Neck yaw','Eyes tilt','Eyes version','Eyes vergence');
        xlabel('Time (s)');
        ylabel('All head joints (deg)');  
        hold off;
    
    subplot(3,3,4);
        plot(joints.head(:,1),joints.head(:,5));
        xlabel('Time (s)');
        ylabel('Neck pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.head(:,1),joints.head(:,6));
        xlabel('Time (s)');
        ylabel('Neck roll (deg)');
        
    subplot(3,3,6);
        plot(joints.head(:,1),joints.head(:,7));
        xlabel('Time (s)');
        ylabel('Neck yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.head(:,1),joints.head(:,8));
        xlabel('Time (s)');
        ylabel('Eyes tilt (deg)');
        
    subplot(3,3,8);
        plot(joints.head(:,1),joints.head(:,9));
        xlabel('Time (s)');
        ylabel('Eyes version (deg)');
        
    subplot(3,3,9);
        plot(joints.head(:,1),joints.head(:,10));
        xlabel('Time (s)');
        ylabel('Eyes vergence (deg)');
        
  f2 = figure(2); clf;
  set(f2,'Name','Left arm joints');
    subplot(3,3,1);
        plot(joints.left_arm(2:end,1),joints.left_arm(2:end,2));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
    subplot(3,3,2);    
        hold on;
           plot(joints.left_arm(:,1),joints.left_arm(:,5),'-r');
           plot(joints.left_arm(:,1),joints.left_arm(:,6),'--g');
           plot(joints.left_arm(:,1),joints.left_arm(:,7),'-.b');
           plot(joints.left_arm(:,1),joints.left_arm(:,8),'-y');
           plot(joints.left_arm(:,1),joints.left_arm(:,9),'--c');
           plot(joints.left_arm(:,1),joints.left_arm(:,10),'-.m');
           plot(joints.left_arm(:,1),joints.left_arm(:,11),'-k');
        legend('Shoulder pitch','Shoulder roll','Shoulder yaw','Elbow','Wrist pronos.','Wrist pitch','Wrist yaw');
        xlabel('Time (s)');
        ylabel('All arm joints (deg)'); 
        hold off;
    
    subplot(3,3,3);
        plot(joints.left_arm(:,1),joints.left_arm(:,8));
        xlabel('Time (s)');
        ylabel('Elbow (deg)');
        
    subplot(3,3,4);
        plot(joints.left_arm(:,1),joints.left_arm(:,5));
        xlabel('Time (s)');
        ylabel('Shoulder pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.left_arm(:,1),joints.left_arm(:,6));
        xlabel('Time (s)');
        ylabel('Shoulder roll (deg)');
        
    subplot(3,3,6);
        plot(joints.left_arm(:,1),joints.left_arm(:,7));
        xlabel('Time (s)');
        ylabel('Shoulder yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.left_arm(:,1),joints.left_arm(:,9));
        xlabel('Time (s)');
        ylabel('Wrist pronosupination (deg)');
        
    subplot(3,3,8);
        plot(joints.left_arm(:,1),joints.left_arm(:,10));
        xlabel('Time (s)');
        ylabel('Wrist pitch (deg)');
        
    subplot(3,3,9);
        plot(joints.left_arm(:,1),joints.left_arm(:,11));
        xlabel('Time (s)');
        ylabel('Wrist yaw (deg)');
        
        
  f3 = figure(3); clf;
  set(f3,'Name','Left arm fingers');
    subplot(3,3,1);
        plot(joints.left_arm(:,1),joints.left_arm(:,12));
        xlabel('Time (s)');
        ylabel('Finger adduction (deg)');
    
    subplot(3,3,2);
        plot(joints.left_arm(:,1),joints.left_arm(:,13));
        xlabel('Time (s)');
        ylabel('Thumb opposition (deg)');
         
    subplot(3,3,3);
        plot(joints.left_arm(:,1),joints.left_arm(:,14));
        xlabel('Time (s)');
        ylabel('Thumb proximal (deg)');
        
    subplot(3,3,4);
        plot(joints.left_arm(:,1),joints.left_arm(:,15));
        xlabel('Time (s)');
        ylabel('Thum distal (deg)');
        
    subplot(3,3,5);
        plot(joints.left_arm(:,1),joints.left_arm(:,16));
        xlabel('Time (s)');
        ylabel('Index proximal (deg)');
        
    subplot(3,3,6);
        plot(joints.left_arm(:,1),joints.left_arm(:,17));
        xlabel('Time (s)');
        ylabel('Index distal (deg)');
        
    subplot(3,3,7);
        plot(joints.left_arm(:,1),joints.left_arm(:,18));
        xlabel('Time (s)');
        ylabel('Middle proximal (deg)');
        
    subplot(3,3,8);
        plot(joints.left_arm(:,1),joints.left_arm(:,19));
        xlabel('Time (s)');
        ylabel('Middle distal (deg)');
        
    subplot(3,3,9);
        plot(joints.left_arm(:,1),joints.left_arm(:,20));
        xlabel('Time (s)');
        ylabel('Pinky (deg)');
              
  f4 = figure(4); clf;
  set(f4,'Name','Right arm joints');
    subplot(3,3,1);
        plot(joints.right_arm(2:end,1),joints.right_arm(2:end,2));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
     subplot(3,3,2);    
        hold on;
           plot(joints.right_arm(:,1),joints.right_arm(:,5),'-r');
           plot(joints.right_arm(:,1),joints.right_arm(:,6),'--g');
           plot(joints.right_arm(:,1),joints.right_arm(:,7),'-.b');
           plot(joints.right_arm(:,1),joints.right_arm(:,8),'-y');
           plot(joints.right_arm(:,1),joints.right_arm(:,9),'--c');
           plot(joints.right_arm(:,1),joints.right_arm(:,10),'-.m');
           plot(joints.right_arm(:,1),joints.right_arm(:,11),'-k');
        legend('Shoulder pitch','Shoulder roll','Shoulder yaw','Elbow','Wrist pronos.','Wrist pitch','Wrist yaw');
        xlabel('Time (s)');
        ylabel('All arm joints (deg)'); 
        hold off;    
        
    subplot(3,3,3);
        plot(joints.right_arm(:,1),joints.right_arm(:,8));
        xlabel('Time (s)');
        ylabel('Elbow (deg)');
        
    subplot(3,3,4);
        plot(joints.right_arm(:,1),joints.right_arm(:,5));
        xlabel('Time (s)');
        ylabel('Shoulder pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.right_arm(:,1),joints.right_arm(:,6));
        xlabel('Time (s)');
        ylabel('Shoulder roll (deg)');
        
    subplot(3,3,6);
        plot(joints.right_arm(:,1),joints.right_arm(:,7));
        xlabel('Time (s)');
        ylabel('Shoulder yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.right_arm(:,1),joints.right_arm(:,9));
        xlabel('Time (s)');
        ylabel('Wrist pronosupination (deg)');
        
    subplot(3,3,8);
        plot(joints.right_arm(:,1),joints.right_arm(:,10));
        xlabel('Time (s)');
        ylabel('Wrist pitch (deg)');
        
    subplot(3,3,9);
        plot(joints.right_arm(:,1),joints.right_arm(:,11));
        xlabel('Time (s)');
        ylabel('Wrist yaw (deg)');
        
        
  f5 = figure(5); clf;
  set(f5,'Name','Right arm fingers');
    subplot(3,3,1);
        plot(joints.right_arm(:,1),joints.right_arm(:,12));
        xlabel('Time (s)');
        ylabel('Finger adduction (deg)');
    
    subplot(3,3,2);
        plot(joints.right_arm(:,1),joints.right_arm(:,13));
        xlabel('Time (s)');
        ylabel('Thumb opposition (deg)');
         
    subplot(3,3,3);
        plot(joints.right_arm(:,1),joints.right_arm(:,14));
        xlabel('Time (s)');
        ylabel('Thumb proximal (deg)');
        
    subplot(3,3,4);
        plot(joints.right_arm(:,1),joints.right_arm(:,15));
        xlabel('Time (s)');
        ylabel('Thum distal (deg)');
        
    subplot(3,3,5);
        plot(joints.right_arm(:,1),joints.right_arm(:,16));
        xlabel('Time (s)');
        ylabel('Index proximal (deg)');
        
    subplot(3,3,6);
        plot(joints.right_arm(:,1),joints.right_arm(:,17));
        xlabel('Time (s)');
        ylabel('Index distal (deg)');
        
    subplot(3,3,7);
        plot(joints.right_arm(:,1),joints.right_arm(:,18));
        xlabel('Time (s)');
        ylabel('Middle proximal (deg)');
        
    subplot(3,3,8);
        plot(joints.right_arm(:,1),joints.right_arm(:,19));
        xlabel('Time (s)');
        ylabel('Middle distal (deg)');
        
    subplot(3,3,9);
        plot(joints.right_arm(:,1),joints.right_arm(:,20));
        xlabel('Time (s)');
        ylabel('Pinky (deg)');
              
  
  f6 = figure(6); clf;
  set(f6,'Name','Torso joints');
    subplot(2,2,1);
    %title('Time increments (s)');
        plot(joints.torso(2:end,1),joints.torso(2:end,2));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
    subplot(2,2,2);
        plot(joints.torso(:,1),joints.torso(:,5));
        xlabel('Time (s)');
        ylabel('Torso yaw (deg)');
        
    subplot(2,2,3);
        plot(joints.torso(:,1),joints.torso(:,6));
        xlabel('Time (s)');
        ylabel('Torso roll (deg)');
        
    subplot(2,2,4);
        plot(joints.torso(:,1),joints.torso(:,7));
        xlabel('Time (s)');
        ylabel('Torso pitch (deg)');
                   
                 
   
  f7 = figure(7); clf;
  set(f7,'Name','Left leg joints');
    subplot(3,3,1);
    %title('Time increments (s)');
        plot(joints.left_leg(2:end,1),joints.left_leg(2:end,2));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
    subplot(3,3,4);
        plot(joints.left_leg(:,1),joints.left_leg(:,5));
        xlabel('Time (s)');
        ylabel('Hip pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.left_leg(:,1),joints.left_leg(:,6));
        xlabel('Time (s)');
        ylabel('Hip roll (deg)');
        
    subplot(3,3,6);
        plot(joints.left_leg(:,1),joints.left_leg(:,7));
        xlabel('Time (s)');
        ylabel('Hip yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.left_leg(:,1),joints.left_leg(:,8));
        xlabel('Time (s)');
        ylabel('Knee (deg)');
        
    subplot(3,3,8);
        plot(joints.left_leg(:,1),joints.left_leg(:,9));
        xlabel('Time (s)');
        ylabel('Angle pitch (deg)');
        
    subplot(3,3,9);
        plot(joints.left_leg(:,1),joints.left_leg(:,10));
        xlabel('Time (s)');
        ylabel('Angle roll (deg)');
              
        
  f8 = figure(8); clf;
  set(f8,'Name','Right leg joints');
    subplot(3,3,1);
    %title('Time increments (s)');
        plot(joints.right_leg(2:end,1),joints.right_leg(2:end,2));
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
    
    subplot(3,3,4);
        plot(joints.right_leg(:,1),joints.right_leg(:,5));
        xlabel('Time (s)');
        ylabel('Hip pitch (deg)');
        
    subplot(3,3,5);
        plot(joints.right_leg(:,1),joints.right_leg(:,6));
        xlabel('Time (s)');
        ylabel('Hip roll (deg)');
        
    subplot(3,3,6);
        plot(joints.right_leg(:,1),joints.right_leg(:,7));
        xlabel('Time (s)');
        ylabel('Hip yaw (deg)');
        
    subplot(3,3,7);
        plot(joints.right_leg(:,1),joints.right_leg(:,8));
        xlabel('Time (s)');
        ylabel('Knee (deg)');
        
    subplot(3,3,8);
        plot(joints.right_leg(:,1),joints.right_leg(:,9));
        xlabel('Time (s)');
        ylabel('Angle pitch (deg)');
        
    subplot(3,3,9);
        plot(joints.right_leg(:,1),joints.right_leg(:,10));
        xlabel('Time (s)');
        ylabel('Angle roll (deg)');
        
  f9 = figure(9); clf;
  set(f9,'Name','Inertial sensors');     
        
     subplot(5,3,1);
      plot(inertial(2:end,1),inertial(2:end,2));
      xlabel('Time (s)');
      ylabel('Sampling - Time increments (s)');
    
     subplot(5,3,4);
        plot(inertial(:,1),inertial(:,5));
        xlabel('Time (s)');
        ylabel('Euler angle nr.1  (deg)');
        
     subplot(5,3,5);
        plot(inertial(:,1),inertial(:,6));
        xlabel('Time (s)');
        ylabel('Euler angle nr.2  (deg)');
     
     subplot(5,3,6);
        plot(inertial(:,1),inertial(:,7));
        xlabel('Time (s)');
        ylabel('Euler angle nr.3  (deg)');   
        
     subplot(5,3,7);
        plot(inertial(:,1),inertial(:,8));
        xlabel('Time (s)');
        ylabel('Linear acc nr.1  (m/s^2)');      
        
     subplot(5,3,8);
        plot(inertial(:,1),inertial(:,9));
        xlabel('Time (s)');
        ylabel('Linear acc nr.2  (m/s^2)');        
        
     subplot(5,3,9);
        plot(inertial(:,1),inertial(:,10));
        xlabel('Time (s)');
        ylabel('Linear acc nr.3  (m/s^2)');         
        
     subplot(5,3,10);
        plot(inertial(:,1),inertial(:,11));
        xlabel('Time (s)');
        ylabel('Ang. velocity nr.1  (deg/s)');  
        
     subplot(5,3,11);
        plot(inertial(:,1),inertial(:,12));
        xlabel('Time (s)');
        ylabel('Ang. velocity nr.2  (deg/s)');     
    
     subplot(5,3,12);
        plot(inertial(:,1),inertial(:,13));
        xlabel('Time (s)');
        ylabel('Ang. velocity nr.3  (deg/s)');     
    
     subplot(5,3,13);
        plot(inertial(:,1),inertial(:,14));
        xlabel('Time (s)');
        ylabel('Magnetometer nr.1');  
   
      subplot(5,3,14);
        plot(inertial(:,1),inertial(:,15));
        xlabel('Time (s)');
        ylabel('Magnetometer nr.2');  
        
       subplot(5,3,15);
        plot(inertial(:,1),inertial(:,16));
        xlabel('Time (s)');
        ylabel('Magnetometer nr.3  (deg/s)');    

  f10 = figure(10); clf;
  set(f10,'Name','Images log');     
        
    subplot(2,1,1);
      plot(images.left(2:end,1),images.left(2:end,2));
      xlabel('Time (s)');
      ylabel('Sampling - Time increments (s)');
      
    subplot(2,1,2);
      plot(images.right(2:end,1),images.right(2:end,2));
      xlabel('Time (s)');
      ylabel('Sampling - Time increments (s)');
                      
  f11 = figure(11); clf;
  set(f11,'Name','Skin sampling');     
        
    subplot(3,3,1);
      plot(skin.contactListTimes(2:end,1),skin.contactListTimes(2:end,2),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - contactList (s)');
      
    subplot(3,3,2);
      plot(skin.taxels_torso(2:end,1),skin.taxels_torso(2:end,2),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - torso (s)');      
      
     subplot(3,3,4);
      plot(skin.taxels_left_arm(2:end,1),skin.taxels_left_arm(2:end,2),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - left arm (s)');   
      
     subplot(3,3,5);
      plot(skin.taxels_left_forearm(2:end,1),skin.taxels_left_forearm(2:end,2),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - left fore arm (s)');
      
      subplot(3,3,6);
      plot(skin.taxels_left_hand(2:end,1),skin.taxels_left_hand(2:end,2),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - left hand (s)');    
      
      subplot(3,3,7);
      plot(skin.taxels_right_arm(2:end,1),skin.taxels_right_arm(2:end,2),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - right arm (s)');   
      
      subplot(3,3,8);
      plot(skin.taxels_right_forearm(2:end,1),skin.taxels_right_forearm(2:end,2),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - right fore arm (s)');
      
      subplot(3,3,9);
      plot(skin.taxels_right_hand(2:end,1),skin.taxels_right_hand(2:end,2),'bx');
      xlabel('Time (s)');
      ylabel('Time increments - right hand (s)');    
      
  f12 = figure(12); clf;
  set(f12,'Name','Forces and torques - left arm');
    subplot(3,3,1);
        plot(forces_and_torques.left_arm(2:end,1),forces_and_torques.left_arm(2:end,2));
        title('Left arm sampling')
        xlabel('Time (s)');
        ylabel('Sampling - Time increments (s)');
        
    subplot(3,3,4);
        plot(forces_and_torques.left_arm(:,1),forces_and_torques.left_arm(:,5));
        xlabel('Time (s)');
        ylabel('F x (N)');
        
    subplot(3,3,5);
        plot(forces_and_torques.left_arm(:,1),forces_and_torques.left_arm(:,6));
        xlabel('Time (s)');
        ylabel('F y (N)');
        
    subplot(3,3,6);
        plot(forces_and_torques.left_arm(:,1),forces_and_torques.left_arm(:,7));
        xlabel('Time (s)');
        ylabel('F z (N)');
        
     subplot(3,3,7);
        plot(forces_and_torques.left_arm(:,1),forces_and_torques.left_arm(:,8));
        xlabel('Time (s)');
        ylabel('Tau x (Nm)');
        
    subplot(3,3,8);
        plot(forces_and_torques.left_arm(:,1),forces_and_torques.left_arm(:,9));
        xlabel('Time (s)');
        ylabel('Tau y (Nm)');
        
    subplot(3,3,9);
        plot(forces_and_torques.left_arm(:,1),forces_and_torques.left_arm(:,10));
        xlabel('Time (s)');
        ylabel('Tau z (Nm)');
    
   
   