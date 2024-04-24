function [Phi, BaseSeq] = functionPilotBook(N,q)

%% Description of the Input parameters
% N:   1 x 1; a desired length of ZC sequences
% q:  (N - 1) x 1 or 1 x (N  - 1); desired root indices
%
%   Prerequisites:
% N >= 2
% 1 <= q <= N - 1

%% Description of the Output parameters
% Phi:   length(q) x N x N;
%   if ( length(q) > 1 ).
%
% XCyclicShifted:   N x N;
%   otherwise.

    arguments
N (1,1) {mustBeInteger,mustBeGreaterThanOrEqual(N,2)}
q (1,:) {mustBeInteger,mustBeInRange(q,1,N,"exclude-upper"),mustBeUnique(q)}
    end

    if N == 2
        BaseSeqTrun = functionTruncation(N, q); % the one and only way
        BaseSeq = BaseSeqTrun;
    elseif N == 3
        BaseSeqTrun = functionTruncation(N, q);
        BaseSeqOrig = functionOriginal(N, q); % a preffered way
        BaseSeq = BaseSeqOrig;
    else
        BaseSeqTrun = functionTruncation(N, q);
        BaseSeqCycExt = functionCyclicExtending(N, q);
           if rem(N,2) == 1
                BaseSeqOrig = functionOriginal(N, q); % a most preffered way
                BaseSeq = BaseSeqOrig;
           else
                BaseSeq = BaseSeqCycExt; % a less preffered way
           end
    end

% Creating cyclic shifted sequences from "BaseSeq"
CyclicShiftedSeq = functionCyclicShifting(BaseSeq); 
    
% Creating the pilot book, "Phi" by the concatenation
if size( CyclicShiftedSeq, 3 ) == 1
    Phi = [BaseSeq CyclicShiftedSeq];
else
    Phi = zeros(length(q), N, N);
        for k = 1 : size(BaseSeq, 2)
            Phi(k, :, :) = [BaseSeq(:,k) permute(CyclicShiftedSeq(k, :, :), [2 3 1])]; % a preferred way
           %Phi(k, :, :) = [BaseSeq(:,k) squeeze(CyclicShiftedSeq(k, :, :))];
        end
end

end

function mustBeUnique(a)

    if numel(a)~=numel(unique(a))
        msg = 'Root index (q) can not be repeated.';
        error(msg)
    end

end