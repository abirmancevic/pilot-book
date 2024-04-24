function Z = functionTruncation(NTrun_sf, qTrun)

%% Description of the Input parameters
% NTrun_sf: 1 x 1; a desired length of truncated sequences
% qTrun:    (NTrun_sf - 1) x 1 or 1 x (NTrun_sf  - 1); desired root indices
%
%   Prerequisites:
% NTrun_sf >= 2
% Notes:
% ~ It is not considered that NTrun_sf = N_zc (which may be named as a quasi
%   truncation, see line 28).
% ~ Higher next primes of NTrun_sf or composite numbers greater than NTrun_sf are
%   not considered as candidates for N_zc (see line 28).

%% Description of the Output parameters
% Z:   NTrun_sf x length(qTrun); created truncated sequences

%% Standalone usage (uncomment lines 20 - 23 and 45 - 52)
%   Part I
%       arguments
%   NTrun_sf (1,1) {mustBeInteger,mustBeGreaterThanOrEqual(NTrun_sf,2)}
%   qTrun (1,:) {mustBeInteger,mustBeInRange(qTrun,1,NTrun_sf,"exclude-upper"),mustBeUnique}
%       end

%% Generating the truncated base sequence, z_q of the length NTrun_sf (NTrun_sf < N_zc)

% Determining a length of the original ZC base sequence, N_zc
N_zc = nextprime(NTrun_sf); % choosing the first greater/next prime number of the value NTrun_sf
% Note: It eliminates the case of a composite number candidates for N_zc
 
% Creating only a truncated base sequence
z_q = zeros(NTrun_sf, 1);
Z = zeros(NTrun_sf, length(qTrun));

for i = 1 : length(qTrun)
    for n = 0 : NTrun_sf - 1
                 z_q(n + 1) = exp( -1i * pi * qTrun(i) * (n * (n + 1) ) / N_zc ); % a created base sequence
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