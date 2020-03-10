function env = env_extraction_gmt(SIG, parameters)
%%
% Yang Lu
% Jan 2008
%
% SIG is a matrix of the input signals in subbands
% ENV is a matrix of the envelope of the input in subbands
%

%R = parameters.R;
R = 4; %decimation factor, R times shorter
choice = parameters.env_choice;
lp_A = parameters.lp_A;
lp_B = parameters.lp_B;
nChnl = parameters.nChnl;

% for n = 1:nChnl
% %     dSIG(n,:) = decimate(SIG(n,:),R,'fir');
%     dSIG(n,:) = SIG(n,:);
% end

dSIG = SIG;

if strcmp(choice, 'abs')
    ENV = abs(dSIG);
elseif strcmp(choice, 'square')
%     ENV = abs(dSIG.^2);
    ENV = abs(dSIG.^2);
else
    printf('Unkownm envelope detection strategy\n');
    exit;
end

% decimation
for n = 1:nChnl
    env(n,:) = decimate(ENV(n,:),R,'fir'); %lowpass and short resample, which is an envelope extractor
end

% low pass filtering
% env = filter(lp_B, lp_A, env');
% env = env';

return;
n = 10;
subplot(2,1,1);
plot(SIG(n,:));
subplot(2,1,2);
plot(interp(env(n,:),R),'r');



