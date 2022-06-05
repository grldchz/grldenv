#!/bin/bash
rm -v -f grldchz-ts.zip grldservice.zip
cd grldservice
echo "packaging grldservice"
find . -name "*.php" -print | zip -q ../grldservice.zip -@
echo "packaging grldchz-ts"
cd ../grldchz-ts/build
zip -q -r ../../grldchz-ts.zip * -x .htaccess sitemap.txt robots.txt
cd ../../
echo done