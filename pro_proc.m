clear; clc;

% load('back1_HBO.mat');
 load('code1_HBR.mat')
sig = code1_HBR;

sig_n = 2336;
sub = 2;

cut=sig_n;
for i=sig_n:-1:1
    if sum(sig(:,i,sub))~=0
        cut = i;
        break
    end
end
cut_sig = sig(:,1:cut,sub);


fs = 8;
for ch=1:48
    if sum(cut_sig(ch,:))==0
        continue
    end
    imfs = PlotEMDandFFT(cut_sig(ch,:),fs);  close;
    cut_sig(ch,:) = cut_sig(ch,:)-imfs(1,:)-imfs(2,:);
end

figure(1);
for ch= 1:48
    plot(cut_sig(ch,:)+ch*1e-3); hold on;
end
    

%%
figure(2);
plot(sig(1,:,1));hold on;

%%
figure(3);
Std = zeros(48);
for ch =1:48
    Std(ch) = std(sig(ch,:,sub));
end
plot(Std);hold on;

%%  
figure(4);
Z = zeros(48,24);
CUT = zeros(1,24);
for sub=1:24
    % cut the zeros tail
    for i=sig_n:-1:1
        if sum(sig(:,i,sub))~=0
            cut = i;
            break
        end
    end
    CUT(1,sub) = cut;
    cut_sig = sig(:,1:cut,sub);
    
    for ch =1:48
        Z(ch,sub) = std(cut_sig(ch,:));
        if Z(ch,sub)>0.003
            Z(ch,sub)=0;
        end
    end
end
surface(log( Z));
%%
figure(20);
res = reshape(Z,[1,24*48]);
hist(res,1152);

%%
sig_for_filter = cut_sig(4,:);
figure(5);
plot(sig_for_filter);hold on;

%%
fs = 8;
imfs = PlotEMDandFFT(sig_for_filter,fs);  
%%
sig_after_emd = sig_for_filter-imfs(1,:);
figure(5);
plot(sig_after_emd);hold on;

