% This script sets the model parameters for the SLS 3-D Printer
%\rash
% Example: Specifying a Dynamics Block
% n = [1 2 3];
% d = [4 5 6];
% Transfer Function = (s^2 + 2s + 3) / (4s^2 + 5s + 6)

% ========================
% PHYSICAL UNIT CONVERSION
% ========================
% Example: if you decide to work in (Kg), all masses must be represented
%          in (Kg) but the spec sheet may provide masses in (g)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Over-write the default values from DEFAULT.m %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ==========================
% Choose Motors
% ==========================

% Motor Unit Conversions
% ----------------------
 AMAX22_5W_SB;                % Default Maxon motor
 Q0 = MotorParam;
 Q1 = MotorParam;

% ==========================
% Motor Parameters
% ==========================
% Maximum Current
%Q(n) refers to element at index=n of MotorParam. Parameters found in the
%AMAX22_5W_SB motor file, and the corresponding indices to the parameters
%are found in CONSTANTS.m
NomI0   = Q0(6)/1000;        % Max average current: originally in mA so /1000 to get A
StallI0 = Q0(8);             % Max peak current
NomI1   = Q1(6)/1000;        % Max average current
StallI1 = Q1(8);             % Max peak current

% =============================
% Q0 : Rotation about y-axis
% =============================
% Amplifier Dynamics
%Compute transfer function of amplifier. R,L,C values are defined in
%CONSTANTS.m
Amp0n   = [1];               % Numerator
Amp0d   = [1];               % Denominator
AmpSat0 = Big;

% Amplifier Dynamics
% ------------------

% Electrical Motor Dynamics
% -------------------------

% Torque Const & Back EMF
% -----------------------

% Mechanical Motor Dynamics
% -------------------------

% Sensor Dynamics
% ---------------

% Static Friction
% ---------------


% =============================
% Q1 : Rotation about x-axis
% =============================

% Amplifier Dynamics
% ------------------

% Electrical Motor Dynamics
% -------------------------

% Torque Const & Back EMF
% -----------------------

% Mechanical Motor Dynamics
% -------------------------

% Sensor Dynamics
% ---------------

% Static Friction
% ---------------


% ==================
% TRANSFER FUNCTIONS
% ==================
% Compute transfer functions from above values and perform system analysis
% You may prefer to put this section in a separate .m file
