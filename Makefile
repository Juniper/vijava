SRC_VER ?= $(shell cat ./../controller/src/base/version.info)
BUILDNUM ?= $(shell date -u +%m%d%Y)
export BUILDTAG ?= $(SRC_VER)-$(BUILDNUM)

all:
	$(eval BUILDDIR=./../build/vijava)
	mkdir -p ${BUILDDIR}
	cp -ar * ${BUILDDIR}
	(cd ${BUILDDIR}; mvn install)
	#(cd ${BUILDDIR}; fakeroot debian/rules clean)
	#(cd ${BUILDDIR}; fakeroot debian/rules binary)
	(cd ${BUILDDIR}; debuild --preserve-envvar=BUILDTAG -i -us -uc -b)
	@echo "Wrote: ${BUILDDIR}/../contrail-vijava_${BUILDTAG}_all.deb"

clean:
	$(eval BUILDDIR=./../build/vijava)
	(cd ${BUILDDIR}; mvn clean)
	rm -rf ${BUILDDIR}/*
	rm -rf ${BUILDDIR}/../libcontrail-vijava*.*
