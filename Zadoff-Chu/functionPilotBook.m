function [Phi, InitSeq] = functionPilotBook(N,q)

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
        InitSeqTrun = functionTruncation(N, q); % the one and only way
        InitSeq = InitSeqTrun;
    elseif N == 3
        InitSeqTrun = functionTruncation(N, q);
        BaseSeq = functionBase(N, q); % a preffered way
        InitSeq = BaseSeq;
    else
        InitSeqTrun = functionTruncation(N, q);
        InitSeqCycExt = functionCyclicExtending(N, q);
           if rem(N,2) == 1
                BaseSeq = functionBase(N, q); % a most preffered way
                InitSeq = BaseSeq;
           else
                InitSeq = InitSeqCycExt; % a less preffered way
           end
    end

% Creating cyclic shifted sequences from "InitSeq"
CyclicShiftedSeq = functionCyclicShifting(InitSeq); 
    
% Creating the pilot book, "Phi" by the concatenation
if size( CyclicShiftedSeq, 3 ) == 1
    Phi = [InitSeq CyclicShiftedSeq];
else
    Phi = zeros(length(q), N, N);
        for k = 1 : size(InitSeq, 2)
            Phi(k, :, :) = [InitSeq(:,k) permute(CyclicShiftedSeq(k, :, :), [2 3 1])]; % a preferred way
           %Phi(k, :, :) = [InitSeq(:,k) squeeze(CyclicShiftedSeq(k, :, :))];
        end
end

end

function mustBeUnique(a)

    if numel(a)~=numel(unique(a))
        msg = 'Root index (q) can not be repeated.';
        error(msg)
    end

end
