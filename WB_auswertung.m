%% Input needed later, modify by user!
numberOfLanes = 10;
t = 45;

%% Script needs 8bit png file
imgType = '*.png';

% Modify path or use relative path
path1 = '.\pAkt\';
path2 = '.\Akt\';

img_pAkt = dir([path1 imgType]);
img_Akt  = dir([path2 imgType]);

for i=1:length(img_pAkt)
    [pAkt{i}, map_pAkt{i}] = imread([path1 img_pAkt(i).name]);
    [Akt{i}, map_Akt{i}]  = imread([path2 img_Akt(i).name]);
end

for k=1:length(img_pAkt)
    laneValue_pAkt = calculateValues(pAkt{k},numberOfLanes,t);
end

for k=1:length(img_Akt)
    laneValue_Akt = calculateValues(Akt{k},numberOfLanes,t);
end

