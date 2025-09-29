#!/bin/bash

# Smart Repo Scanner & Cleanup Suggestion Tool

# Usage: ./smart_repo_scan.sh /path/to/repo

# Exit on error
set -e

TARGET_DIR="$1"

if [[ -z "$TARGET_DIR" ]]; then
  echo "❌ Usage: $0 /path/to/repo"
  exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "❌ Error: $TARGET_DIR is not a valid directory."
  exit 1
fi

echo "📁 Scanning folder: $TARGET_DIR"
echo

# 1. Count files by extension
echo "📊 File type summary (by extension):"
find "$TARGET_DIR" -type f | sed 's/.*\.//' | sort | uniq -c | sort -nr
echo

# 2. Show top 10 largest files
echo "📦 Top 10 largest files:"
find "$TARGET_DIR" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 10
echo

# 3. Show top 5 largest folders
echo "📁 Top 5 largest folders:"
du -sh "$TARGET_DIR"/* 2>/dev/null | sort -hr | head -n 5
echo

# 4. Suggest deletable files
echo "🧹 Suggested deletable files:"
find "$TARGET_DIR" \( \
  -name "*.dmg" -o \
  -name "*.log" -o \
  -name "*.zip" -o \
  -name "*.tar.gz" -o \
  -name "*.tmp" -o \
  -name ".DS_Store" \
\) -print > /tmp/deletable_files.txt

cat /tmp/deletable_files.txt
echo

# 5. Suggest large, common dev folders to clean
echo "📦 Suggested large folders to review for cleanup:"
FOLDERS=("node_modules" "__pycache__" ".venv" "dist" "build")

for folder in "${FOLDERS[@]}"; do
  matches=$(find "$TARGET_DIR" -type d -name "$folder")
  if [[ -n "$matches" ]]; then
    echo "📁 $folder:"
    echo "$matches"
    echo
  fi
done

# 6. Ask user if they want to delete suggested files
read -p "🗑️  Do you want to delete the suggested files above? [y/N] " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  echo "🔨 Deleting files..."
  xargs rm -v < /tmp/deletable_files.txt
  echo "✅ Cleanup done."
else
  echo "❌ Skipping deletion."
fi

rm -f /tmp/deletable_files.txt
