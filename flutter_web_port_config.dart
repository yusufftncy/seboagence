// Port 8080 Kalıcı Konfigürasyonu
// Bu dosya port 8080'i varsayılan yapar

import 'dart:io';

void main() async {
  // Port 8080'i kontrol et
  try {
    final socket = await Socket.connect('localhost', 8080);
    socket.destroy();
    // Port 8080 kullanımda!
  } catch (e) {
    // Port 8080 boş!
  }
}
