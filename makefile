#config
DEFS = \
 -UJET_INTERFACE \
 -DUNIFIED_DEBUG_MESSAGES \
 -D_NO_DEBUG_PREPROCESSOR \
 -DEAS_WT_SYNTH \
 -DNUM_OUTPUT_CHANNELS=2 \
 -D_SAMPLE_RATE_44100 \
 -DMAX_SYNTH_VOICES=256 \
 -D_8_BIT_SAMPLES \
 -D_FILTER_ENABLED \
 -DDLS_SYNTHESIZER \
 -D_REVERB_ENABLED \
 -D_CHORUS_ENABLED

CFLAGS = $(DEFS) -Ihost_src
LIBS =

# equivalent to your list of C files, if you don't build selectively
SRC = $(wildcard host_src/*.c) $(wildcard lib_src/*.c)


all: $(SRC)
	gcc -o "render.exe" $^ $(CFLAGS) $(LIBS)
