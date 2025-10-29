#!/bin/bash

echo "Firebase'e deploy ediliyor..."

# Flutter web build
echo "Flutter web build yapılıyor..."
flutter build web --release --no-tree-shake-icons

# Firebase'e deploy
echo "Firebase'e deploy ediliyor..."
firebase deploy

echo "Deploy tamamlandı!"
