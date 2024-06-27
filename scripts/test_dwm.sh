#!/bin/sh
DISPLAY_NUM=1
DISPLAY_SIZE=800x600
SCRIPT_PATH=$(realpath "$0")
DWM_SOURCE_CODE_ROOT_PATH=$(realpath $(dirname $(realpath $(dirname "$SCRIPT"))))
DWM_BIN_PATH="$DWM_SOURCE_CODE_ROOT_PATH/dwm"
recompile_flag=false

while getopts 'r' flag; do
  case "${flag}" in
    r) recompile_flag=true ;;
  esac
done

if [ $recompile_flag = true ]; then
  cd $DWM_SOURCE_CODE_ROOT_PATH
  make clean
  make
fi

Xephyr -br -ac -noreset -screen $DISPLAY_SIZE :$DISPLAY_NUM &
sleep 1
DISPLAY=:$DISPLAY_NUM $DWM_BIN_PATH

