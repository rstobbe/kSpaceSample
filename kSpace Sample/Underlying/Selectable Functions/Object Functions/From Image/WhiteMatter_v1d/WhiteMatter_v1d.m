%===========================================
% (v1d)
%      - Object defined FoV
%===========================================

function [SCRPTipt,OB,err] = GrayMatter_v1d(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Tests
%---------------------------------------------
CallingLabel = OBipt.Struct.labelstr;
if not(isfield(OBipt,[CallingLabel,'_Data'])) || not(isfield(OBipt.([CallingLabel,'_Data']),'Object_File_Data'))
    if isfield(OBipt.('Object_File').Struct,'selectedfile')
        file = OBipt.('Object_File').Struct.selectedfile;
        if not(exist(file,'file'))
            err.flag = 1;
            err.msg = '(Re) Load Object_File';
            ErrDisp(err);
            return
        else
            load(file);
            saveData.path = file;
            OBipt.([CallingLabel,'_Data']).('Object_File_Data') = saveData;
        end
    else
        err.flag = 1;
        err.msg = '(Re) Load Object_File';
        ErrDisp(err);
        return
    end
end

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB = struct();
OB.loc = OBipt.([CallingLabel,'_Data']).('Object_File_Data').loc;

Status2('done','',2);
Status2('done','',3);

