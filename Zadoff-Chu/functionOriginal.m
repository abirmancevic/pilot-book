function S = functionOriginal(N_zc, qOrig)

%% Description of the Input parameters
% N_zc:   1 x 1; a desired length of original sequences
% qOrig:  (N_zc - 1) x 1 or 1 x (N_zc  - 1); desired root indices
%
%   Prerequisites:
% N_zc >= 3
% Note(s):
% ~ Even numbers are not considered for N_zc.

%% Description of the Output parameters
% S:   N_zc x length(qOrig); created original sequences

%% Standalone usage (uncomment lines 17 - 20 and 36 - 52)
%   Part I
%      arguments
%  N_zc (1,1) {mustBeInteger,mustBeGreaterThanOrEqual(N_zc,3), mustBeOdd}
%  qOrig (1,:) {mustBeInteger,mustBeInRange(qOrig,1,N_zc,"exclude-upper"),mustBeUnique}
%      end

%% Generating the original base sequence, s_q of the length N_zc
s_q = zeros(N_zc, 1);
S = zeros(N_zc, length(qOrig));

for i = 1 : length(qOrig)
    for n = 0 : N_zc - 1
        s_q(n + 1) = exp( -1i * pi * qOrig(i) * (n * (n + 1) ) / N_zc ); % a base sequence
    end
    S(:,i) = s_q;
end

end

%% Standalone usage - Part II
% function mustBeUnique(a)
% 
%     if numel(a)~=numel(unique(a))
%         msg = 'Root index (q) can not be repeated.';
%         error(msg)
%     end
% 
% end
% 
% function mustBeOdd(b)
% 
%     if mod(b,2) == 0
%         msg = 'Sequence length (N_zc) has to be an odd number.';
%         error(msg)
%     end
% 
% end