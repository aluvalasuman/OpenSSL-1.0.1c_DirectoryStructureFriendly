#!/bin/bash

#Setting the build mode 
export BUILD_MODE=$1
if [ $BUILD_MODE == "RELEASE" ]; then 
	echo " "
elif [ $BUILD_MODE == "QUICK" ]; then 
	echo " "
elif [ $BUILD_MODE == "CLEAN" ]; then 
	echo " "
elif [ $BUILD_MODE == "RQUICK" ]; then 
	echo " "
else
	export BUILD_MODE=DEBUG
fi

./build_ptt.sh $BUILD_MODE 2>&1 | tee BuildLog_`date +%Y%b%d`_`date +%k%M`.log


