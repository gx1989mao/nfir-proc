clear;
clc;

%% load origin data and resize to 256
load('back3_HBR_sorted.mat');
sig = SIGS;

sig1 = zeros(48,256,24);
for sub=1:24
    for ch=1:48
        p = length(sig(ch,:,sub));
        sig1(ch,:,sub) = resample( sig(ch,:,sub) ,256,p);
    end
end

%% normlization 256 data to sig2
sig2 = zeros(48,256,24);
figure;
for sub=1:24
    for ch=1:48
        sig2(ch,:,sub) = sig1(ch,:,sub)/5e-3;
        plot(sig2(ch,:,sub));hold on;
    end
end

save('./back3_HBR_proc.mat','sig2')


%%  plot ch map

load('map.mat');

figure;
surface(Z');
figure;
plot(mean(Z,1));


