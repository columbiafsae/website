#!/bin/bash

# Figure out where the files are going
USER="kevin"
REMOTE="columbiafsae.org"
PRODUCTION=false
if [ $# -eq 1 ] && [ $1 == "production" ]; then
  PRODUCTION=true
fi

if [ "$PRODUCTION" == true ]; then
	REMOTE_DIR="/var/www/columbiafsae.org/"
else
	REMOTE_DIR="/var/www/beta.columbiafsae.org/"
fi

# Build the site
# This should use incremental builds when that feature comes out
echo "Regenerating site..."
jekyll build > /dev/null

# Note the current git version & branch
git describe --abbrev --dirty --always >> _site/version
git rev-parse --abbrev-ref HEAD >> _site/version

# Minify site
if [ "$PRODUCTION" == true ]; then
  yui-compressor -o '.css$:.css' _site/css/*.css
  yui-compressor -o '.js$:.js' _site/js/*.js
  # Regex to remove leading tabs and spaces
  sed -i "" -e "s/^[ 	]*//g" -e "/^$/d" `find _site -type f -name '[^.]*.svg' -o -name '[^.]*.html'`
fi

# Confirm the user wants to deploy
if [ "$PRODUCTION" == true ]; then
  echo ">> Deploying to PRODUCTION <<"
  echo -ne "Check the contents of _site/. Press return to deploy! "
  read
fi

# Sync files to staging area
echo "Copying files to $REMOTE:$REMOTE_DIR..."

ssh $USER@$REMOTE "mkdir -p $REMOTE_DIR/staging/"
rsync -av --delete --exclude ".*" _site/ $USER@$REMOTE:$REMOTE_DIR/staging/ > /dev/null

# Switch over to the new site
echo "Moving files into place..."
ssh $USER@$REMOTE "cd $REMOTE_DIR && \
  mv public_html public_html.old && \
  mv staging public_html && \
  mv public_html.old staging"

echo "Done!"
