%define info yes

Name: lilypond
Version: 1.4.14
Release: 1
License: GPL
Group: Applications/Publishing
Source0: ftp.cs.uu.nl:/pub/GNU/LilyPond/development/lilypond-1.4.14.tar.gz
Summary: Create and print music notation 
URL: http://www.cs.uu.nl/~hanwen/lilypond
BuildRoot: /tmp/lilypond-install
# add lots of Buildreq: flex, bison, tetex, tetex-devel, tetex-latex, texinfo
# better prereqs: tetex-latex, python, (mpost?) etc.
Prereq: tetex


%description
LilyPond lets you create music notation.  It produces
beautiful sheet music from  a high-level description file.

%package documentation
Summary: Prebuilt website containing all LilyPond documentation.
Group: Applications/Publishing
# BuildArchitectures: noarch

%description documentation

The documentation of LilyPond, both in HTML and PostScript.

%prep
%setup

%build

# DO NOT use % { configure } , it hardcodes all paths, runs libtool,
# so we can't do make prefix=/tmp/ install.

# In fact, do not take out the spaces between % and { in the above comment,
# because RPM will gladly do a substitution anyway.

./configure --disable-checking --prefix=%{_prefix} --enable-optimise

make MAKE_PFA_FILES=1 all

# make info
make -C Documentation

# make  html
make web-doc top-web 

%install


rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/tmp/lilypond-rpm-doc

strip lily/out/lilypond midi2ly/out/midi2ly
make  MAKE_PFA_FILES=1 prefix="$RPM_BUILD_ROOT%{_prefix}" install

%if info=="yes"
gzip -9fn $RPM_BUILD_ROOT%{_prefix}/info/*
%endif

mkdir -p $RPM_BUILD_ROOT/usr/share/emacs/site-lisp/site-start.d
install -m 644 lilypond-mode.el lilypond-font-lock.el lilypond-indent.el $RPM_BUILD_ROOT/usr/share/emacs/site-lisp/
install -m 644 lilypond-init.el $RPM_BUILD_ROOT/usr/share/emacs/site-lisp/site-start.d

gzip -9fn $RPM_BUILD_ROOT%{_prefix}/man/man1/*

mkdir -p $RPM_BUILD_ROOT%{_prefix}/../etc/profile.d
cp buildscripts/out/lilypond-profile $RPM_BUILD_ROOT%{_prefix}/../etc/profile.d/lilypond.sh
cp buildscripts/out/lilypond-login $RPM_BUILD_ROOT%{_prefix}/../etc/profile.d/lilypond.csh


# again, make sure that main package installs even if doco fails
mkdir -p web/out
tar -C web -xzf out/web.tar.gz 


%post

touch /tmp/.lilypond-install
rm `find /var/lib/texmf -name 'feta*pk -print' -or -name 'feta*tfm -print'` /tmp/.lilypond-install

%if info=="yes"
/sbin/install-info %{_prefix}/info/lilypond.info.gz %{_prefix}/info/dir 
%endif

/usr/X11R6/bin/mkfontdir  /usr/share/lilypond/pfa/
/usr/sbin/chkfontpath --add=/usr/share/lilypond/pfa/



echo 'Please logout first before using LilyPond.'

%preun

%if info=="yes"
if [ $1 = 0 ]; then
    /sbin/install-info --delete %{_prefix}/info/lilypond.info.gz %{_prefix}/info/dir 
fi
%endif
rm -f /usr/share/lilypond/pfa/fonts.dir
/usr/sbin/chkfontpath --remove=/usr/share/lilypond/pfa/



%files
%defattr(-, root, root)
%{_datadir}/emacs/site-lisp/lilypond-*
%{_datadir}/emacs/site-lisp/site-start.d/lilypond-*

%{_prefix}/bin/abc2ly
%{_prefix}/bin/as2text
%{_prefix}/bin/convert-ly
%{_prefix}/bin/etf2ly
%{_prefix}/bin/lilypond
%{_prefix}/bin/ly2dvi
%{_prefix}/bin/midi2ly
%{_prefix}/bin/lilypond-book
%{_prefix}/bin/mup2ly
%{_prefix}/bin/musedata2ly
%{_prefix}/bin/pmx2ly

%if info=="yes"
%{_prefix}/info/lilypond.info.gz
%{_prefix}/info/lilypond-internals.info.gz
%endif

%{_prefix}/man/man1/abc2ly.1.gz
%{_prefix}/man/man1/as2text.1.gz
%{_prefix}/man/man1/convert-ly.1.gz
%{_prefix}/man/man1/etf2ly.1.gz
%{_prefix}/man/man1/lilypond.1.gz
%{_prefix}/man/man1/ly2dvi.1.gz
%{_prefix}/man/man1/midi2ly.1.gz
%{_prefix}/man/man1/lilypond-book.1.gz
%{_prefix}/man/man1/musedata2ly.1.gz
%{_prefix}/man/man1/mup2ly.1.gz
%{_prefix}/man/man1/pmx2ly.1.gz

%{_prefix}/share/lilypond/
%{_prefix}/share/locale/*/LC_MESSAGES/lilypond.mo
%{_prefix}/../etc/profile.d/lilypond.*

%files documentation
%doc web/
%doc input/
%doc mutopia/
