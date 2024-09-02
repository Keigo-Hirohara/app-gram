for file in スクリーンショット-*.png; do
    if [ -f "$file" ]; then
        new_name=$(echo "$file" | sed 's/スクリーンショット-/screenshot-/')
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
    fi
done

# 画面収録の改名
for file in 画面収録_*.gif; do
    if [ -f "$file" ]; then
        new_name=$(echo "$file" | sed 's/画面収録_/screenshot_/')
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
    fi
done

for file in 名称未設定のデザイン-*.jpg; do
    if [ -f "$file" ]; then
        new_name=$(echo "$file" | sed 's/名称未設定のデザイン-/design-/')
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
    fi
done