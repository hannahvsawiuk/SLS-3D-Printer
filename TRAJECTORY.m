% This script sets the trajectory

%%%%%%%%%%%%%%%%%%%%%%
% Desired Trajectory %
%%%%%%%%%%%%%%%%%%%%%%
% xy coordinates of circle moving left to right
num  = 20;                                 % number of cirle segments
r    = 100;
x    = ceil(-num/2:.5:num/2-.5);
x    = x / max(x) * r;                     % scale to radius size
y    = sqrt(r^2 - x.^2);                   % pythag theorem
y    = y .* (mod(1:length(y),2) * 2 - 1);  % negate every second element
z    = ones(size(y));                      % part height

% Robot XY Trajectory for cross-hatch pattern
Xd = [0 x y x y];
Yd = [0 y x y x];
Zd = [0 z*0 z*5 z*10 z*15];

% Sample Time for Set-Point Time Vector
SampleTime = TotalTime / (length(Xd)-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Values you should over-write in Control.m %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% =====================
% Set-Point Time Vector
% =====================
Time       = 0:SampleTime:TotalTime;       % DO NOT CHANGE TotalTime
