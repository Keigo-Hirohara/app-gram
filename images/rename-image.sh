for file in スクリーンショット_*.jpg; do
    if [ -f "$file" ]; then
        new_name=$(echo "$file" | sed 's/スクリーンショット_/screenshot_/')
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
    fi
done
