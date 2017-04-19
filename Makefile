# This is Makefile for building OpenWatcom and DJGPP executables.

#####################################################
# This needs openwatcom installed.
# http://openwatcom.org/

# Just setting WATCOM should work in most cases.
export WATCOM:=${HOME}/opt/openwatcom/
export EDPATH:=${WATCOM}/eddat
export WIPFC:=${WATCOM}/wipfc
export INCLUDE:=${WATCOM}/h
export LIB:=${WATCOM}/lib386/dos/:${WATCOM}/lib386:.

#####################################################
# This is needs djgpp installed.
# https://github.com/andrewwutw/build-djgpp

# Just setting DJGPP_PREFIX should work in most cases.
export DJGPP_PREFIX=${HOME}/opt/djgpp
export BASE_DIR=${DJGPP_PREFIX}


export PATH:=${WATCOM}/binl:${DJGPP_PREFIX}/bin:${PATH}



#####################################################
# Envoriment setup

SRC=src
INCS=$(SRC)/dge.c $(SRC)/dge_gfx.c $(SRC)/dge_bmp.c $(SRC)/dge_snd.c
PRG=test_snd

default: clean setup both

setup:
	mkdir -p build/ow
	mkdir -p build/dj

	cp -Rp res/ build/ow/res
	cp -Rp res/ build/dj/res

both: dj ow

ow:
	wcl386 -l=dos4g -lr -4 -ot -oi -lr $(SRC)/$(PRG).c $(INCS)
	cp *.exe build/ow;
	rm *.o
	ls -l build/ow/*.exe;


dj:
	i586-pc-msdosdjgpp-gcc -pipe -O2 -fomit-frame-pointer -funroll-loops -ffast-math \
	       $(SRC)/$(PRG).c $(INCS) -o build/dj/$(PRG).exe
	ls -l build/dj/*.exe

clean:
	rm -rf *.o *.err *.exe *~ build/ow/* build/dj/* 2> /dev/null || true
	rm $(SRC)/*.err $(SRC)/*~ 2> /dev/null || true
