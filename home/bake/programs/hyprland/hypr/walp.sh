wallpaper_folder="${HOME}/Pictures/walls/aesthic-wallpapers"
selected_file=$(shuf -n 1 -e "$wallpaper_folder"/*)
wall="$selected_file"
wal -i "$wall";
pkill mako;
pkill waybar;
mako &
waybar &
swww img --transition-type grow --transition-pos 0.5,0.5 --transition-fps 60 $wall;
