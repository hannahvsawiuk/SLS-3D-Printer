% This script sets parameter values for the following device:
% Maxon A-Max 12mm Graphite Brushes, 0.75W
% Program 265376
% Mechanically commutating DC motor
% Sleeve Bearings (for mechanical data)

MotorParam = ...
...             % Nominal Values
[9              % NomV          (V)
 12100          % NoLoadSpd     (rpm)
 5.87           % NoLoadCurr    (mA)
 4470           % NomSpd        (rpm)
 0.941          % NomTorque     (mNm)
 0.141          % NomCurr       (A)
 1.52           % StallTorque   (mNm)
 0.22           % StallCurr     (A)
 70             % MaxEff        (%)
...
...             % Characteristics
 40.9           % TermR         (Ohms)
 1.01           % TermL         (mH)
 6.92           % TorqueConst   (mNm/A)
 1380           % SpdConst      (rpm/V)
 8170           % SpdTorqueGrad (rpm/mNm)
 20.4           % MechTimeConst (ms)
 0.238          % RotJ          (gcm^2)
...
...             % Thermal Data
 44.5           % ThermRhous    (K/W)
 15             % ThermRwind    (K/W)
 5.03           % ThermTCwind   (s)
 245            % ThermTCmot    (s)
 47.5           % AmbTemp       (degC)
 85             % MaxTemp       (degC)
...
...             % Mechanical Data
 19000          % MaxSpd        (rpm)
 0.1            % AxialPlay     (mm)
 0.012          % RadPlay       (mm)
 0.15           % MaxAxLd       (N)
 15             % MaxF          (N)
 0.4            % MaxRadLd      (N)
...
...             % Other Specifications
 1              % NoPolePair    (pure)
 7              % NoCommSeg     (pure)
 11             % Weight        (g)
...
...             % Physical Dimensions
 12             % OuterDiam     (mm)
 21.2];         % Length        (mm)
