#!/bin/sh
DISPLAY_NUM=7
DISPLAY_SIZE=1200x800
SCRIPT_PARENT_DIR_PATH=$(dirname $(realpath "$0"))
cd $SCRIPT_PARENT_DIR_PATH
cd ..
DWM_SOURCE_CODE_ROOT_PATH=$(pwd)
DWM_BIN_PATH="$DWM_SOURCE_CODE_ROOT_PATH/dwm"
GDB_SERVER_PORT=7854
recompile_flag=false
debug_flag=false

while getopts 'rd' flag; do
  case "${flag}" in
      r) recompile_flag=true ;;
      d) debug_flag=true ;;
  esac
done

if [ $recompile_flag = true ]; then
  make clean
  make
fi

Xephyr -br -ac -noreset -screen $DISPLAY_SIZE :$DISPLAY_NUM &
sleep 1

if [ $debug_flag = true ]; then
    echo Compiling debug build
    make clean
    make debug
    DISPLAY=:$DISPLAY_NUM gdb --args $DWM_BIN_PATH -d
else
    DISPLAY=:$DISPLAY_NUM $DWM_BIN_PATH -d
fi
        

