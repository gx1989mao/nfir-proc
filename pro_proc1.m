clear;clc;
load('code2_HBR.mat');
sig = code2_HBR;

%  load('code1_HBR.mat')
% sig = code1_HBR;

res = size(sig);
sig_n = res(2);


%%
CUT = zeros(1,24);
for sub=1:24
    for i=sig_n:-1:1
        if sum(sig(:,i,sub))~=0
            cut = i;
            break
        end
    end
    CUT(1,sub) = cut;
end
figure(10);
plot(CUT);hold on;

short_n = min(CUT);

%%
CH = zeros(48,short_n);

fs = 8;
for ch=1:48
    N = 0;
    for sub=1:24
%         cut_sig = sig(ch,1:short_n,sub);
        ori_sig = sig(ch,1:CUT(sub),sub);
        cut_sig = resample(ori_sig,short_n,CUT(sub));
        if  sum(cut_sig)~=0
%             imfs = PlotEMDandFFT(cut_sig,fs);  close;
%             cut_sig= cut_sig-imfs(1,:)-imfs(2,:);
            CH(ch,:) =CH(ch,:) + cut_sig;
            N = N+1;
        end
    end
    disp(ch);
    CH(ch,:) = CH(ch,:)/N;
end
%%
figure(2);
subplot(211);
for ch=1:48
     plot(CH(ch,:)+ch*1e-3);hold on;
end
subplot(212);
tmp = CH - CH(45,:);
tmp = sum(tmp,1)/47;

imfs = PlotEMDandFFT(tmp,fs);  close;
tmp= tmp-imfs(1,:)-imfs(2,:);

plot(tmp);hold on;
ylim([-3e-2,3e-2]);
%%
tmp = CH(45,:);
imfs = PlotEMDandFFT(tmp,fs);  
res= tmp-imfs(1,:)-imfs(2,:);
figure;
plot(tmp);hold on;
plot(res);hold on;

%%
Z = zeros(1,48);
for ch=1:48
    Z(1,ch) = std(CH(ch,:));
    
end
figure;
plot(Z);

