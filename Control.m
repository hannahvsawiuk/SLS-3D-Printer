% This script sets the controller parameters for the SLS 3-D Printer

%============================================%
% 			Controller Gains                 %
%============================================%
GHPID0 = zpk(tf([1.282e08],[1 15279.1702128 748862.340426 0]));
GHPID1 = zpk(tf([1.4146e10],[1 40450.60 2044240 0]));
% PID Values
% ----------------------
% No more than 3 significant figures per gain value.

% PID0 
Kp0 = 0.108;
Ki0 = 9.115;
Kd0 = 0.0987;

% PID1 
Kp1 = 0.126;
Ki1 = 0;
Kd1 = 0.002;

% PID Vectors
PID0 = [Kp0 Ki0 Kd0];
PID1 = [Kp1 Ki1 Kd1];

% The commented code below was used to tune the values using scale factors
% before numeric values of up to 3 significan figures were used 

% Q0 scale factors
% SF0 = 1.05;
% SFP0 = 1;
% SFP0 = 0.73;
% SFI0 = 1.25;
% SFD0 = 1.3;

% Q0 constants
% Ku0 = SF0*7.17*10^(-2); K = 7.17*10^(-2) is the gain corresponding to the breakpoint

% (s^2 + 1.955s + 96.77) removed by PID
% Kp0 = SFP0*(1.95)*(Ku0); 
% Ki0 = SFI0*(96.77)*(Ku0);
% Kd0 = SFD0*(Ku0);

% Q1 scale factors
% SFP1 = 1.5;
% SFD1 = 1;

% Q1 constants
% Ku1 = SF1*1.83*10^(-3); % K = 1.83*10^-3 is the gain corresponding to the breakpoint
% Kp1 = SFP1*(49.17)*(Ku1); %  (s+49.17) is the pole removed with PID
% Ki1 = (0)*(Ku1); % The pole at zero makes Q1 a PD controller
% Kd1 = SFD1*(Ku1);
% 
% PID0 = [Kp0 Ki0 Kd0];
% PID1 = [Kp1 Ki1 Kd1];

% N = 100; % filter coefficient
% 
% Tuning with step response
% 
% PID transfer function for Q0
% pidt0 = zpk(Kp0 + Ki0*INT + Kd0*(N/(1+N*INT))); 
% 
% The open loop gain of the Q0 open loop gain with the PID block
% tune0_ol = pidt0*T0_4;
% tune0 = feedback(tune0_ol,1); % closed loop gain
% step(tune0);
% disp(stepinfo(tune0));
% 
% PID transfer function for Q
% pidt1 = zpk(Kp1 + Kd1*(N/(1+N*INT)));
% The open loop gain of the Q0 open loop gain with the PID block
% tune1_ol = pidt1*T1_3;
% tune1 = feedback(tune1_ol,1); % closed loop gain
% step(tune1);
% disp(stepinfo(tune0));

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
