SRC_VER := $(shell cat ./../controller/src/base/version.info)
BUILDTIME := $(shell date -u +%y%m%d%H%M)
VERSION = $(SRC_VER)-$(BUILDTIME)

all:
	echo "sadfsdfdsfdsfds"
	$(eval BUILDDIR=./../build/vijava)
	mkdir -p ${BUILDDIR}
	cp -ar * ${BUILDDIR}
	mvn install
	#(cd ${BUILDDIR}; fakeroot debian/rules clean)
	#(cd ${BUILDDIR}; fakeroot debian/rules binary)
	(cd ${BUILDDIR}; debuild -i -us -uc -b)
	@echo "Wrote: ${BUILDDIR}/../contrail-vijava_all.deb"

clean:
	$(eval BUILDDIR=./../build/vijava)
	rm -rf ${BUILDDIR}/*
	rm -rf ${BUILDDIR}/../libcontrail-vijava*.*
