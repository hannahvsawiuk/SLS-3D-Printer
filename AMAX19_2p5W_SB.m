% This script sets parameter values for the following device:
% Maxon A-Max 19mm Graphite Brushes, 2.5W
% Program 249996
% Mechanically commutating DC motor
% Sleeve Bearings (for mechanical data)

MotorParam = ...
...             % Nominal Values
[12             % NomV          (V)
 9930           % NoLoadSpd     (rpm)
 44.6           % NoLoadCurr    (mA)
 5670           % NomSpd        (rpm)
 3.89           % NomTorque     (mNm)
 0.397          % NomCurr       (A)
 9.47           % StallTorque   (mNm)
 0.867          % StallCurr     (A)
 60             % MaxEff        (%)
...
...             % Characteristics
 13.8           % TermR         (Ohms)
 0.719          % TermL         (mH)
 10.9           % TorqueConst   (mNm/A)
 874            % SpdConst      (rpm/V)
 1110           % SpdTorqueGrad (rpm/mNm)
 24.2           % MechTimeConst (ms)
 2.09           % RotJ          (gcm^2)
...
...             % Thermal Data
 21.3           % ThermRhous    (K/W)
 10.5           % ThermRwind    (K/W)
 11             % ThermTCwind   (s)
 201            % ThermTCmot    (s)
 57.5           % AmbTemp       (degC)
 125            % MaxTemp       (degC)
...
...             % Mechanical Data
 12000          % MaxSpd        (rpm)
 0.1            % AxialPlay     (mm)
 0.025          % RadPlay       (mm)
 3.3            % MaxAxLd       (N)
 45             % MaxF          (N)
 11.9           % MaxRadLd      (N)
...
...             % Other Specifications
 1              % NoPolePair    (pure)
 9              % NoCommSeg     (pure)
 34             % Weight        (g)
...
...             % Physical Dimensions
 19             % OuterDiam     (mm)
 31.5];         % Length        (mm)
