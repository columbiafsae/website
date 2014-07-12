#!/bin/bash

USER="kevin"
REMOTE="kevinchen.co"
REMOTE_DIR="/var/www/fsae.kevinchen.co/"

echo "Regenerating site..."
rm -rf _site
jekyll build > /dev/null

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
