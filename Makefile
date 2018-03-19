SRC_VER ?= $(shell cat ./../controller/src/base/version.info)
BUILDNUM ?= $(shell date -u +%m%d%Y)
export BUILDTAG ?= $(SRC_VER)-$(BUILDNUM)

build:
	$(eval BUILDDIR=./../build/vijava)
	mkdir -p ${BUILDDIR}
	cp -ar * ${BUILDDIR}
	(cd ${BUILDDIR}; mvn install)
deb: build
	(cd ${BUILDDIR}; debuild --preserve-envvar=BUILDTAG -i -us -uc -b)
	@echo "Wrote: ${BUILDDIR}/../contrail-vijava_${BUILDTAG}_all.deb"

rpm: build
	$(eval BUILDDIR=$(realpath ./../build/vijava))
	cp rpm/libcontrail-vijava.spec ${BUILDDIR}
	mkdir -p ${BUILDDIR}/{BUILD,RPMS,SOURCES,SPECS,SRPMS,TOOLS}
	rpmbuild -bb --define "_topdir ${BUILDDIR}" --define "_buildTag $(BUILDNUM)" --define "_srcVer $(SRC_VER)" rpm/libcontrail-vijava.spec

clean:
	$(eval BUILDDIR=./../build/vijava)
	(cd ${BUILDDIR}; mvn clean)
	rm -rf ${BUILDDIR}/*
	rm -rf ${BUILDDIR}/../libcontrail-vijava*.*
