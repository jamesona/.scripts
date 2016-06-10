#!/bin/bash

declare -A SETTINGS

while read line; do
	KEY="$(cut -d= -f1 <(echo $line))"
	VAL="$(cut -d= -f2 <(echo $line))"
	SETTINGS[$KEY]=$VAL
done < ~/git/buildsettings


BASE="${SETTINGS[BASE]}"
BUILD="$BASE/build"
SOURCE="$BASE/source"
GIT="${SETTINGS[GIT]}"
HOST="${SETTINGS[HOST]}"
USER="${SETTINGS[$1]}"
PASSWORD="${SETTINGS[PASSWORD]}"

if [ ! -d "$BASE/source/$1" ]; then
	git clone $GIT/$1 $SOURCE/$1
fi

mkdir $BUILD/$1  > /dev/null 2>&1
mkdir $BUILD/$1/cache > /dev/null 2>&1
mkdir $BUILD/$1/config > /dev/null 2>&1
mkdir $BUILD/$1/session > /dev/null 2>&1
cp -r $SOURCE/core $BUILD/$1/core > /dev/null 2>&1
chmod 755 $BUILD/$1/cache/
chmod 755 $BUILD/$1/config/
chmod 755 $BUILD/$1/core/
chmod 755 $BUILD/$1/session/
chmod 640 $BUILD/$1/core/routing.php

cat << EOF > $BUILD/$1/.htaccess
RewriteEngine On
#RewriteCond %{SERVER_PORT} !^443$
#RewriteRule ^ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=302]
RewriteRule .* core/routing.php
EOF

wget -m -nd -P $BUILD/$1/config/ ftp://$USER@$HOST/public_html/config --password $PASSWORD #> /dev/null 2>&1
