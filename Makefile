all: build

prepare:
	npm i @babel/core @babel/cli babel-plugin-transform-class-properties @babel/preset-env babel-preset-minify

build:
	echo "//`jq < packages/@eva-ics/framework/package.json -r .version`" > dist/eva.min.js
	./node_modules/.bin/babel packages/@eva-ics/framework --config-file `pwd`/.babelrc --no-comments >> dist/eva.min.js

pub-framework:
	cp README.md ./packages/@eva-ics/framework/
	cd packages/@eva-ics/framework && npm version patch
	sed -i "s/\(const eva_sfa_framework_version\).*/\1 = '`jq < packages/@eva-ics/framework/package.json -r .version`';/g" \
		./packages/@eva-ics/framework/index.js
	cd packages/@eva-ics/framework && npm publish --access public
