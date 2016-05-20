# eas-midi
Software MIDI synthesizer forked from the Embedded Audio Synthesis library of Sonic Network, Inc. (Sonivox)  
  
This project aims to separate the library from the Android OS source code. I couldn't find any other official release of the library.
  
### This project includes:
Dependency free library (libeasmidi)
A "host wrapper" implementation to pull PCM data from the synth which can be passed to any audio API  
Simple GNU makefile  
Optional MIDI file player (using SDL 1.x)  
Optional keyboard instrument with Protracker/Fasttracker like keyboard mapping for playing live (using SDL 1.x)  
  
  
The Android OS source code contains a MIDI synth library in the directory "sonivox" with full documentation (https://android.googlesource.com/platform/external/sonivox.git). Actually this is the Embedded Audio Synthesis library of Sonic Network, Inc., licensed under the Apache License v2.0. It is intended to be used for interactive MIDI playback and synthesis on embedded hardware like a cell phone of the years 200X (for ringtones and games).  
The library contains file parsers for different MIDI song file formats and supports DLS sound bank files. It features effect filters and allows for sending MIDI commands to the synthesizer in real time.  
A tiny General MIDI sound bank is statically included in the C code. It seems to be taken from a DLS file "wt_200k_G.dls".  
  
This synth is an alternative to Libtimidity or Fluidsynth.  
  
Since "Sonic Network" and "Sonivox" are registered names I don't know why it is called "libsonivox" in Android.

# Project status: 0%  
notes:  
Maybe it is a good idea to separate the file parsers from the library, so it can be compiled without them. File formats should all be optional. Since the library embeds a default sound bank there is no need for additional external files. Pushing MIDI commands and pulling output PCM data shall be mandatory, while everything furhter is optional.
