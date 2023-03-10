Name:          glite-info-site
Version:       0.4.0
Release:       2%{?dist}
Summary:       Site component for the glite-info-static framework.
Group:         System/Monitoring
License:       ASL 2.0
URL:           https://github.com/EGI-Foundation/glite-info-site
Source:        %{name}-%{version}.tar.gz
BuildArch:     noarch
BuildRoot:     %{_tmppath}/%{name}-%{version}-build
BuildRequires: rsync
BuildRequires: make

%description
Site component for the glite-info-static framework.

%prep
%setup -q

%build
# Nothing to build

%install
rm -rf %{buildroot}
make install prefix=%{buildroot}

%clean
rm -rf %{buildroot}

%files
%defattr(-,root,root,-)
%dir %{_sysconfdir}/glite-info-static/site
%config(noreplace) %{_sysconfdir}/glite-info-static/site/site.cfg
%config %{_sysconfdir}/glite-info-static/site/site.glue.ifc
%config %{_sysconfdir}/glite-info-static/site/site.glue1.tpl
%config %{_sysconfdir}/glite-info-static/site/site.glue2.tpl
%config %{_sysconfdir}/glite-info-static/site/site.wlcg.ifc
%doc %{_docdir}/%{name}-%{version}/README.md
%doc %{_docdir}/%{name}-%{version}/AUTHORS.md
%license /usr/share/licenses/%{name}-%{version}/COPYRIGHT
%license /usr/share/licenses/%{name}-%{version}/LICENSE.txt

%changelog
* Wed Apr 24 2013 Maria Alandes <maria.alandes.pradillo@cern.ch> - 0.4.0-2
- Added Source URL information

* Mon Sep 06 2010 Laurence Field <laurence.field@cern.ch> - 0.4.0-1
- Fixes for IS-143, IS-146 and IS-147

* Thu Apr 08 2010 Laurence Field <laurence.field@cern.ch> - 0.2.0-1
- Refactored

* Mon Feb 15 2010 Laurence Field <laurence.field@cern.ch> - 0.1.0-1
- First release
