function XCyclicShifted = functionCyclicShifting(X)
%% Introduction
% For the given ZC sequences at the input, the function generates their
% unique cyclic shifts at the output.
% The zero cyclic shift is not considered (i.e. m = 0, see line 32), which
% may be also named as a quasi cyclic shift.
% The function is intended for use with one of the following functions: 
% "functionBase", "functionCyclicExtending" or "functionTruncation".

%% Description of the Input parameters
% X:   N_zc x length(qBase) or N_sf x length(qCycExt)
%      or N_sf x length(qTrun);

%% Description of the Output parameters
% XCyclicShifted:   length(qBase) x N_zc x (N_zc - 1),
%                   length(qCycExt) x NCycExt_sf x (NCycExt_sf - 1),
%                   or length(qTrun) x NTrun_sf x (NTrun_sf - 1);
%   if ( length(qBase) > 1 ).
%
% XCyclicShifted:   N_zc x (N_zc - 1),
%                   NCycExt_sf x (NCycExt_sf - 1),
%                   or NTrun_sf x (NTrun_sf - 1);
%   otherwise.

%% Generating N - 1 cyclic shifts of the initial sequence:
% i.e. either a base, cyclic extended or truncated sequence of the length 
% N (= N_zc, NCycExt_sf, or NTrun_sf, respectively).
N = size(X, 1);
nbrOfq = size(X, 2);
XCyclicShifted = zeros(nbrOfq, N, N - 1);

for j = 1 : nbrOfq
    for m = 1 : N-1
        for n = 0 : N-1
            XCyclicShifted( j, n + 1, m ) = X( mod(n + m, N) + 1, j );
        end
    end
end

if nbrOfq == 1
    XCyclicShifted = permute(XCyclicShifted, [2 3 1]);
end

end
