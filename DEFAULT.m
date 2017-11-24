% This script sets default values for the SLS 3-D Printer
% All forward paths are set to 1
% All feedback paths are set to 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Values you should over-write in Control.m %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ================
% CONTROLLER GAINS
% ================
% PID Controller
PID0 = [1 0 0];
PID1 = [1 0 0];

% Controller Feedback Gain
FB0  = 0;
FB1  = 0;

% Assign the Set-Point Trajectory & Time Vector
TRAJECTORY

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Values you should over-write in System.m %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ==========================
% Choose Motors
% ==========================
AMAX22_5W_SB;                % Default Maxon motor
Q0 = MotorParam;
Q1 = MotorParam;

% ==========================
% Motor Parameters
% ==========================
NomI0   = 1;                 % Max average current
StallI0 = 1;                 % Max peak current
NomI1   = 1;                 % Max average current
StallI1 = 1;                 % Max peak current


% ==========================
% Q0 - Rotation about y-axis
% ==========================

% Amplifier Dynamics
Amp0n   = [1];               % Numerator
Amp0d   = [1];               % Denominator
AmpSat0 = Big;

% Electrical Motor Dynamics
Elec0n  = [1];               % Numerator
Elec0d  = [1];               % Denominator

% Torque Const & Back EMF
TConst0  = 1;
BackEMF0 = 0;

% Mechanical Motor Dynamics
Mech0n  = [1];               % Numerator
Mech0d  = [1];               % Denominator
JntSat0 =  Big;

% Sensor Dynamics
Sens0    =  0;
SensSat0 =  Big;

% Static Friction
StFric0 = 0;


% ==========================
% Q1 - Rotation about x-axis
% ==========================

% Amplifier Dynamics
Amp1n   = [1];               % Numerator
Amp1d   = [1];               % Denominator
AmpSat1 = Big;

% Electrical Motor Dynamics
Elec1n = [1];                % Numerator
Elec1d = [1];                % Denominator

% Torque Const & Back EMF
TConst1  = 1;
BackEMF1 = 0;

% Mechanical Motor Dynamics
Mech1n = [1];                % Numerator
Mech1d = [1];                % Denominator
JntSat1 =  Big;

% Sensor Dynamics
Sens1    =  0;
SensSat1 =  Big;

% Static Friction
StFric1 = 0;
