#!/bin/bash

# Set the input file
input_file="$1"

# Set the output directories
android_dir="android/app/src/main/res"
ios_dir="ios/Runner/Assets.xcassets/AppIcon.appiconset"
windows_dir="windows/runner/resources"

# Create the output directories if they don't exist
mkdir -p "$android_dir/mipmap-mdpi" "$android_dir/mipmap-hdpi" "$android_dir/mipmap-xhdpi" "$android_dir/mipmap-xxhdpi" "$android_dir/mipmap-xxxhdpi"
mkdir -p "$ios_dir"
mkdir -p "$windows_dir"

# Resize and rename the icon for Android
convert "$input_file" -resize 48x48 "$android_dir/mipmap-mdpi/ic_launcher.png"
convert "$input_file" -resize 72x72 "$android_dir/mipmap-hdpi/ic_launcher.png"
convert "$input_file" -resize 96x96 "$android_dir/mipmap-xhdpi/ic_launcher.png"
convert "$input_file" -resize 144x144 "$android_dir/mipmap-xxhdpi/ic_launcher.png"
convert "$input_file" -resize 192x192 "$android_dir/mipmap-xxxhdpi/ic_launcher.png"

# Resize and rename the icon for iOS
convert "$input_file" -resize 20x20 "$ios_dir/Icon-App-20x20@1x.png"
convert "$input_file" -resize 20x20 "$ios_dir/Icon-App-20x20@2x.png"
convert "$input_file" -resize 20x20 "$ios_dir/Icon-App-20x20@3x.png"
convert "$input_file" -resize 29x29 "$ios_dir/Icon-App-29x29@1x.png"
convert "$input_file" -resize 29x29 "$ios_dir/Icon-App-29x29@2x.png"
convert "$input_file" -resize 29x29 "$ios_dir/Icon-App-29x29@3x.png"
convert "$input_file" -resize 40x40 "$ios_dir/Icon-App-40x40@1x.png"
convert "$input_file" -resize 40x40 "$ios_dir/Icon-App-40x40@2x.png"
convert "$input_file" -resize 40x40 "$ios_dir/Icon-App-40x40@3x.png"
convert "$input_file" -resize 60x60 "$ios_dir/Icon-App-60x60@2x.png"
convert "$input_file" -resize 60x60 "$ios_dir/Icon-App-60x60@3x.png"
convert "$input_file" -resize 76x76 "$ios_dir/Icon-App-76x76@1x.png"
convert "$input_file" -resize 76x76 "$ios_dir/Icon-App-76x76@2x.png"
convert "$input_file" -resize 83.5x83.5 "$ios_dir/Icon-App-83.5x83.5@2x.png"
convert "$input_file" -resize 1024x1024 "$ios_dir/Icon-App-1024x1024@1x.png"

# Resize and rename the icon for Windows
# convert "$input_file" -resize 16x16 "$windows_dir/app_icon_16.png"
# convert "$input_file" -resize 32x32 "$windows_dir/app_icon_32.png"
# convert "$input_file" -resize 48x48 "$windows_dir/app_icon_48.png"
# convert "$input_file" -resize 64x64 "$windows_dir/app_icon_64.png"
# convert "$input_file" -resize 128x128 "$windows_dir/app_icon_128.png"
# convert "$input_file" -resize 256x256 "$windows_dir/app_icon_256.png"
