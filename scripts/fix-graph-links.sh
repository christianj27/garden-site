#!/bin/bash
# Post-build fix: Make Quartz graph link lines visible (PixiJS/WebGL)
# The default --gray color + 1px width makes lines nearly invisible.
# This patches the built JS to use thicker, brighter lines.

set -e
PUBLIC_DIR="/home/ubuntu/quartz-site/public"
SCRIPT_FILE=$(find "$PUBLIC_DIR/static/scripts" -name "script-*-*.js" -exec grep -l "stroke({alpha:v.alpha,width:1,color:v.color})" {} \; 2>/dev/null | head -1)

if [ -z "$SCRIPT_FILE" ]; then
    echo "[fix-graph] No matching graph script found, skipping"
    exit 0
fi

echo "[fix-graph] Patching $SCRIPT_FILE"

# Replace link stroke: thicker lines (2px) + visible gray (#999999)
sed -i 's/width:1,color:v\.color/width:2,color:"#999999"/g' "$SCRIPT_FILE"

echo "[fix-graph] Patch applied successfully"
