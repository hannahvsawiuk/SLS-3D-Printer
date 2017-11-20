%============================================%
% 				Choose Motors                %
%============================================%

% Motor Unit Conversions
% ----------------------
 AMAX22_5W_SB;                % Default Maxon motor
 Q0 = MotorParam;
 Q1 = MotorParam;

%============================================%
% 				Motor Parameters             %
%============================================%

% Q(n) refers to element at index=n of MotorParam. 
% Parameters found in the AMAX22_5W_SB motor file, and the corresponding indices to the parameters are found in CONSTANTS.m

% Q0
NomI0   = Q0(NomCurr);             % Max average current
StallI0 = Q0(StallCurr);           % Max peak current
NomQ0   = Q0(NomV);                % Nominal voltage 

% Q1
NomI1   = Q1(NomCurr);      	   % Max average current
StallI1 = Q1(StallCurr);           % Max peak current
NomQ1   = Q1(NomV);                % Nominal voltage 

%============================================%
% 			 AmpDynLifier Dynamics              %
%============================================%
% Compute transfer function of AmpDynLifier. R,L,C values are defined in CONSTANTS.m
AmpDynR1 		= R1*10^6;		      % Mohm->ohm
AmpDynC 		= C/10^6;			  % uF->F
AmpDynL 		= L/10^3;			  % mH->H	
% The AmpDynLifier dynamics will be the same for both the motors since they use the same AmpDynLifier circuitry

% Q0
Amp0n   = [AmpDynC*AmpDynR1*R2-AmpDynL];                     % Numerator (C*R1*R2 - L)
Amp0d   = [AmpDynL*AmpDynC*AmpDynR1 AmpDynC*AmpDynR1*R2]           % Denominator ((L*C*R1)s + (C*R1*R2))
AmpSat0 = NomQ0;					                % Set such that the maximum motor voltage is not exceeded (Nominal Voltage) 
% Q1
Amp1n   = [AmpDynC*AmpDynR1*R2-AmpDynL];                     % Numerator (C*R1*R2 - L)
Amp1d   = [AmpDynL*AmpDynC*AmpDynR1 AmpDynC*AmpDynR1*R2]           % Denominator ((L*C*R1)s + (C*R1*R2))
AmpSat1 = NomQ1;					                % Set such that the maximum motor voltage is not exceeded (Nominal Voltage)

%============================================%
% 			 System Parameters               %
%============================================%
% Some values that will be used in the calculations of the mechanical dynamics

% Mass of system (motors and ring)
% --------------------------------------------
% The values for the motors are given, so just the mass of the ring needs to be calculated.
% Mass = volume*density
Rin 	     = LinkR1/10^3;   			        % Inner radius of wrist frame, mm->m
Rout         = LinkR2/10^3;   			        % Outer radius of wrist frame, mm->m
Depth        = LinkD/10^3;	     		        % Depth of wrist frame, mm->m
RCenter      = LinkOff/10^3;                    % Distance from the motor face to the center, mm->m
LengthQ0     = Q0(Length)/10^3;                 % Length of motor Q0, mm->m
LengthQ1     = Q1(Length)/10^3;                 % Length of motor Q1, mm->m
Ringvol      = pi*(Rout^2-Rin^2)*Depth;         % Volume of the ring
RingDensity  = RhoAl*10^3;				        % Density of 6061 Al, g/cm^3->kg/m^3: g/cm^3*(1kg/1000g)*(100^3cm^3/1m^3)=kg/m^3*10^3      
MassRing 	 = Ringvol*RingDensity;             % Mass of ring = volume * density
MassQ0       = Q0(Weight)/10^3;                 % Mass of motor Q0, g->kg
MassQ1       = Q1(Weight)/10^3;                 % Mass of motor Q1, g->kg
TotalMass    = 2*MassQ0 + 2*MassQ1 + MassRing;  % Total mass, assuming that the counter weights are the same weight as the motors
% --------------------------------------------

%============================================%
% 		Q0 - Rotation about y-axis           %
%============================================%

% Electrical Motor Dynamics
% --------------------------------------------
% The armature admittance is the electrical component of motor response.
% The motors eletrical characteristics can be modeled with an armature circuit, 
% where the terminal impedance is represented as a resistor and inductor in series.
% Z = sLa + Ra -> Y=1/(sLa + Ra)
Ra0 	= Q0(TermR);		 % Terminal (armature) resistance 
La0 	= Q0(TermL)/10^3;	 % Terminal (armature) inductance, mH->H
Elec0n  = 1;         		 % Numerator (s)
Elec0d  = [La0 Ra0];	     % Denominator (sL + R)
% --------------------------------------------

% Torque Const & Back EMF
% --------------------------------------------
TConst0  = Q0(TorqueK)/10^3; 		    % Torque constant, mNm/A->Nm/A
BackEMF0 = 1/(Q0(SpdK)*RadPSecPerRPM);  % SpdK is the speed constant in rpm/v, convert to Vs/rad: rpm/V*RadPSecPerRPM = Volt*seconds/rad
% --------------------------------------------

% --------------------------------------------%
% 		Mechanical Motor Dynamics             %
% --------------------------------------------%
% The transfer function of the motor is s/(Js^2 + Bs + K)
% where J is the inertia, B is the damping coefficent, and K is the dynamic friction
% J units: Nms^2/rad
% B units: Nms/rad
% K units: Nm/rad

% J: Moment of Inertia
% --------------------------------------------
% The total moment of inertia associated with motor Q0 is J0 = J0Ring + J0Internal + J0MotorQ1
% J0Ring is the moment of inertia of the ring, J0Internal is the moment of inertia of motor Q0,
% and J0MotorQ1 is the moment of inertia of motor Q1 with respect to motor Q0

% J0Internal: rotational inertia of Q0, which is a given parameter.
J0Internal = Q0(RotJ)/10^7;    % Internal Motor Inertia, gcm^2->kgm^2: gcm^2*(1kg/1000 g)*(1m^2/100^2cm^2)=kgm^2/10^7

% J0Ring: the moment of inertia (about y axis) for a hollow cylinder about the y-axis is given by:
Din    = 2*Rin;      				                        % Inner diameter of wrist frame
Dout   = 2*Rout; 	  				                        % Outer radius of wrist frame
J0Ring = (1/4)*MassRing*((Din^2+Dout^2)/4 + (Depth^2)/3);   % Inertia of Ring, Moment of Inertia Calculation for  a Hollow Ring

% J0MotorQ1: the moment of inertia of motor Q1 (about y axis) with respect to motor Q0
% The inertia will be calculated for two cylinders separately. One cylinder will extend from the end of the motor Q1 to the centre
% of the ring (Cylinder 1). The other cylinder will extend from the start of motor Q1 to the centre of the ring. The substraction 
% of these inertias will give the inertia of a the motor Q1 without the counterweight. By assuming that the counterweight has the 
% same mass as motor Q1, this result can be multiplied by 2 to get the total inertia of the motor Q1 system about the y axis.
M10 = MassQ1 + (RCenter/LengthQ1)*MassQ1;                 % Mass of Cylinder 1 (calculated assuming uniform density in motor Q1)
M20 = (RCenter/LengthQ1)*MassQ1                           % Mass of Cylinder 2 (calculated assuming uniform density in motor Q1)
% Inertia about y axis with respect to the end of a cylinder
% Iend = mL^2/3
J10 = M10*(LengthQ1 + RCenter)^2/3;                       % Inertia of Cylinder 1 about the y-axis
J20 = M20*(RCenter)^2/3;                                  % Inertia of Cylinder 2 about the y-axis
J0MotorQ1 = (J10 - J20) * 2;                                   % Total inertia of motor Q1 system about the y axis

% J0
% The mass of the parts in which the ring and the motor Q1 system overlap will be accounted for
% twice, but this is negligible
J0 = J0Ring + J0Internal + J0MotorQ1;			% units: Nms^2/rad
% --------------------------------------------

% B: Damping Coefficient
% --------------------------------------------
STGrad0 = Q0(SpdTorqueGrad)*10^3*RadPSecPerRPM; % SpdTorqueGrad: rpm/mNm->rpm/Nm->rad/Nms = STGrad 
B0  = 1/STGrad0;		   				        % units: Nms/rad
% --------------------------------------------

% K: Dynamic friction constant
% --------------------------------------------
K0 = (SpringK/10^3)/(2*pi);   					% Spring constant, mNm/rev->Nm/rad
% --------------------------------------------

% Mechanical Dynamics Vectors
% --------------------------------------------
Mech0n  = [1 0];               % Numerator (s)
Mech0d  = [J0 B0 K0];          % Denominator (Js^2 + Bs + K)
JntSat0 =  2*pi;               % Motor 0 does not have an angle limit so 2pi is used 
% --------------------------------------------

% Sensor Dynamics
% --------------------------------------------
Sens0    =  SensV/(SensAng*RadPerDeg); % SensAng is in deg so convert to rad
SensSat0 =  SensV;
% --------------------------------------------

% Static Friction
% --------------------------------------------
% Fs = us*Ns where us is the coefficient of static friction and Ns is the normal force.
% Since motor Q0 controls the ring, the weight associated with the friction (Ns, the normal force) 
% will be the sum of the weights of the motors and the ring.
% Weight = Weight of Q0 + Weight of Q1 + Weight of ring -> Ns = Weight = Mass*g
% The total mass was calculated at the beginning of the file
TotalWeight  = TotalMass*G; 			% G is the gravitational acceleration
StFric0      = 0.5*uSF*TotalWeight/10^6;   % Fs = us*Ns, uNm->Nm, /2 since the counter weight exerts a normal force of 1/2 of the total weight 
% --------------------------------------------

%============================================%
% 		Q1 - Rotation about x-axis           %
%============================================%

% Electrical Motor Dynamics
% --------------------------------------------
Ra1 	= Q1(TermR);		 % Terminal (armature) resistance 
La1 	= Q0(TermL)/10^3;	 % Terminal (armature) inductance, mH->H
Elec1n  = 1;         		 % Numerator (1)
Elec1d  = [La1 Ra1];	     % Denominator (sL + R)
% ---------------------

% Torque Const & Back EMF
% --------------------------------------------
TConst1  = Q1(TorqueK)/10^3; 					   % Torque constant, mNm/A->Nm/A
BackEMF1 = 1/(Q1(SpdK)*RadPSecPerRPM); 		   	   % SpdK is the speed constant in rpm/v, convert to Vs/rad: rpm/V*RadPSecPerRPM = Volt*seconds/rad
% --------------------------------------------

% Mechanical Motor Dynamics
% --------------------------------------------

% J: Moment of Inertia
% --------------------------------------------
% The total moment of inertia associated with motor Q1 is J1 = J1Internal
% J1Internal is given by just the rotational inertia of Q1, which is a given parameter
J1Internal = Q1(RotJ)/10^7;    % gcm^2->kgm^2: gcm^2*(1kg/1000 g)*(1m^2/100^2cm^2)=kgm^2/10^7
J1 = J1Internal;			   % units: Nms^2/rad
% --------------------------------------------

% B: Damping Coefficient
% --------------------------------------------
STGrad1 = Q1(SpdTorqueGrad)*10^3*RadPSecPerRPM; % SpdTorqueGrad: rpm/mNm->rpm/Nm->rad/Nms = STGrad 
B1  = 1/STGrad1;		   				    % units: Nms/rad
% --------------------------------------------

% Mechanical Dynamics Vectors
% --------------------------------------------
Mech1n  = [1];              % Numerator (1<)
Mech1d  = [J1 B1];		  % Denominator (Js + Bs)
% Transfer function: 
% Normalized transfer function: 
JntSat1  =  JntLim*RadPerDeg;     % Joint saturation is the angle limit of motor Q1, deg->rad 
% --------------------------------------------

% Sensor Dynamics
% --------------------------------------------
Sens1    =  SensV/(SensAng*RadPerDeg); % SensAng is in deg so convert to rad
SensSat1 =  SensV;
% --------------------------------------------

% Static Friction
% --------------------------------------------
StFric1 = 0;      	           % None associated with motor Q1
% --------------------------------------------

%============================================%
% 		  Q0 Transfer Functions              
%============================================%
A0	=	tf(Amp0n,Amp0d);           % AmpDynLifier
E0	=	tf(Elec0n,Elec0d);         % Electrical Motor Dynamics
M0	=	tf(Mech0n,Mech0d);         % Mechanical Motor Dynamics

%============================================%
% 		  Q1 Transfer Functions              %
%============================================%
A1	=	tf(Amp1n,Amp1d);           % AmpDynLifier
E1	=	tf(Elec1n,Elec1d);         % Electrical Motor Dynamics
M1	=	tf(Mech1n,Mech1d);         % Mechanical Motor DynamicsA
