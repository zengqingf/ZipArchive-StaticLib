#!/bin/bash

out_x86_64_dir="Products/x86_64"
out_x86_64_file="$out_x86_64_dir/x86_64.a"
rm -rf "$out_x86_64_dir"
mkdir "$out_x86_64_dir"

out_arm64_dir="Products/arm64"
out_arm64_file="$out_arm64_dir/arm64.a"
rm -rf "$out_arm64_dir"
mkdir "$out_arm64_dir"

simfile="Products/Release-iphonesimulator/libZipArchive.a"
osfile="Products/Release-iphoneos/libZipArchive.a"

lipo "$simfile" -thin x86_64 -output "$out_x86_64_file"

cp "$osfile" "$out_arm64_file"

output_dir="Products/output"
output_file="Products/output/libZipArchive.a"

rm -rf "$output_dir"

# 检查文件 A 和文件 B 是否同时存在
if [ -f "$out_x86_64_file" ] && [ -f "$out_arm64_file" ]; then
  echo "文件都存在"
  mkdir "$output_dir"
  lipo -create "$out_x86_64_file" "$out_arm64_file" -output "$output_file"
else
  echo "文件缺失"
fi

rm -rf "$out_x86_64_dir"
rm -rf "$out_arm64_dir"

echo "任务完成"
