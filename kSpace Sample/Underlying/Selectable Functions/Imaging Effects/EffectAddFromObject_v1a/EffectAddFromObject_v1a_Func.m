%=========================================================
% 
%=========================================================

function [EFCT,err] = EffectAddFromObject_v1a_Func(EFCT,INPUT)

Status2('busy','Add Imaging Effect',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
if isfield(INPUT,'prepostsamp')
    prepostsamp = INPUT.prepostsamp;
else
    prepostsamp = 'post';
end
if isfield(INPUT,'KSMP')
    KSMP = INPUT.KSMP;
    SampDat = KSMP.SampDat;
end
if isfield(INPUT,'SampDat')
    SampDat = INPUT.SampDat;
end
if isfield(INPUT,'EffectAdd')
    EffectAdd = INPUT.EffectAdd;
end
samp = INPUT.IMP.samp;
PROJimp = INPUT.IMP.PROJimp;
clear INPUT;

%---------------------------------------------
% Do Nothing Before Sampling
%---------------------------------------------
if strcmp(prepostsamp,'pre')
    return
end

%---------------------------------------------
% Add Signal Decay
%---------------------------------------------
if strcmp(prepostsamp,'post')

    if strcmp(EffectAdd.Type,'BiExpDecay')
        T2decay = 0.6*exp(-samp/EffectAdd.T2f) + 0.4*exp(-samp/EffectAdd.T2s);
        if strcmp(EffectAdd.NormToOne,'Yes')
            T2decay = T2decay/T2decay(1);
        end
        [Datmat] = DatArr2Mat(SampDat,PROJimp.nproj,PROJimp.npro);
        T2decaymat = repmat(T2decay,[PROJimp.nproj 1]);
        SampDat = DatMat2Arr(Datmat.*T2decaymat,PROJimp.nproj,PROJimp.npro);
        Panel(1,:) = {'Effect',EffectAdd.Type,'Output'};
        Panel(2,:) = {'T2f',EffectAdd.T2f,'Output'};
        Panel(3,:) = {'T2s',EffectAdd.T2s,'Output'};
        PanelOutput = cell2struct(Panel,{'label','value','type'},2);
    end

    if strcmp(EffectAdd.Type,'MonoExpDecay')
        T2decay = exp(-samp/EffectAdd.T2);
        if strcmp(EffectAdd.NormToOne,'Yes')
            T2decay = T2decay/T2decay(1);
        end
        [Datmat] = DatArr2Mat(SampDat,PROJimp.nproj,PROJimp.npro);
        T2decaymat = repmat(T2decay,[PROJimp.nproj 1]);
        SampDat = DatMat2Arr(Datmat.*T2decaymat,PROJimp.nproj,PROJimp.npro);
        Panel(1,:) = {'Effect',EffectAdd.Type,'Output'};
        Panel(2,:) = {'T2',EffectAdd.T2,'Output'};
        PanelOutput = cell2struct(Panel,{'label','value','type'},2);
    end    
    
end


%---------------------------------------------
% Return
%---------------------------------------------
EFCT.SampDat = SampDat;
EFCT.PanelOutput = PanelOutput;   

Status2('done','',2);
Status2('done','',3);