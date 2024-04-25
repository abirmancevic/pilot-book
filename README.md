Zadoff-Chu (ZC) Pilot Books / CodeBooks
==================

The repository aims to

1. create a base ZC pilot sequence. Depending on the required sequence length, code cyclic extends or truncates the original sequence. At the end, cyclic shifts are provided. Step 1 is done according to the following paper:

> J. G. Andrews, “A Primer on Zadoff Chu Sequences,” Jun. 2023, arXiv:2211.05702v2 [cs.IT]. [Online]. Available: https://arxiv.org/abs/2211.05702,

2. and generate a book consisting of ZC pilot sequences similar to eq. (3.8) of DFT pilot sequences in the textbook:

> E. Björnson, J. Hoydis, and L. Sanguinetti, “Massive MIMO networks: Spectral, energy, and hardware efficiency,” Foundations and Trends® in Signal Processing, vol. 11, no. 3-4, pp. 154–655, 2017.

## Package Structure

The package contains the following files:
- functionPilotBook.m may be seen as a main file. The file ensures the final pilot book, Phi. In addition, the function returns the base sequence, BaseSeq for two input parameters: length of the sequences, N and a vector of root indices, q. This function calls one of the next three functions:
  - functionOriginal.m returns a base sequence of necessarily odd length, N_zc. If the desired length at the functionPilotBook.m is an odd number (N >= 2), functionOriginal.m is called.
  - functionCyclicExtending.m returns NCycExt_sf-length cyclic extension of the base sequence. This function is called in the main program only if the desired length, N >= 4 is also an even number (e.g. N = 6, N = 8, etc.).
  - functionTruncation.m returns a base sequence of the length, NTrun_sf. It is the preferred way to generate a base sequence, only for N = 2.
 - Created base sequence of length, N now cyclic shifts. In total, N - 1 cyclic shifts are obtained by calling the functionCyclicShifting.m within functionPilotBook.m.

 Please note that functionOriginal.m, functionCyclicExtending.m and functionTruncation.m are designed for both, use into functionPilotBook.m and standalone usage.