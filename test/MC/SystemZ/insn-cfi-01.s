# RUN: llvm-mc -triple s390x-linux-gnu -show-encoding %s | FileCheck %s

#CHECK: cfi	%r0, -2147483648        # encoding: [0xc2,0x0d,0x80,0x00,0x00,0x00]
#CHECK: cfi	%r0, -1                 # encoding: [0xc2,0x0d,0xff,0xff,0xff,0xff]
#CHECK: cfi	%r0, 0                  # encoding: [0xc2,0x0d,0x00,0x00,0x00,0x00]
#CHECK: cfi	%r0, 1                  # encoding: [0xc2,0x0d,0x00,0x00,0x00,0x01]
#CHECK: cfi	%r0, 2147483647         # encoding: [0xc2,0x0d,0x7f,0xff,0xff,0xff]
#CHECK: cfi	%r15, 0                 # encoding: [0xc2,0xfd,0x00,0x00,0x00,0x00]

	cfi	%r0, -1 << 31
	cfi	%r0, -1
	cfi	%r0, 0
	cfi	%r0, 1
	cfi	%r0, (1 << 31) - 1
	cfi	%r15, 0