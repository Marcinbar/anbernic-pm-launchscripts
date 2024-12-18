#!/bin/bash

export HOME=/root

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

SHDIR="$(cd $(dirname "$0"); pwd)"
source $controlfolder/control.txt
get_controls

GAMEDIR=$SHDIR/colorlines
cd $GAMEDIR

export SDL_GAMECONTROLLERCONFIG_FILE="$controlfolder/gamecontrollerdb.txt"
export LD_LIBRARY_PATH="$GAMEDIR/libs:$LD_LIBRARY_PATH"

$GPTOKEYB "colorlines" -c "$GAMEDIR/colorlines.gptk" &
./colorlines

unset SDL_GAMECONTROLLERCONFIG_FILE
sudo kill -9 $(pidof gptokeyb)
