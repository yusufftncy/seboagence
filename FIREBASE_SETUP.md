# Firebase Kurulum Rehberi

## 1. Firebase Console'da Proje Oluşturma

1. [Firebase Console](https://console.firebase.google.com/) adresine gidin
2. "Create a project" butonuna tıklayın
3. Proje adını girin: `sebo-agence` (veya istediğiniz isim)
4. Google Analytics'i etkinleştirin (önerilen)
5. Proje oluşturulduktan sonra "Continue" butonuna tıklayın

## 2. Web Uygulaması Ekleme

1. Firebase Console'da projenizi seçin
2. Sol menüden "Project settings" (⚙️) tıklayın
3. "Your apps" bölümünde web simgesine (</>) tıklayın
4. Uygulama adını girin: `sebo-agence-web`
5. "Register app" butonuna tıklayın
6. Konfigürasyon kodunu kopyalayın

## 3. Konfigürasyon Dosyasını Güncelleme

`web/firebase-config.js` dosyasını açın ve Firebase Console'dan aldığınız konfigürasyonu yapıştırın:

```javascript
const firebaseConfig = {
  apiKey: "your-api-key-here",
  authDomain: "your-project-id.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project-id.appspot.com",
  messagingSenderId: "your-sender-id",
  appId: "your-app-id",
  measurementId: "your-measurement-id"
};
```

## 4. Firebase CLI Kurulumu

### Windows:
```bash
npm install -g firebase-tools
```

### macOS/Linux:
```bash
npm install -g firebase-tools
```

## 5. Firebase'e Giriş Yapma

```bash
firebase login
```

## 6. Firebase Projesini Başlatma

```bash
firebase init
```

Aşağıdaki seçenekleri seçin:
- ✅ Hosting
- ✅ Firestore
- ✅ Storage
- ✅ Functions (opsiyonel)

## 7. Deploy Etme

### Windows:
```bash
deploy.bat
```

### macOS/Linux:
```bash
chmod +x deploy.sh
./deploy.sh
```

### Manuel Deploy:
```bash
flutter build web --release
firebase deploy
```

## 8. Firebase Servislerini Etkinleştirme

### Firestore Database:
1. Firebase Console'da "Firestore Database" tıklayın
2. "Create database" butonuna tıklayın
3. "Start in test mode" seçin (güvenlik kuralları zaten ayarlandı)
4. Konum seçin (europe-west1 önerilen)

### Storage:
1. Firebase Console'da "Storage" tıklayın
2. "Get started" butonuna tıklayın
3. Güvenlik kurallarını onaylayın

### Authentication (opsiyonel):
1. Firebase Console'da "Authentication" tıklayın
2. "Get started" butonuna tıklayın
3. "Sign-in method" sekmesinde istediğiniz yöntemleri etkinleştirin

## 9. Güvenlik Kuralları

Güvenlik kuralları zaten yapılandırılmıştır:
- `firestore.rules`: Firestore güvenlik kuralları
- `storage.rules`: Storage güvenlik kuralları

## 10. Test Etme

Deploy işleminden sonra Firebase Console'da "Hosting" bölümünden sitenizin URL'ini alabilirsiniz.

## Sorun Giderme

### Firebase başlatma hatası:
- `web/firebase-config.js` dosyasının doğru konfigürasyona sahip olduğundan emin olun
- Firebase Console'da projenin aktif olduğunu kontrol edin

### Deploy hatası:
- Firebase CLI'nin güncel olduğundan emin olun: `firebase --version`
- Firebase'e giriş yaptığınızdan emin olun: `firebase login`

### Build hatası:
- Flutter'ın güncel olduğundan emin olun: `flutter --version`
- Dependencies'leri güncelleyin: `flutter pub get`
