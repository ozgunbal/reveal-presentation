#!/bin/bash

# Build script for reveal.js presentation
# Creates a bundled zip file ready for slides.com upload

echo "🚀 Starting presentation build..."

# Clean previous build
echo "🧹 Cleaning previous build..."
rm -rf build
rm -f presentation-bundle.zip

# Create build directory structure
echo "📁 Creating build directory..."
mkdir -p build/dist
mkdir -p build/plugin
mkdir -p build/images
mkdir -p build/fonts

# Copy reveal.js files
echo "📦 Copying reveal.js files..."
cp -r node_modules/reveal.js/dist/* build/dist/
cp -r node_modules/reveal.js/plugin/* build/plugin/

# Copy Ubuntu font files
echo "🔤 Copying Ubuntu font files..."
cp -r node_modules/@fontsource/ubuntu/* build/fonts/

# Copy images
echo "🖼️  Copying images..."
cp -r images/* build/images/

# Copy and update index.html paths
echo "📄 Copying and updating index.html..."
cp index.html build/index.html

# Update paths in index.html for bundled version
sed -i '' 's|node_modules/reveal.js/dist/|dist/|g' build/index.html
sed -i '' 's|node_modules/reveal.js/plugin/|plugin/|g' build/index.html
sed -i '' 's|node_modules/@fontsource/ubuntu/|fonts/|g' build/index.html

# Create zip file
echo "🗜️  Creating zip file..."
cd build
zip -r ../presentation-bundle.zip . -q
cd ..

# Show results
echo ""
echo "✅ Build complete!"
echo "📊 Build size: $(du -sh build | cut -f1)"
echo "📦 Zip size: $(ls -lh presentation-bundle.zip | awk '{print $5}')"
echo ""
echo "📤 Ready to upload: presentation-bundle.zip"
