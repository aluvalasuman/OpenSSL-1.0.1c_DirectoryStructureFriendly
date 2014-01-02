#!/bin/bash


# Setting the NDK_DEBUG=0 flag, while using ndk-build, forces the optimization level of -O2. 

#Start time of the build
echo
echo
echo
START=$(date +%s)
echo "Start Date & Time: `date --date=@$START`"
echo
echo
echo

#Setting the build mode 
export MPTT_NATIVE_BUILD_MODE=$1
if [ $MPTT_NATIVE_BUILD_MODE == "RELEASE" ]; then 
	echo "MPTT_NATIVE_BUILD_MODE: $MPTT_NATIVE_BUILD_MODE"
elif [ $MPTT_NATIVE_BUILD_MODE == "QUICK" ]; then 
	echo "MPTT_NATIVE_BUILD_MODE: $MPTT_NATIVE_BUILD_MODE"	
elif [ $MPTT_NATIVE_BUILD_MODE == "CLEAN" ]; then 
	echo "MPTT_NATIVE_BUILD_MODE: $MPTT_NATIVE_BUILD_MODE"		
elif [ $MPTT_NATIVE_BUILD_MODE == "RQUICK" ]; then 
	echo "MPTT_NATIVE_BUILD_MODE: $MPTT_NATIVE_BUILD_MODE"		
else
	export MPTT_NATIVE_BUILD_MODE=DEBUG
	echo "MPTT_NATIVE_BUILD_MODE: $MPTT_NATIVE_BUILD_MODE"
	echo "IMPORTANT: Please make sure you read Application.mk and AndroidManifest.xml file flag is set appropriately."
fi

#Building the native library
if [ $MPTT_NATIVE_BUILD_MODE == "QUICK" ]; then 
	echo "===================== QUICK ====================="
	echo "+ Building for the QUICK BUILD Mode.............................................................."
	echo "+ Debug mode options will be considered "
	echo "+ Make Sure 'APP_OPTIM := debug' in Application.mk file"
	echo "+ Make Sure 'android:debuggable=true' in AndroidManifest.xml file"
	echo "+ Make Sure 'LOCAL_CFLAGS := -g' is ADDED in all the Android.mk files (or)"
	echo "+           'LOCAL_EXPORT_CFLAGS += -g' in parent Android.mk file"
	echo "+ APP_OPTIM = `$APP_OPTIM`"
	echo "===================== QUICK ====================="
	echo
	echo
	echo
	
	ndk-build NDK_DEBUG=1 V=1 
elif [ $MPTT_NATIVE_BUILD_MODE == "RELEASE" ]; then 
	echo "===================== RELEASE ====================="
	echo "+ Building for the RELEASE Mode.............................................................."
	echo "+ Make Sure 'APP_OPTIM := release' in Application.mk file"
	echo "+ Make Sure 'android:debuggable=false' in AndroidManifest.xml file"
	echo "+ Make Sure 'LOCAL_CFLAGS := -g' is REMOVED in all the Android.mk files"	
	echo "+           'LOCAL_EXPORT_CFLAGS += -g' in parent Android.mk file"	
	echo "+ APP_OPTIM = `$APP_OPTIM`"
	echo "===================== RELEASE ====================="
	echo
	echo
	echo
	ndk-build clean
	echo
	echo
	echo
	ndk-build NDK_DEBUG=0 V=1 -B
    
elif [ $MPTT_NATIVE_BUILD_MODE == "RQUICK" ]; then 
	echo "===================== RELEASE QUICK====================="
	echo "+ Building for the RELEASE Mode.............................................................."
	echo "+ Make Sure 'APP_OPTIM := release' in Application.mk file"
	echo "+ Make Sure 'android:debuggable=false' in AndroidManifest.xml file"
	echo "+ Make Sure 'LOCAL_CFLAGS := -g' is REMOVED in all the Android.mk files"	
	echo "+           'LOCAL_EXPORT_CFLAGS += -g' in parent Android.mk file"	
	echo "+ APP_OPTIM = `$APP_OPTIM`"
	echo "===================== RELEASE QUICK ====================="
	echo
	echo
	echo
	ndk-build NDK_DEBUG=0 V=1    
	
elif [ $MPTT_NATIVE_BUILD_MODE == "CLEAN" ]; then 
	echo "===================== CLEAN ====================="
	echo "+ Cleaning the build system ..... "
	echo "===================== CLEAN ====================="
	echo
	echo
	echo
	
	ndk-build clean 
else 
	echo "===================== DEBUG ====================="
	echo "+ Building for the DEBUG Mode.............................................................."
	echo "+ Make Sure 'APP_OPTIM := debug' in Application.mk file"
	echo "+ Make Sure 'android:debuggable=true' in AndroidManifest.xml file"
	echo "+ Make Sure 'LOCAL_CFLAGS := -g' is ADDED in all the Android.mk files"
	echo "+           'LOCAL_EXPORT_CFLAGS += -g' in parent Android.mk file"	
	echo "+ APP_OPTIM = `$APP_OPTIM`"
	echo "===================== DEBUG ====================="
	echo
	echo
	echo
	ndk-build clean
	echo
	echo
	echo
	ndk-build NDK_DEBUG=1 V=1 -B 
fi

echo
echo
echo

#End time of the build
END=$(date +%s)
echo "End Date & Time: `date --date=@$END +%H:%M:%S`"
#Printing Build Time
DIFF=$(( $END - $START ))
echo "It took $DIFF seconds"

seconds=$DIFF
hours=$((seconds / 3600))
seconds=$((seconds % 3600))
minutes=$((seconds / 60))
seconds=$((seconds % 60))

echo "Time Consumed : $hours hour(s) $minutes minute(s) $seconds second(s)"
echo
echo
echo