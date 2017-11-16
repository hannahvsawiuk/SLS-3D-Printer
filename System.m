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

NomI0   = Q0(NomCurr);      	   % Max average current
StallI0 = Q0(StallCurr);           % Max peak current
NomI1   = Q1(NomCurr);      	   % Max average current
StallI1 = Q1(StallCurr);           % Max peak current

%============================================%
% 			 Amplifier Dynamics              %
%============================================%
% Compute transfer function of amplifier. R,L,C values are defined in CONSTANTS.m
R1 		= R1*10^6;		  % Mohm->ohm
C 		= C/10^6;			  % uF->F
L 		= L/10^3;			  % mH->H	
% The amplifier dynamics will be the same for both the motors
% Q0
Amp0n   = [C*R1*R2-L];               % Numerator
Amp0d   = [L*C*R1 C*R1*R2]           % Denominator
AmpSat0 = Q0(NomV);					 % DC gain = nominal voltage 
% Q1
Amp1n   = [C*R1*R2-L];               % Numerator
Amp1d   = [L*C*R1 C*R1*R2]           % Denominator
AmpSat1 = Q1(NomV);					 % DC gain = nominal voltage

%============================================%
% 			 System Parameters               %
%============================================%
% Some values that will be used in the calculations of the mechanical dynamics

% Mass of system (motors and ring)
% --------------------------------------------
% Total Mass = Mass Q0 + Mass Q1 + Mass of aluminum ring
% The values for the motors are given, so just the mass of the ring needs to be calculated.
% Mass = volume*density
Rout 	     = linkR1/10^3;   			% Inner radius of wrist frame, mm->m
Rin          = linkR2/10^3;   			% Outer radius of wrist frame, mm->m
Depth        = linkD/10^3;	     		% Depth of wrist frame, mm->
Ringvol      = pi(Rout^2-Rin^2)*Depth;  % Volume of the ring
RingDensity  = RhoAl*10^3;				% Density of 6061 Al, g/cm^3->kg/m^3: g/cm^3*(1kg/1000g)*(100^3cm^3/1m^3)=kg/m^3*10^3      
Massring 	 = Ringvol*RingDensity;
TotalMass    = Q0(Weight)/10^3 + Q1(Weight)/10^3 + Massring; % Motor weights are gram, g->kg: g=kg/10^3
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
Elec0n  = 1;         		 % Numerator
Elec0d  = [La0 Ra0];	
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
J0Internal = Q0(rotJ)/10^7;    % gcm^2->kgm^2: gcm^2*(1kg/1000 g)*(1m^2/100^2cm^2)=kgm^2/10^7

% J0Ring: the moment of inertia for a hollow cylinder about the y-axis is given by:
Din    = 2*Rin;      				% Inner diameter of wrist frame
Dout   = 2*Rout; 	  				% Outer radius of wrist frame
J0Ring = (1/4)*Massring*((Din^2+Dout^2)/4 + (Depth^2)/3);

% J0MotorQ1: the moment of inertia of motor Q1 with respect to motor Q0
J0MotorQ1 = ;

% J0
J0 = J0Ring + J0Internal + J0MotorQ1;			% units: Nms^2/rad
% --------------------------------------------

% B: Damping Coefficient
% --------------------------------------------
STGrad0 = Q0(SpdTorqueGrad)*(10^3)*RadPSecPerRPM; % SpdTorqueGrad: rpm/mNm->rpm/Nm->rad/Nms = STGrad
B0  = 1/(TorqueGrad);							  % units: Nms/rad
% --------------------------------------------

% K: Dynamic friction constant
% --------------------------------------------
K0 = (SpringK/10^3)/(2*pi);   					% Spring constant, mNm/rev->Nm/rad
% --------------------------------------------

% Mechanical Dynamics Vectors
% --------------------------------------------
Mech0n  = [1 0];               % Numerator
Mech0d  = [J0 B0 K0];          % Denominator
JntSat0 =  Q0(NomV); 
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
StFric0      = uSF*TotalWeight;         % Fs = us*Ns, 
% --------------------------------------------

%============================================%
% 		Q1 - Rotation about x-axis           %
%============================================%

% Electrical Motor Dynamics
% --------------------------------------------
Ra1 	= Q1(TermR);		 % Terminal (armature) resistance 
La1 	= 10(TermL)/10^3;	 % Terminal (armature) inductance, mH->H
Elec1n  = 1;         		 % Numerator
Elec1d  = [La1 Ra1];	
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
% J1Internal is given by the rotational inertia of Q1, which is a given parameter
J1Internal = Q1(rotJ)/10^7;    % gcm^2->kgm^2: gcm^2*(1kg/1000 g)*(1m^2/100^2cm^2)=kgm^2/10^7
J1 = J1Internal;			   % units: Nms^2/rad
% --------------------------------------------

% B: Damping Coefficient
% --------------------------------------------
STGrad1 = Q1(SpdTorqueGrad)*10^3*RadPSecPerRPM; % SpdTorqueGrad: rpm/mNm->rpm/Nm->rad/Nms = STGrad 
B1  = 1/(TorqueGrad);		   				    % units: Nms/rad
% --------------------------------------------

% K: Dynamic Friction Constant
% --------------------------------------------
K1 = (SpringK/10^3)/(2*pi);   % Spring constant, mNm/rev->Nm/rad
% --------------------------------------------

% Mechanical Dynamics Vectors
% --------------------------------------------
Mech1n  = [1 0];              % Numerator
Mech1d  = [J1 B1 K1];		  % Denominator
% Transfer function: 
% Normalized transfer function: 
JntSat1  =  Q1(NomV); % KDC 
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
A0	=	tf(Amp0n,Amp0d);           % Amplifier
E0	=	tf(Elec0n,Elec0d);         % Electrical Motor Dynamics
M0	=	tf(Mech0n,Mech0d);         % Mechanical Motor Dynamics

%============================================%
% 		  Q1 Transfer Functions              %
%============================================%
A1	=	tf(Amp1n,Amp1d);           % Amplifier
E1	=	tf(Elec1n,Elec1d);         % Electrical Motor Dynamics
M1	=	tf(Mech1n,Mech1d);         % Mechanical Motor Dynamics
