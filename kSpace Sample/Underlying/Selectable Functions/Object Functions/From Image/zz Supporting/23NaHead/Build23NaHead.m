

HeadMask = 'MASK_o20191030_103506MPRAGEs005a1001.nii';
out = load_untouch_nii(HeadMask); 
HeadMask = out.img;

BrainMask = 'native_mask_n_mmni_fjob301552.nii';
out = load_untouch_nii(BrainMask); 
BrainMask = out.img;

BrainMask2 = 'native_crisp_mmni_fjob301552.nii';
out = load_untouch_nii(BrainMask2); 
BrainMask2 = out.img;

Out = load('ROI_Eyes');
Eyes = Out.ROI.roimask;
Eyes = permute(Eyes,[2 1 3]);
Eyes = flip(Eyes,2);

Out = load('ROI_Tubes');
Tubes = Out.ROI.roimask;
Tubes = permute(Tubes,[2 1 3]);
Tubes = flip(Tubes,2);

NaHead = HeadMask|BrainMask;

NaHead = NaHead * 40;
NaHead(BrainMask2 == 1) = 145;

out.img = NaHead;
save_untouch_nii(out,'test.nii');

NaHeadForTesting = zeros(300,300,300);          % make FoV 260...
NaHeadForTesting(47:254,7:294,7:294) = NaHead;

NaHeadForTesting(Eyes == 1) = 145;
NaHeadForTesting(Tubes == 1) = 40;

drop = [(1:-0.01:0) zeros(1,20)];
ind = 1;
for n = 121:-1:1
    NaHeadForTesting(:,:,n) = drop(ind)*NaHeadForTesting(:,:,n);
    ind = ind+1;
end

out.hdr.dime.dim = [3 300 300 300 0 0 0 0];
pixdim = out.hdr.dime.pixdim(3);
out.hdr.dime.pixdim = [1 pixdim pixdim pixdim 1 1 1 1];
out.img = NaHeadForTesting;
save_untouch_nii(out,'test2.nii');

NaHeadObj = zeros(480,480,480);
NaHeadObj(91:390,91:390,91:390) = NaHeadForTesting;
Params.FoV = 260;
Params.SS = 1.6;
Params.Mat = 480;

save('NaHeadFov260SS16','NaHeadObj','Params');
