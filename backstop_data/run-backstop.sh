#!/bin/bash

export PATH=/var/lib/jenkins/.nvm/versions/node/v9.8.0/bin:$PATH

npm install backstopjs --no-package-lock
./node_modules/.bin/backstop init

sed 's|{CONTROL_BRANCH}|'${CONTROL_BRANCH}'|g' backstop-needs-replace.json > backstop.json
sed -i -e 's|{VARIANT_BRANCH}|'${VARIANT_BRANCH}'|g' backstop.json

./node_modules/.bin/backstop reference
./node_modules/.bin/backstop test

cp backstop_data/html_report/index.html backstop_data/html_report/index.txt
