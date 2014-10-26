#!/bin/bash

# figure out where the files are going
USER="kevin"
REMOTE="columbiafsae.org"
if [ $# -eq 1 ] && [ $1 == "production" ]; then
	REMOTE_DIR="/var/www/columbiafsae.org/"
else
	REMOTE_DIR="/var/www/beta.columbiafsae.org/"
fi

echo "Regenerating site..."
rm -rf _site
jekyll build > /dev/null

# note the current git version & branch
git describe --abbrev --dirty --always >> _site/version
git rev-parse --abbrev-ref HEAD >> _site/version

# sync files to staging area
echo "Copying files to $REMOTE..."
rsync -az --exclude ".*" --progress --delete-after _site $USER@$REMOTE:$REMOTE_DIR > /dev/null

# delete the old site and copy the new one into place
echo "Moving files into place..."
ssh $USER@$REMOTE "cd $REMOTE_DIR && \
	cp -r _site public_html.new && \
	mv public_html public_html.old && \
	mv public_html.new public_html && \
	rm -rf public_html.old"

echo "Done!"
