% This script sets the controller parameters for the SLS 3-D Printer

%============================================%
% 			Controller Gains                 %
%============================================%

% PID Values
% ----------------------
% No more than 3 significant figures per gain value.

% SF0 = 0.2;
% SF1 = 0.2;
% 
% 
% Ku0 = SF0*89.28596;
% Ku1 = SF1*5.85;
% Kp0 = (1.95)*(Ku0);
% Kp1 = (49.17)*Ku1;
% KKi0 = (96.77)*(Ku0);
% Ki1 = (0)*(Ku1);
% Kd0 = (Ku0);
% Kd1 = (Ku1);
% 
% PID0 = [Kp0 Ki0 Kd0];
% PID1 = [Kp1 Ki0 Kd1];

% PID0 = [0.054788 0.0001067 7.034];
% PID1 = [0.3573 1.6745 0.01486];
SF0 = 0.06;
SF1 = 0.06;

Ku0 = SF0*89.28596;
Ku1 = SF1*5.85;
Kp0 = (1.95)*(Ku0);
Kp1 = (49.17)*(Ku1);
Ki0 = (96.77)*(Ku0);
Ki1 = (0)*(Ku1);
Kd0 = (Ku0);
Kd1 = (Ku1);

%PID0 = [Kp0 Ki1 D1];
%PID1 = [Kp1 I1 D1];

PID0 = [0 0.40786 0];
PID1 = [0.3573 1.6745 0.014846];

% Enter feedback sensor values here.

FB0 = 1/(Sens0);
FB1 = 1/(Sens1);

% Feedback Sensor Values
% ----------------------
% The saturation voltage of the sensors is 5V. 
% The sensor angles will be in the range of +/- 180 degrees -> +/- pi radians.
% In th Jnt Controller, the sensor gain block converts the actual angle in radians
% into a voltage by mulitplying the angle by SensV/(SensAng*RadPerDeg) which is 5 Volts/pi radians
% Since unity gain is desired, the feedback gains will be the inverse of the sensor gains.
FB0 = 1/Sens0; 
FB1 = 1/Sens1;

%============================================%
% 			Set-Point Time Vector            %
%============================================%

% The Time Vector is stored in a variable called "Time".
% It's initial value is equally spaced for all samples and is
% set in TRAJECTORY.M
%
% Redefine this vector here to optimize the build time of the part.
% You can define it analytically or type in the elements manually but
% you must not change the length because it must contain one value for
% each Xd/Yd position pair.
% In the Matlab window, enter "length(Time)" to see how big it is.

% The Time vector must range from 0 to TotalTime

%Time       = 0:SampleTime:TotalTime;       % DO NOT CHANGE TotalTime
