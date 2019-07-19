#!/bin/bash

COMPONENT=$1
# Capitalize first letter of component's name
NAME="$(tr '[:lower:]' '[:upper:]' <<< ${COMPONENT:0:1})${COMPONENT:1}"

cd 'src/components'

# Remove previous folder, no matter if already exists! F***k You!
rm -rf $COMPONENT
mkdir $COMPONENT

# Make controller file
touch $COMPONENT/index.js
echo "import { h, Component } from 'preact';" > $COMPONENT/index.js
echo "import { Link } from 'preact-router';" >> $COMPONENT/index.js
echo "import style from './style.less';" >> $COMPONENT/index.js
echo " " >> $COMPONENT/index.js
echo "// This a demo tags, include, etc." >> $COMPONENT/index.js
echo "// feel free to remove whatever you do not need" >> $COMPONENT/index.js
echo " " >> $COMPONENT/index.js
echo "export default class $NAME extends Component {" >> $COMPONENT/index.js
echo "	render() {" >> $COMPONENT/index.js
echo "		return (" >> $COMPONENT/index.js
echo "			<$COMPONENT class={style.$COMPONENT}>" >> $COMPONENT/index.js
echo "				<h1>$COMPONENT</h1>" >> $COMPONENT/index.js
echo "				<Link href=\"/\">Home</Link>" >> $COMPONENT/index.js
echo "			</$COMPONENT>" >> $COMPONENT/index.js
echo "		);" >> $COMPONENT/index.js
echo "	}" >> $COMPONENT/index.js
echo "}" >> $COMPONENT/index.js

# Make Style file
touch $COMPONENT/style.less
echo "@import '~style/helpers';" > $COMPONENT/style.less
echo " " >> $COMPONENT/style.less
echo ".$COMPONENT {" >> $COMPONENT/style.less
echo " " >> $COMPONENT/style.less
echo "}" >> $COMPONENT/style.less
