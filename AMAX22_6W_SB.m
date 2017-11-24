% This script sets parameter values for the following device:
% Maxon A-Max 22mm Graphite Brushes, 6W
% Program 110147
% Mechanically commutating DC motor
% Sleeve Bearings (for mechanical data)

MotorParam = ...
...             % Nominal Values
[12             % NomV          (V)
 10200          % NoLoadSpd     (rpm)
 45.8           % NoLoadCurr    (mA)
 7060           % NomSpd        (rpm)
 6.96           % NomTorque     (mNm)
 0.681          % NomCurr       (A)
 23.7           % StallTorque   (mNm)
 2.17           % StallCurr     (A)
 72             % MaxEff        (%)
...
...             % Characteristics
 5.53           % TermR         (Ohms)
 0.363          % TermL         (mH)
 10.9           % TorqueConst   (mNm/A)
 875            % SpdConst      (rpm/V)
 444            % SpdTorqueGrad (rpm/mNm)
 19.9           % MechTimeConst (ms)
 4.29           % RotJ          (gcm^2)
...
...             % Thermal Data
 20             % ThermRhous    (K/W)
 6.0            % ThermRwind    (K/W)
 10.2           % ThermTCwind   (s)
 314            % ThermTCmot    (s)
 27.5           % AmbTemp       (degC)
 125            % MaxTemp       (degC)
...
...             % Mechanical Data
 9800           % MaxSpd        (rpm)
 0.1            % AxialPlay     (mm)
 0.012          % RadPlay       (mm)
 1              % MaxAxLd       (N)
 80             % MaxF          (N)
 2.8            % MaxRadLd      (N)
...
...             % Other Specifications
 1              % NoPolePair    (pure)
 9              % NoCommSeg     (pure)
 54             % Weight        (g)
...
...             % Physical Dimensions
 22             % OuterDiam     (mm)
 32];           % Length        (mm)
