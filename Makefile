#
# Simple wrapper around OS Makefile's to ease building!
#

all: usage

usage:
	@echo "Select the OS to build (or 'clean' to remove all build directories):"
	@echo ""
	@echo "    -> aix"
	@echo "    -> bsd"
	@echo "    -> hpux"
	@echo "    -> linux"
	@echo "    -> macos"
	@echo "    -> solaris"
	@echo ""
	@echo "note: For NVME or SCSI support, please build on Linux (no lib for macos)"
	@echo ""
	@echo "Please see makedt script for building with remote hosts!"
	@echo ""

#
# Note: The OS type is required for linking to the correct SCSI library.
#       All builds are done in a subdirectory, to accomodate many builds.
#	The SCSI library symbolic link will be of the form:
#	    ln -sf ../scsilib-$(OS).c scsilib.c
#

#
# Please Note: If your compiler is not in the standard location, define this!
#              OR define the correct PATHs prior to executing this makefile.
#              Note: Builds go *much* faster with local compiler tools!
#
#PATH=/usr/software/bin:$PATH

aix:
	( mkdir -p aix.d ; cd aix.d ; make -f ../Makefile.aix VPATH=.. OS=aix )

bsd:
	( mkdir -p bsd.d ; cd bsd.d ; make -f ../Makefile.freebsd VPATH=.. )

hpux:
	( mkdir -p hpux.d ; cd hpux.d ; make -f ../Makefile.hpux VPATH=.. OS=hpux )

linux:
	( mkdir -p linux.d ; cd linux.d ; make -f ../Makefile.linux VPATH=.. OS=linux )

macos:
	( mkdir -p macos.d ; cd macos.d ; make -f ../Makefile.mac_darwin VPATH=.. )

solaris:
	( mkdir -p solaris.d ; cd solaris.d ; make -f ../Makefile.solaris VPATH=.. OS=solaris )

clean:
	@echo "Cleaning build directories..."
	@for dir in aix.d bsd.d hpux.d macos.d linux.d solaris.d; do \
		if [ -d "$$dir" ]; then \
			echo "Removing $$dir"; \
			rm -rf "$$dir"; \
		fi; \
	done
	@echo "Clean complete."

