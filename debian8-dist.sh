#!/bin/sh

NAME=python3-tkinter-tools
#VERSION=$(grep "__version__" tktools/__init__.py | cut --delimiter="'" -f2)
VERSION=$(python -c "print(__import__('tktools').__version__)")
DIST_DIR=dist

rm -rf debian

# TODO
mkdir -p      debian/usr/local/lib/python3.0/dist-packages
cp -r tktools debian/usr/local/lib/python3.0/dist-packages
chmod 644     $(find debian/usr/local/lib -type f)

mkdir -p      "debian/usr/share/doc/$NAME/"
cp LICENSE    "debian/usr/share/doc/$NAME/copyright"
chmod 644     "debian/usr/share/doc/$NAME/copyright"

mkdir -p debian/DEBIAN

# section list : http://packages.debian.org/stable/
cat > debian/DEBIAN/control << EOF
Package: $NAME
Version: $VERSION
Section: libs
Priority: optional
Maintainer: Jérémie DECOCK <jd.jdhp@gmail.com>
Architecture: all
Depends: python (>= 3.0)
Description: Some tools for Tkinter
EOF

fakeroot dpkg-deb -b debian

mkdir -p "$DIST_DIR"
mv debian.deb "$DIST_DIR/${NAME}_${VERSION}_all.deb"
