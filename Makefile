NAME=$(shell grep Name: *.spec | sed 's/^[^:]*:[^a-zA-Z]*//')
VERSION=$(shell grep Version: *.spec | sed 's/^[^:]*:[^0-9]*//')
RELEASE=$(shell grep Release: *.spec | cut -d"%" -f1 | sed 's/^[^:]*:[^0-9]*//')
build=$(shell pwd)/build
DATE=$(shell date "+%a, %d %b %Y %T %z")
dist=$(shell rpm --eval '%dist')

default:
	@echo "Nothing to do"

install:
	@echo installing ...
	@mkdir -p ${prefix}/etc/glite-info-static/site/
	@mkdir -p $(prefix)/usr/share/doc/$(NAME)-$(VERSION)/
	@mkdir -p $(prefix)/usr/share/licenses/$(NAME)-$(VERSION)/
	@install -m 0644 etc/glite-info-static/site.cfg ${prefix}/etc/glite-info-static/site
	@install -m 0644 etc/glite-info-static/site/*.tpl ${prefix}/etc/glite-info-static/site
	@install -m 0644 etc/glite-info-static/site/*.ifc ${prefix}/etc/glite-info-static/site
	@install -m 0644 README.md $(prefix)/usr/share/doc/$(NAME)-$(VERSION)/
	@install -m 0644 AUTHORS.md $(prefix)/usr/share/doc/$(NAME)-$(VERSION)/
	@install -m 0644 COPYRIGHT $(prefix)/usr/share/licenses/$(NAME)-$(VERSION)/
	@install -m 0644 LICENSE.txt $(prefix)/usr/share/licenses/$(NAME)-$(VERSION)/

dist:
	@mkdir -p $(build)/$(NAME)-$(VERSION)/
	rsync -HaS --exclude ".git" --exclude "$(build)" * $(build)/$(NAME)-$(VERSION)/
	cd $(build); tar --gzip -cf $(NAME)-$(VERSION).tar.gz $(NAME)-$(VERSION)/; cd -

sources: dist
	cp $(build)/$(NAME)-$(VERSION).tar.gz .

deb: dist
	cd $(build)/$(NAME)-$(VERSION); dpkg-buildpackage -us -uc; cd -

prepare: dist
	@mkdir -p $(build)/RPMS/noarch
	@mkdir -p $(build)/SRPMS/
	@mkdir -p $(build)/SPECS/
	@mkdir -p $(build)/SOURCES/
	@mkdir -p $(build)/BUILD/
	cp $(build)/$(NAME)-$(VERSION).tar.gz $(build)/SOURCES
	cp $(NAME).spec $(build)/SPECS

srpm: prepare
	rpmbuild -bs --define="dist $(dist)" --define='_topdir $(build)' $(build)/SPECS/$(NAME).spec

rpm: srpm
	rpmbuild --rebuild --define="dist $(dist)" --define='_topdir $(build)' $(build)/SRPMS/$(NAME)-$(VERSION)-$(RELEASE)$(dist).src.rpm

clean:
	rm -f *~ $(NAME)-$(VERSION).tar.gz
	rm -rf $(build)

.PHONY: dist srpm rpm sources clean