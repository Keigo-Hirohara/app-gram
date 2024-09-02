

for file in 気づけばデジタルの-娯楽中毒者になっていた！！-*.png; do
    if [ -f "$file" ]; then
        new_name=$(echo "$file" | sed 's/気づけばデジタルの-娯楽中毒者になっていた！！-/disital-addiction-/')
        mv "$file" "$new_name"
        echo "Renamed: $file -> $new_name"
    fi
done