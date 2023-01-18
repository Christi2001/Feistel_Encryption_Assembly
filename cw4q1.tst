load FeistelEncryption.hdl,
output-file cw4q1.out,
compare-to cw4q1.cmp,
output-list plaintext%B1.16.1 key%B1.8.1 ciphertext%B1.16.1;

set plaintext 88,
set key 170,
eval,
output;

set plaintext 0,
set key 170,
eval,
output;

set plaintext 170,
set key 170,
eval,
output;

set plaintext 32766,
set key 170,
eval,
output;

set plaintext 88,
set key 0,
eval,
output;

set plaintext 0,
set key 0,
eval,
output;

set plaintext 170,
set key 0,
eval,
output;

set plaintext 32766,
set key 0,
eval,
output;
