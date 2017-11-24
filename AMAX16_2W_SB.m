% This script sets parameter values for the following device:
% Maxon A-Max 16mm Graphite Brushes, 2W
% Program 110064
% Mechanically commutating DC motor
% Sleeve Bearings (for mechanical data)

MotorParam = ...
...             % Nominal Values
[9              % NomV          (V)
 11500          % NoLoadSpd     (rpm)
 54.6           % NoLoadCurr    (mA)
 5510           % NomSpd        (rpm)
 2.36           % NomTorque     (mNm)
 0.394          % NomCurr       (A)
 4.84           % StallTorque   (mNm)
 0.704          % StallCurr     (A)
 52             % MaxEff        (%)
...
...             % Characteristics
 12.8           % TermR         (Ohms)
 0.467          % TermL         (mH)
 6.88           % TorqueConst   (mNm/A)
 1390           % SpdConst      (rpm/V)
 2580           % SpdTorqueGrad (rpm/mNm)
 23.2           % MechTimeConst (ms)
 0.859          % RotJ          (gcm^2)
...
...             % Thermal Data
 29.8           % ThermRhous    (K/W)
 5.5            % ThermRwind    (K/W)
 3.55           % ThermTCwind   (s)
 165            % ThermTCmot    (s)
 57.5           % AmbTemp       (degC)
 125            % MaxTemp       (degC)
...
...             % Mechanical Data
 11900          % MaxSpd        (rpm)
 0.1            % AxialPlay     (mm)
 0.012          % RadPlay       (mm)
 0.8            % MaxAxLd       (N)
 35             % MaxF          (N)
 1.4            % MaxRadLd      (N)
...
...             % Other Specifications
 1              % NoPolePair    (pure)
 7              % NoCommSeg     (pure)
 21             % Weight        (g)
...
...             % Physical Dimensions
 16             % OuterDiam     (mm)
 25.4];         % Length        (mm)
