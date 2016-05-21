# eas-midi
Software MIDI synthesizer forked from the Embedded Audio Synthesis library of Sonic Network, Inc. (Sonivox)  
  
This project aims to provide a portable standalone library.  
  
### This project includes (shall include):
Dependency free library "libeasmidi"  
A "host wrapper" implementation to pull PCM data from the synth which can be passed to any audio API  
Simple GNU makefile  
Optional MIDI file to wave renderer
Optional MIDI file player (using SDL 1.x)  
Optional keyboard instrument with Protracker/Fasttracker like keyboard mapping for playing live (using SDL 1.x)  
  
  
I couldn't find any official release of the library other than the one in the Android source.  
The Android OS source code contains a MIDI synth library in the directory "sonivox" with API documentation (https://android.googlesource.com/platform/external/sonivox.git). Actually this is the Embedded Audio Synthesis library of Sonic Network, Inc., licensed under the Apache License v2.0. It is made for interactive MIDI playback and synthesis on embedded hardware like a cell phone of the years 200X (for ringtones and games).  
The library contains file parsers for different MIDI song file formats and supports DLS sound bank files. It features effect filters and allows for sending MIDI commands to the synthesizer in real time.  
A tiny General MIDI sound bank is statically included in the C code. It seems to be taken from a DLS file "wt_200k_G.dls".  
  
This synth is an alternative to Libtimidity or Fluidsynth.  
  
Since "Sonic Network", "Sonivox" and are registered names I don't use them in the project name. "Embedded Audio Synthesis" is not registered (anymore?) as it seems.

# Project status: 10%  
<pre>
Notes:  
Maybe it is a good idea to separate the file parsers from the library, so it can be compiled without them. File formats should all be optional. Since the library embeds a default sound bank there is no need for additional external files. Pushing MIDI commands and pulling output PCM data shall be mandatory, while everything further is optional.  
lib accesses different file format parsers via function pointers
file format parsers should be abstracted from the lib
the user shall be able to add a format parser without recompiling the library, thus the lib needs a dynamic parser list
	then the lib provides a way to try all parsers on a file to find the right one, or find the correct one by a user passed ID, if the user knows the format (a simple loop through a parser list should be enough, although a hash table would be best)  
  
user->lib->parser_base
   |___add___^

//the user can add new parsers at runtime (from shared libs), but may need to write a wrapper to make it compatible with parser_base

parser_register(parser_setup_struct){
  //register parser in parser list
  //fail if ID already registered
}

open_format(file_handle, filename_extention, ID, try_all){
 //1 try ID directly (like MIME type, type can be UNKNOWN): locate parser ID in parser list (hash table would be most efficient)
 //2 if failed before: try to identify by file name extension
 //3 if failed before  &&  try_all == true : try to open with all parsers until a working one is found (brute force)
}


notes:
- they used some auto processing tool to automatically comment out all error messages in the source code, seems missing here
  to revert look for "{ /* dpp:", uncomment and replace "EAS_ReporteX" with "EAS_ReportX"
- sadly internal functions and attributes are not documented
- 48000Hz not supported?
  it seems the correct sound bank is needed, else we get "EAS_Prepare returned -30"
    - with "wt_22khz.c" only _SAMPLE_RATE_22050 works
    - after switching  with "wt_44khz.c" instead only _SAMPLE_RATE_44100 works
   -> check happens in VMValidateEASLib() and can be commented out - I commented out the return and uncommented the error message
 => it seems the EAS lib package is not complete in the Android release - there was probably a sound bank C file for each of the predefined sample rates
 - embedded sample data seems to be 8 bit only (see "const EAS_SAMPLE eas_samples[]"), which render in 16 bit

- I moved all the JET code to the "unused" folder
- I switched "eas_hostmm.c" with "eas_host.c", memmory mapped files are not C standart, there are more portable ways using user controlled functions pointers for I/O


Planned:
We have a lib and host module
  The original lib code includes the host, while host is user defined/adapted
  That throws up the typical compile time lib dependency user->lib to user->lib->user
  I think setup via function pointers to user wrappers would be better
    a good way is to use a config struct the user can set up and pass to the lib
    the lib shall include a default struct for file and memory I/O

</pre>
  

