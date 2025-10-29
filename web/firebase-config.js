// Firebase configuration for web
// Firebase Console'dan alınan konfigürasyon

import { initializeApp } from 'firebase/app';
import { getAnalytics } from 'firebase/analytics';
import { getFirestore } from 'firebase/firestore';

// Firebase konfigürasyonu - Firebase Console'dan alınan gerçek değerler
const firebaseConfig = {
  apiKey: "AIzaSyCi_urmpJoUTn45U-yG3fPjjWudDM1-D2M",
  authDomain: "seboagence-7b74b.firebaseapp.com",
  projectId: "seboagence-7b74b",
  storageBucket: "seboagence-7b74b.firebasestorage.app",
  messagingSenderId: "627830961409",
  appId: "1:627830961409:web:8aa8afa13b6e628f649700",
  measurementId: "G-GL815PZXDK"
};

// Firebase'i başlat
const app = initializeApp(firebaseConfig);

// Firebase servislerini başlat (sadece Analytics ve Firestore)
const analytics = getAnalytics(app);
const firestore = getFirestore(app);

// Global olarak erişilebilir hale getir
window.firebaseApp = app;
window.firebaseFirestore = firestore;
window.firebaseAnalytics = analytics;

export { app, analytics, firestore };
