// RAM[0] = ciphertext;
// RAM[1] = Key (unmodified);
// RAM[2] = plaintext;
// RAM[3] = 1111 1111 0000 0000;
// RAM[4] = Rotated Key;
// RAM[5] = 9th bit of key;
// RAM[6] = L0 or previous L;
// RAM[7] = R0 or previous R;
// RAM[8] = current L;
// RAM[9] = current R;
// RAM[10] = counter for loop;
// RAM[11] = result of F (Xor 1);
// RAM[12] = part of Xor 1;
// RAM[13] = result of Xor 2;
// RAM[14] = part of Xor 2;

@0 // Initialising all variables
M=0
@3
M=0
@4
M=0
@5
M=0
@6
M=0
@7
M=0
@8
M=0
@9
M=0
@10
M=0

@255 // 0000 0000 1111 1111
D=!A
@3 // 1111 1111 0000 0000
M=D
@2 // Get left side (L0)
D=M
@3
D=D&M
@6 // L0
M=D

@8 // Current L; Shift L0 to the right
M=D
@256
D=D&A
D=D-A
@37
D;JNE
@8
M=M+1

@8
D=M
@512
D=D&A
D=D-A
@48
D;JNE
@2
D=A
@8
M=D+M

@8
D=M
@1024
D=D&A
D=D-A
@59
D;JNE
@4
D=A
@8
M=D+M

@8
D=M
@2048
D=D&A
D=D-A
@70
D;JNE
@8
D=A
@8
M=D+M

@8
D=M
@4096
D=D&A
D=D-A
@81
D;JNE
@16
D=A
@8
M=D+M

@8
D=M
@8192
D=D&A
D=D-A
@92
D;JNE
@32
D=A
@8
M=D+M

@8
D=M
@16384
D=D&A
D=D-A
@103
D;JNE
@64
D=A
@8
M=D+M

@8
D=M
@111
D;JGE
@128
D=A
@8
MD=D+M

@255
D=D&A
@8
M=D
@6
M=D // Save shifted L0

@2 // Get right side (R0)
D=M
@255 // 0000 0000 1111 1111
D=D&A
@7 // R0
M=D

@1 // Take initial Key
D=M
@4 // Store it in RAM[4]
M=D

@7 // R0 or previous R
D=M
@8 // current L = previous R
M=D
@175 // jump to functions
0;JMP
@13 // Result of xor
D=M
@9 // current R = L0 Xor (R0 Xor K0)
M=D
@8 // save current L to previous L
D=M
@6
M=D
@9 // save current R to previous R
D=M
@7
M=D
@10 // loop counter
MD=M+1
@4
D=D-A
@127
D;JNE
@8 // Shift current L (L4) back to the left
D=M
M=D+M
D=M
M=D+M
D=M
M=D+M
D=M
M=D+M
D=M
M=D+M
D=M
M=D+M
D=M
M=D+M
D=M
M=D+M
D=M
@9
D=D|M
@0
M=D
@173
0;JMP

@11 // Function: Xor 1 <=> F(R0, K0) = R0 Xor Key
M=0 // Initialise variables
@12
M=0
@13
M=0
@14
M=0
@7 // previous R
D=M
@11 // Result location
M=D
@12
M=D
@4 // Take the key
D=M
@11 // RAM[11] = a Or b
M=D|M
@12 // RAM[12] = Not(a And b)
M=D&M
M=!M
D=M
@11 // RAM[11] = a Xor b = (a Or b) And Not(a And b))
M=D&M // RAM[11] now stores result of F

@6 // previous L; Function: Xor 2 <=> L0 Xor F
D=M
@13 // Result location
M=D
@14
M=D
@11 // Take the result of F
D=M
@13 // RAM[13] = a Or b
M=D|M
@14 // RAM[14] = Not(a And b)
M=D&M
M=!M
D=M
@13 // RAM[13] = a Xor b = (a Or b) And Not(a And b))
MD=D&M // RAM[13] now stores Result of Xor 2
@255
D=D&A
@13
M=D

@4 // Function for rotating the key and storing it in RAM[4]
D=M
MD=D+M // Shift by 1
M=D // Store shifted key in RAM[4]
@3
D=D&M
@5 // Store bit no. 9
M=D
@256
D=A
@5
M=M-D
D=M
@236 // Jump after else if bit 9 == 0
D;JNE
@4 // Else add 1 to the key
M=M+1
@255
D=A
@4
M=D&M // RAM[4] now stores rotated key
@133
0;JMP
