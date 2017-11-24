% This script sets parameter values for the following device:
% Maxon A-Max 22mm Precious Metal Brushes CLL, 5W
% Program 110121
% Mechanically commutating DC motor
% Sleeve Bearings (for mechanical data)

MotorParam = ...
...             % Nominal Values
[12             % NomV          (V)
 10400          % NoLoadSpd     (rpm)
 16.8           % NoLoadCurr    (mA)
 7770           % NomSpd        (rpm)
 6.24           % NomTorque     (mNm)
 0.586          % NomCurr       (A)
 24.3           % StallTorque   (mNm)
 2.23           % StallCurr     (A)
 84             % MaxEff        (%)
...
...             % Characteristics
 5.39           % TermR         (Ohms)
 0.362          % TermL         (mH)
 10.9           % TorqueConst   (mNm/A)
 875            % SpdConst      (rpm/V)
 432            % SpdTorqueGrad (rpm/mNm)
 19.7           % MechTimeConst (ms)
 4.36           % RotJ          (gcm^2)
...
...             % Thermal Data
 20             % ThermRhous    (K/W)
 6.0            % ThermRwind    (K/W)
 10.2           % ThermTCwind   (s)
 313            % ThermTCmot    (s)
 17.5           % AmbTemp       (degC)
 85             % MaxTemp       (degC)
...
...             % Mechanical Data
16000           % MaxSpd        (rpm)
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
