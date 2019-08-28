+++
title = "My NES Emulator Passes Nestest!"
date = 2019-08-28T22:25:11+01:00
draft = false
+++

## preamble

I have attempted to build emulators several times in the past. I find the task to be relatively complex compared to most of the projects I take on, but also one of the most rewarding.

After (badly) implementing about half of the Motorola 6809 Microprocessor for a Dragon 32 emulator, I decided to start again. This time around I chose the Nintendo Entertainment System. Both systems use a processor similar to the MOS 6502, a chip that I am quite familiar with after learning to program for the Commodore 64.

The NES is appealing to me for several reasons:

1. It's popular, which means it has a large software library and a fantastic community.
2. The devices that make up most of the system, such as the CPU, PPU, and APU, are well understood and documented.
3. I like the 6502. The instruction set is small enough that it can be learned with relative ease, yet flexible enough to make working with it enjoyable.

My first task was to emulate a 6502 well enough that the log output matched the ever-popular [nestest log](http://www.qmtpro.com/~nes/misc/nestest.log).

## tooling is key

At first, my code would run as far as it could before hitting an unknown opcode, at which point it would exit. I would then visually compare my log to the nestest log and fix any differences I could see before implementing the new opcode. This went well enough to begin with, but as time went on it was becoming harder and harder to find the issues behind each difference. Scrolling through 5,000+ lines of output to figure out why bit 3 of the P register was set incorrectly felt a little like looking for needles in haystacks!

To remedy this, I wrote a python script to run my emulator and compare each line of output against nestest until it found a difference.

Here is an example of the test output with the SEC instruction intentionally broken:

```text
DIFF
- C72F  B0 04     BCS $C735                       A:00 X:00 Y:00 P:2[7] SP:FB PPU: 72,  0 CYC:31
+ C72F  B0 04     BCS $C735                       A:00 X:00 Y:00 P:2[6] SP:FB PPU: 72,  0 CYC:31

CONTEXT
C5F9  86 10     STX $10 = 00                    A:00 X:00 Y:00 P:26 SP:FD PPU: 24,  0 CYC:15
C5FB  86 11     STX $11 = 00                    A:00 X:00 Y:00 P:26 SP:FD PPU: 33,  0 CYC:18
C5FD  20 2D C7  JSR $C72D                       A:00 X:00 Y:00 P:26 SP:FD PPU: 42,  0 CYC:21
C72D  EA        NOP                             A:00 X:00 Y:00 P:26 SP:FB PPU: 60,  0 CYC:27
C72E  38        SEC                             A:00 X:00 Y:00 P:26 SP:FB PPU: 66,  0 CYC:29
C72F  B0 04     BCS $C735                       A:00 X:00 Y:00 P:26 SP:FB PPU: 72,  0 CYC:31
```

Beneath `DIFF` are two lines; the first being the expected (nestest) output, and the second being the output of my code. The differing characters are surrounded in brackets. Under `CONTEXT` is the last six lines of output prior to the difference. In this example, you can see that the P register (status flags) is set incorrectly. Specifically, bit #1 (carry) is not set when it should be. By changing SEC back to correctly set the carry bit, the test passes.

This turned out to be absolutely invaluable in debugging all manner of different issues. As I repeated the test many times after fixing each bug, the number of cycles between each failure slowly increased until all of a sudden the entire thing ran with no output. A quick manual verification confirmed it; my emulation had reached the end of the test!

I still have a long way to go before I can play The Legend of Zelda, but this is an exciting milestone!

## but where's the code

I will write another post or two about the design of my emulator and the parts of the code that I find most interesting. In the mean time, you can [find it all on github](https://github.com/backwardspy/nessa). I based my design on several other open source emulator projects so I hope it's not too hard to navigate! Suggestions, issues, and pull requests are all welcome.
