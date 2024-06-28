#!/bin/sh
DISPLAY_NUM=1
DISPLAY_SIZE=800x600
SCRIPT_PARENT_DIR_PATH=$(dirname $(realpath "$0"))
cd $SCRIPT_PARENT_DIR_PATH
cd ..
DWM_SOURCE_CODE_ROOT_PATH=$(pwd)
DWM_BIN_PATH="$DWM_SOURCE_CODE_ROOT_PATH/dwm"
recompile_flag=false

while getopts 'r' flag; do
  case "${flag}" in
    r) recompile_flag=true ;;
  esac
done

if [ $recompile_flag = true ]; then
  make clean
  make
fi

Xephyr -br -ac -noreset -screen $DISPLAY_SIZE :$DISPLAY_NUM &
sleep 1
DISPLAY=:$DISPLAY_NUM $DWM_BIN_PATH -d

