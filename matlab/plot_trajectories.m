clear; close all; 
OT = csvread('OT.csv');  %% Object tracking pose
CT = csvread('CameraTime.csv'); % image timestamp
ST = csvread('SVO.csv');  %% SVO pose
GT = csvread('GT.csv'); %% Mocap world pose


OT(:,3) = OT(:,3)/(10^9);
CT(:,3) = CT(:,3)/(10^9);
ST(:,3) = ST(:,3)/(10^9);
GT(:,3) = GT(:,3)/(10^9);

figure; hold on; axis equal;
for i =1:1000 %size(ST,1)
    [val ind] = min(abs(ST(i,3) - CT(:,3)));
    indices(i) = ind;
    [r,p,y]=quat2angle(ST(i,7:10),'XYZ');
    pose_ST{i} = rpy2tr(y,p,r,'zyx');
    pose_ST{i}(1:3,4) = ST(i,4:6);
    scatter3(ST(i,4),ST(i,5),ST(i,6),10)
    pause(0.05)
end

xlabel('x');
ylabel('y');
zlabel('z');

figure; hold on; axis equal;
for i =1:1000 %size(ST,1)
    [val ind] = min(abs(CT(i,3) - GT(:,3)));
    indices1(i) = ind;
    [r,p,y]=quat2angle(GT(ind,7:10),'XYZ');
    pose_GT{i} = rpy2tr(-r,-y,p,'zyx');
    pose_GT{i}(1,4) = GT(ind,5);
    pose_GT{i}(2,4) = -GT(ind,6);
    pose_GT{i}(3,4) = -GT(ind,4);
    scatter3(pose_GT{i}(1,4),pose_GT{i}(2,4),pose_GT{i}(3,4),10)
    pause(0.05)
end




xlabel('x');
ylabel('y');
zlabel('z');