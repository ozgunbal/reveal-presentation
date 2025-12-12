#!/bin/bash

# Image optimization script
# Reduces image sizes while maintaining presentation quality

echo "🖼️  Starting image optimization..."
echo "Original size: $(du -sh images/ | cut -f1)"
echo ""

# Optimize PNG images - resize to max width 1200px and reduce quality
for img in images/*.png; do
    if [ -f "$img" ]; then
        filename=$(basename "$img")
        width=$(sips -g pixelWidth "$img" | tail -1 | awk '{print $2}')

        if [ "$width" -gt 1200 ]; then
            echo "Resizing $filename (${width}px → 1200px)..."
            sips -Z 1200 "$img" > /dev/null 2>&1
        else
            echo "Optimizing $filename (${width}px)..."
        fi

        # Convert to JPEG for better compression (except devfest logo)
        if [[ "$filename" != "devfest.png" ]]; then
            jpgfile="${img%.png}.jpg"
            sips -s format jpeg -s formatOptions 85 "$img" --out "$jpgfile" > /dev/null 2>&1
            rm "$img"
            echo "  → Converted to JPEG"
        fi
    fi
done

# Optimize JPEG images
for img in images/*.jpeg images/*.jpg; do
    if [ -f "$img" ]; then
        filename=$(basename "$img")
        width=$(sips -g pixelWidth "$img" | tail -1 | awk '{print $2}')

        if [ "$width" -gt 1200 ]; then
            echo "Resizing $filename (${width}px → 1200px)..."
            sips -Z 1200 "$img" > /dev/null 2>&1
        fi

        # Recompress JPEG with quality 85
        echo "Compressing $filename..."
        sips -s format jpeg -s formatOptions 85 "$img" --out "$img" > /dev/null 2>&1
    fi
done

echo ""
echo "✅ Optimization complete!"
echo "New size: $(du -sh images/ | cut -f1)"
echo ""
echo "⚠️  Note: PNG images converted to JPEG for better compression"
echo "💾 Original images backed up in images_backup/"
