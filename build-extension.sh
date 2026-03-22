#!/bin/bash
# Build .mcpb extension package for Claude Desktop
set -e

BUILD_DIR="build-mcpb"
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/server"

# Copy manifest
cp manifest.json "$BUILD_DIR/"

# Copy server files into server/ directory
cp bin/launch.js "$BUILD_DIR/server/launch.js"
cp server.py "$BUILD_DIR/server/"
cp config.yaml "$BUILD_DIR/server/"
cp requirements.txt "$BUILD_DIR/server/"
cp -r engines "$BUILD_DIR/server/"
cp -r utils "$BUILD_DIR/server/"

# Create a package.json for the server dir (needed for ES module support)
cat > "$BUILD_DIR/server/package.json" << 'EOF'
{
  "type": "module"
}
EOF

echo "Build directory ready at $BUILD_DIR/"
echo ""
echo "Now run:"
echo "  cd $BUILD_DIR && npx @anthropic-ai/mcpb pack"
echo ""
echo "Or if mcpb is not available, manually zip:"
echo "  cd $BUILD_DIR && zip -r ../audiopluginmcp.mcpb manifest.json server/"
