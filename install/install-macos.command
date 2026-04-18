#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRC="$SCRIPT_DIR/calcsx_exporter"
DEST="$HOME/Library/Application Support/Autodesk/Autodesk Fusion 360/API/Scripts"

if [ ! -d "$SRC" ]; then
    echo "ERROR: cannot find 'calcsx_exporter' folder next to this installer."
    echo "Make sure you extracted the full release zip before running this."
    exit 1
fi

mkdir -p "$DEST"

if [ -d "$DEST/calcsx_exporter" ]; then
    echo "Removing previous installation at $DEST/calcsx_exporter"
    rm -rf "$DEST/calcsx_exporter"
fi

cp -R "$SRC" "$DEST/"

echo ""
echo "Installed to: $DEST/calcsx_exporter"
echo ""
echo "Next steps:"
echo "  1. Restart Fusion 360 if it is running"
echo "  2. Open UTILITIES > Scripts and Add-Ins > My Scripts"
echo "  3. Select 'calcsx_exporter' and click Run"
