function Z = functionCyclicExtending(NCycExt_sf, qCycExt)

%% Description of the Input parameters
% NCycExt_sf: 1 x 1; a desired length of cyclic extended sequences
% qCycExt:    (NCycExt_sf - 1) x 1 or 1 x (NCycExt_sf  - 1); desired
% root indices
%
%   Prerequisites:
% NCycExt_sf >= 4 implies that N_zc >= 3 (can not be an even prime number, 
% i.e. 2)
% Notes:
% ~ It is not considered that NCycExt_sf = N_zc (which may also be named 
%   as a quasi cyclic extension, see line 29).
% ~ It is not considered that N_zc can be a composite number (see line 29).

%% Description of the Output parameters
% Z:   NCycExt_sf x length(qCycExt); created cyclic extended sequences

%% Standalone usage (uncomment lines 21 - 24 and 47 - 54)
%   Part I
%       arguments
%   NCycExt_sf (1,1) {mustBeInteger,mustBeGreaterThanOrEqual(NCycExt_sf,4)}
%   qCycExt (1,:) {mustBeInteger,mustBeInRange(qCycExt,1,NCycExt_sf,"exclude-upper"),mustBeUnique}
%       end

%% Generating the cyclic extended base sequence, z_q of the length NCycExt_sf (NCycExt_sf > N_zc)

% Determining a length of the original ZC base sequence, N_zc
N_zc = max(primes(NCycExt_sf - 1)); % choosing the greatest prime (and also an odd) number less than NCycExt_sf 
% Note: It eliminates the case of an even prime number candidate(s) of N_zc
% (i.e. N_zc == 2), because of NCycExt_sf >=4.

% Creating only a cyclic extended base sequence
z_q = zeros(NCycExt_sf, 1);
Z = zeros(NCycExt_sf, length(qCycExt));

for i = 1 : length(qCycExt)
    for n = 0 : NCycExt_sf - 1
             hn = mod(n, N_zc);
             z_q(n + 1) = exp( -1i * pi * qCycExt(i) * (hn * (hn + 1) ) / N_zc ); % a created base sequence
    end
    Z(:,i) = z_q;
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