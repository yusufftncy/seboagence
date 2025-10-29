@echo off
echo Firebase'e deploy ediliyor...

REM Flutter web build
echo Flutter web build yapılıyor...
flutter build web --release

REM Firebase'e deploy
echo Firebase'e deploy ediliyor...
firebase deploy

echo Deploy tamamlandı!
pause
