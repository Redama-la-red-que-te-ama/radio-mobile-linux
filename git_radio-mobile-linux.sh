#!/bin/bash

DATE=$(date +%d%m%Y)
DATE_RELEASE=$(date +"%d/%m/%Y %H:%m:%S")
HOMEWRK="${HOME}/Work/redama"
REPO=$(basename `pwd`)
RELEASE="/$REPO$DATE.tar"

echo "creating tar release \n"
rm -rf "$HOMEWRK$RELEASE"
tar --exclude="$HOMEWRK$REPO/.git/*" -cvf "$HOMEWRK$RELEASE" "$HOMEWRK$REPO"

echo "creating tar archive of antenna files \n"
tar -cvf antenna.tar antenna/
echo "git add, commit, sign and push \n"
cd "$HOMEWRK$REPO"
echo "check branch \n"
BRANCHCTRL=$(git branch | grep $DATE)
if [ -z "${BRANCHCTRL}" ]
then
	git checkout -b taglio-$DATE
	git push --set-upstream origin taglio-$DATE
fi	
git add .
git commit -S
git push --force
