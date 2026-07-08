#!/usr/bin/env bash
# Post-build hook: fix graph link visibility by patching the built JS.
#
# The Quartz graph plugin uses --lightgray for default link lines.
# In dark mode this is #393639 — nearly invisible against #161618.
# This script patches the built JS to use --gray (#999999) instead.
#
# Run after every `npx quartz build`.

set -euo pipefail

PUBLIC_DIR="${QUARTZ_PUBLIC:-$HOME/quartz-site/public}"
SCRIPTS_DIR="$PUBLIC_DIR/static/scripts"

# Find the graph script (contains forceSimulation — the D3 simulation)
GRAPH_SCRIPT=$(find "$SCRIPTS_DIR" -name "*.js" -exec grep -l "forceSimulation" {} \; 2>/dev/null | head -1)

if [[ -z "$GRAPH_SCRIPT" ]]; then
    echo "⚠️  No graph script found — skipping patch."
    exit 0
fi

echo "🔧 Patching graph links in: $(basename $GRAPH_SCRIPT)"

# Count before
BEFORE_1=$(grep -o ',color:te,' "$GRAPH_SCRIPT" | wc -l)
BEFORE_2=$(grep -o 'ee:te' "$GRAPH_SCRIPT" | wc -l)

# Patch 1: Initial link color from lightgray (te) → gray (ee)
sed -i 's/,color:te,/,color:ee,/g' "$GRAPH_SCRIPT"

# Patch 2: Hover color always gray (don't fall back to lightgray)
sed -i 's/ee:te/ee:ee/g' "$GRAPH_SCRIPT"

# Verify
AFTER_1=$(grep -o ',color:te,' "$GRAPH_SCRIPT" | wc -l)
AFTER_2=$(grep -o 'ee:te' "$GRAPH_SCRIPT" | wc -l)
echo "   Initial link: $BEFORE_1 → $AFTER_1"
echo "   Hover color:  $BEFORE_2 → $AFTER_2"
echo "   ✅ Graph links now use --gray instead of --lightgray"
