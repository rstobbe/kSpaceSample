%===========================================
% 
%===========================================

function [OB,err] = WhiteMatter_v1d_Func(OB,INPUT)

Status2('busy','Return Numerical Object',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Object Size
%---------------------------------------------
Out = load(OB.loc);
M = size(Out.Object.Mat);
M = M(3);

%---------------------------------------------
% Max Object Displacement from Centre
%---------------------------------------------
% Add

%---------------------------------------------
% Return
%---------------------------------------------
OB.ObMatSz = M;
OB.ObFoV = Out.Object.FoV * Out.Object.SS;
OB.VoxelWid = OB.ObFoV/M;
OB.VoxelVol = (OB.ObFoV/M)^3;
OB.Ob = Out.Object.Mat(:,:,:,3);
OB.name = Out.Object.Name;

Effect.Type = 'BiExpDecay';
Effect.T2s = 14;
Effect.T2f = 2.5;
Effect.TE = 0;
Effect.NormToOne = 'Yes';
OB.EffectAdd{1} = Effect;

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'Name',OB.name,'Output'};
Panel(2,:) = {'ObMatSz',OB.ObMatSz,'Output'};
Panel(3,:) = {'ObFoV (mm)',OB.ObFoV,'Output'};
Panel(4,:) = {'ObVoxelWid (mm)',OB.VoxelWid,'Output'};
Panel(5,:) = {'ObVoxelVox (mm3)',OB.VoxelVol,'Output'};
PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

