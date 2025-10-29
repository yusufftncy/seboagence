/// 🌿 Şifa İpek Projesi Detay Sayfası
///
/// Bu sayfa, Şifa İpek projesinin detaylarını gösterir.
/// Yeşil ve beyaz renk teması kullanılır.
library;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/branding.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/services/navigation_service.dart';
import '../widgets/optimized_navigation_bar.dart';

class SifaIpekDetailPage extends ConsumerWidget {
  const SifaIpekDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Açık gri arka plan
      body: Column(
        children: [
          const OptimizedNavigationBar(),
          Expanded(child: _SifaIpekDetailContent()),
        ],
      ),
    );
  }
}

/// Şifa İpek Detay İçeriği
class _SifaIpekDetailContent extends StatelessWidget {
  const _SifaIpekDetailContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [_HeroSection(), _FooterWidget(context)]),
    );
  }

  void _showImageDialog(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return PopScope(
            canPop: true,
            onPopInvokedWithResult: (didPop, result) {
              if (!didPop) {
                Navigator.of(context).pop();
              }
            },
            child: Scaffold(
              backgroundColor: Colors.black.withValues(alpha: 0.7),
              body: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: Center(
                    child: AbsorbPointer(
                      absorbing: false,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/sifa2.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}

/// Hero Section - Yeşil tema
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? Branding.spacingM : Branding.spacingXXL,
        vertical: isMobile ? Branding.spacingL : Branding.spacingXXL * 1.5,
      ),
      child: Center(
        child: Container(
          width: isMobile ? double.infinity : 1000,
          padding: EdgeInsets.all(isMobile ? 20 : 40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Proje ikonu - Yeşil tema
              Container(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.favorite,
                  color: const Color(0xFF10B981),
                  size: isMobile ? 36 : 48,
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Ana başlık
              Text(
                'Şifa Projesi',
                style: TextStyle(
                  color: const Color(0xFF1F2937),
                  fontSize: isMobile
                      ? 24.0
                      : isTablet
                      ? 32.0
                      : 40.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXL,
              ),

              // Proje Görseli Slider
              _ProjectImageSlider(),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXL,
              ),

              // Proje açıklama metni
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 160.0,
                ),
                child: Text(
                  'Kalıcı Sağlık ve Kapsayıcı Kalkınmayla Gelen Derman\n\n"Şifa," kelime anlamı ile sadece fiziksel iyileşmeyi değil, aynı zamanda toplumsal derman bulmayı, ruhsal dinginliği ve kalıcı bir sağlıklı yaşamı ifade eder. Biz Şifa Bölümü olarak, toplumun tüm katmanlarında hissedilen bu bütünsel iyileşmenin, izole çabalarla değil, ancak güçlü bir ortak bilinçle sağlanabileceğine inanıyoruz. Bu inançla yola çıkarak, misyonumuzu belirlediğiniz beş temel direk üzerine kurduk: Yardımlaşma ve dayanışma ile toplumsal yaralarımızı sararken; doğa sevgisi ile yaşam kaynağımızı koruyor; kadın gücünü merkeze alarak toplumsal dönüşümü hızlandırıyor ve tüm bu unsurların birleşimiyle kapsayıcı ve sürdürülebilir kalkınmayı hedefliyoruz. Amacımız, sadece anlık çözümler sunmak değil, gelecek nesillere onurlu, sağlıklı ve derman bulmuş bir yaşam vaat eden, köklü bir etki yaratmaktır.',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isMobile
                        ? 12.0
                        : isTablet
                        ? 14.0
                        : 16.0,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Slogan
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 120.0,
                ),
                padding: EdgeInsets.all(
                  isMobile ? Branding.spacingM : Branding.spacingXXL,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '"Her ilmekte umut, her lifte yeniden doğuş."',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isMobile
                        ? 16.0
                        : isTablet
                        ? 18.0
                        : 20.0,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Su Kuyusu Projesi Bölümü
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 10.0 : 40.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Responsive.responsiveWidget(
                  context,
                  mobile: _buildMobileSuKuyusuSection(),
                  tablet: _buildTabletSuKuyusuSection(),
                  desktop: _buildDesktopSuKuyusuSection(),
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Şifa projesi açıklama metni
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 160.0,
                ),
                child: Text(
                  'Şifa projesi kapsamında, toplumsal iyileşme çalışmalarımızı ihtiyaç analizi yaparak belirlenen bölgelerde gerçekleştiriyoruz. Bu sayede projelerimiz toplumun en çok ihtiyaç duyduğu alanlarda etkili oluyor ve kalıcı değişim yaratıyor.',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: isMobile
                        ? 12.0
                        : isTablet
                        ? 14.0
                        : 16.0,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Kota ve Organizasyon Bölümü
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 120.0,
                ),
                padding: EdgeInsets.all(
                  isMobile ? Branding.spacingM : Branding.spacingXXL,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5), // Daha belirgin açık yeşil
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Üstteki ikon
                    Container(
                      width: isMobile ? 48 : 60,
                      height: isMobile ? 48 : 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.handshake,
                        color: Colors.white,
                        size: isMobile ? 24 : 30,
                      ),
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingM : Branding.spacingXL,
                    ),

                    // Başlık
                    Text(
                      'El Birliğiyle Gelen Derman: Yardımlaşma ve Dayanışma',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 20.0
                            : isTablet
                            ? 24.0
                            : 28.0,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingM : Branding.spacingXL,
                    ),

                    // Metin içeriği
                    Text(
                      'Toplumsal Şifa, ancak birbirimize omuz verdiğimizde mümkündür. Bir toplumun yaralarını sarması, zorluklar karşısında kurduğu güçlü dayanışma köprüleriyle başlar. Biz, bu bölümde gönüllülük ruhunu ve karşılıksız desteği en önde tutuyoruz. İhtiyaç sahiplerine uzanan her el, toplumsal bağlarımızı güçlendiren ve yaralarımızı saran birer derman kaynağıdır. Birlikte hareket etme bilinciyle, toplumsal iyileşme sürecimizi hızlandırıyoruz.',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 12.0
                            : isTablet
                            ? 14.0
                            : 16.0,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // İkinci Bölüm - Su Kalitesi
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 120.0,
                ),
                padding: EdgeInsets.all(
                  isMobile ? Branding.spacingM : Branding.spacingXXL,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5), // Daha belirgin açık yeşil
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Üstteki ikon
                    Container(
                      width: isMobile ? 48 : 60,
                      height: isMobile ? 48 : 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.water_drop,
                        color: Colors.white,
                        size: isMobile ? 24 : 30,
                      ),
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingM : Branding.spacingXL,
                    ),

                    // Başlık
                    Text(
                      'Doğanın İyileştirici Gücü: Ekolojik Şifa',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 20.0
                            : isTablet
                            ? 24.0
                            : 28.0,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingM : Branding.spacingXL,
                    ),

                    // Metin içeriği
                    Text(
                      'Kalıcı sağlık ve derman, temiz ve dengeli bir çevrede mümkündür. Doğanın mucizevi ve iyileştirici gücünün farkındayız. Bu nedenle, çevreye duyarlı, sürdürülebilir yaklaşımları benimseyerek doğal kaynaklarımızı koruyoruz. Doğa ile uyum içinde yaşamak, hem bedenimize hem de ruhumuza Şifa veren en temel kaynaktır. Ekolojik dengeyi gözeterek, gelecek nesillere daha sağlıklı bir çevre mirası bırakmayı hedefliyoruz.',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 12.0
                            : isTablet
                            ? 14.0
                            : 16.0,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Üçüncü Bölüm - Topluluk Eğitimi
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 120.0,
                ),
                padding: EdgeInsets.all(
                  isMobile ? Branding.spacingM : Branding.spacingXXL,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5), // Daha belirgin açık yeşil
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Üstteki ikon
                    Container(
                      width: isMobile ? 48 : 60,
                      height: isMobile ? 48 : 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.school,
                        color: Colors.white,
                        size: isMobile ? 24 : 30,
                      ),
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingM : Branding.spacingXL,
                    ),

                    // Başlık
                    Text(
                      '♀ Güçlü Yarınlar: Kadın Gücüyle Şekillenen Toplum',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 20.0
                            : isTablet
                            ? 24.0
                            : 28.0,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingM : Branding.spacingXL,
                    ),

                    // Metin içeriği
                    Text(
                      'Toplumsal yapımızın iyileşme ve kalkınma süreci, kadınların güçlenmesiyle başlar. Kadın emeği ve vizyonu, topluma en hızlı ve en kalıcı dermanı getiren güçtür. Kadınlarımızın potansiyelini ortaya çıkarıyor, mesleki gelişimlerini destekliyor ve ekonomik hayata tam katılımlarını teşvik ediyoruz. Kadınların liderliği, toplumsal Şifa ve dönüşümün en önemli katalizörüdür.',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 12.0
                            : isTablet
                            ? 14.0
                            : 16.0,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Dördüncü Bölüm - Bütünsel Kalkınma
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 120.0,
                ),
                padding: EdgeInsets.all(
                  isMobile ? Branding.spacingM : Branding.spacingXXL,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5), // Daha belirgin açık yeşil
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Üstteki ikon
                    Container(
                      width: isMobile ? 48 : 60,
                      height: isMobile ? 48 : 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.trending_up,
                        color: Colors.white,
                        size: isMobile ? 24 : 30,
                      ),
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingM : Branding.spacingXL,
                    ),

                    // Başlık
                    Text(
                      'Bütünsel Kalkınma: Kalıcı Dermanın Teminatı',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 20.0
                            : isTablet
                            ? 24.0
                            : 28.0,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingM : Branding.spacingXL,
                    ),

                    // Metin içeriği
                    Text(
                      'Bizim için kalkınma; sadece ekonomik büyüme değil, aynı zamanda eğitim, sağlık ve fırsat eşitliği ile sağlanan bütünsel bir iyileşme sürecidir. Sürdürülebilir Kalkınma, bireylerin geleceğe güvenle baktığı, kalıcı Şifa bulduğu bir yaşamın teminatıdır. Bu amaçla, adil, kapsayıcı ve kalıcı çözümler üreterek toplumsal refahı artırmayı ve her bireyin onurlu bir yaşam sürmesini sağlamayı hedefliyoruz.',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 12.0
                            : isTablet
                            ? 14.0
                            : 16.0,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // İyileşme Yolculuğuna Katılın Metni
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 200.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '💖 İyileşme Yolculuğumuza Katılın',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 18.0
                            : isTablet
                            ? 21.0
                            : 24.0,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(
                      height: isMobile ? Branding.spacingS : Branding.spacingL,
                    ),
                    Text(
                      'Bu büyük Şifa yolculuğunda sizin de katkılarınızla ilerlemek istiyoruz. Sizin desteğiniz, dayanışma ruhumuzu büyütecek, doğamızı koruyacak ve kalkınma çabalarımızı daha fazla insana ulaştıracaktır. Birlikte, derman bulduğumuz, sağlıklı ve güçlü bir gelecek inşa edelim!',
                      style: TextStyle(
                        color: const Color(0xFF1F2937),
                        fontSize: isMobile
                            ? 12.0
                            : isTablet
                            ? 14.0
                            : 16.0,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Şifa Fotoğrafı
              GestureDetector(
                onTap: () => _SifaIpekDetailContent()._showImageDialog(context),
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20.0 : 80.0,
                  ),
                  height: isMobile ? 120 : 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'assets/images/sifa2.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFF3F4F6),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image,
                                  color: const Color(0xFF9CA3AF),
                                  size: isMobile ? 36 : 64,
                                ),
                                SizedBox(height: Branding.spacingM),
                                Text(
                                  'Fotoğraf Yüklenemedi',
                                  style: TextStyle(
                                    color: const Color(0xFF6B7280),
                                    fontSize: isMobile
                                        ? 14
                                        : isTablet
                                        ? 16
                                        : 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Alt başlık
              Text(
                'Toplumsal İyileşme ve Sürdürülebilir Kalkınma',
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: isMobile
                      ? 16.0
                      : isTablet
                      ? 18.0
                      : 20.0,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: isMobile ? Branding.spacingM : Branding.spacingXXL,
              ),

              // Kategori etiketi
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  ),
                ),
                child: const Text(
                  'Toplumsal İyileşme Projesi',
                  style: TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Su Kuyusu Bölümü - Mobile
  Widget _buildMobileSuKuyusuSection() {
    return Column(
      children: [
        // Sol bölüm - Mavi panel
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Color(0xFFECFDF5), // Açık yeşil
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Barış İpeği Projesi',
                style: TextStyle(
                  color: const Color(0xFF1F2937),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Hatay\'da üretilen barış ipeği ile sosyal sorumluluk projeleri gerçekleştiriyor, toplumsal dayanışmayı güçlendiriyoruz.',
                style: TextStyle(
                  color: const Color(0xFF6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        // Sağ bölüm - Şifa fotoğrafı
        Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Image.asset(
              'assets/images/sifa1.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFF3F4F6),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: const Color(0xFF6B7280),
                          size: 48,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Fotoğraf Yüklenemedi',
                          style: TextStyle(
                            color: const Color(0xFF6B7280),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // Su Kuyusu Bölümü - Tablet
  Widget _buildTabletSuKuyusuSection() {
    return Row(
      children: [
        // Sol bölüm - Mavi panel
        Expanded(
          flex: 1,
          child: Container(
            height: 300,
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              color: Color(0xFFECFDF5), // Açık yeşil
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Barış İpeği Projesi',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Hatay\'da üretilen barış ipeği ile sosyal sorumluluk projeleri gerçekleştiriyor, toplumsal dayanışmayı güçlendiriyoruz.',
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Sağ bölüm - Şifa fotoğrafı
        Expanded(
          flex: 1,
          child: Container(
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/images/sifa1.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF3F4F6),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: const Color(0xFF6B7280),
                            size: 64,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Fotoğraf Yüklenemedi',
                            style: TextStyle(
                              color: const Color(0xFF6B7280),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Su Kuyusu Bölümü - Desktop
  Widget _buildDesktopSuKuyusuSection() {
    return Row(
      children: [
        // Sol bölüm - Mavi panel
        Expanded(
          flex: 1,
          child: Container(
            height: 350,
            padding: const EdgeInsets.all(40),
            decoration: const BoxDecoration(
              color: Color(0xFFECFDF5), // Açık yeşil
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Barış İpeği Projesi',
                  style: TextStyle(
                    color: const Color(0xFF1F2937),
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Hatay\'da üretilen barış ipeği ile sosyal sorumluluk projeleri gerçekleştiriyor, toplumsal dayanışmayı güçlendiriyoruz.',
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Sağ bölüm - Şifa fotoğrafı
        Expanded(
          flex: 1,
          child: Container(
            height: 350,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                'assets/images/sifa1.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF3F4F6),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: const Color(0xFF6B7280),
                            size: 80,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Fotoğraf Yüklenemedi',
                            style: TextStyle(
                              color: const Color(0xFF6B7280),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Proje Görseli Slider Widget
class _ProjectImageSlider extends StatefulWidget {
  const _ProjectImageSlider();

  @override
  State<_ProjectImageSlider> createState() => _ProjectImageSliderState();
}

class _ProjectImageSliderState extends State<_ProjectImageSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  // Proje görselleri listesi
  final List<Map<String, dynamic>> _projectImages = [
    {
      'title': 'Şifa Projesi',
      'description': 'Toplumsal iyileşme çalışmaları',
      'image': 'assets/images/sifaslider1.jpg', // Şifa slider görseli
    },
    {
      'title': 'Toplumsal Dayanışma',
      'description': 'Birlikte iyileşme çalışmaları',
      'image': 'assets/images/sifaslider2.jpg',
    },
    {
      'title': 'Ekolojik Şifa',
      'description': 'Doğa ile uyum içinde yaşam',
      'image': 'assets/images/sifaslider3.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        int nextIndex = (_currentIndex + 1) % _projectImages.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Column(
      children: [
        // Slider Container
        SizedBox(
          height: isMobile
              ? 300
              : isTablet
              ? 400
              : 450,
          child: GestureDetector(
            onTap: () {
              // Otomatik olarak sonraki slide'a geç
              int nextIndex = (_currentIndex + 1) % _projectImages.length;
              _pageController.animateToPage(
                nextIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _projectImages.length,
              itemBuilder: (context, index) {
                final imageData = _projectImages[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Görsel
                        Image.asset(
                          imageData['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(
                                      0xFF10B981,
                                    ).withValues(alpha: 0.8),
                                    const Color(
                                      0xFF059669,
                                    ).withValues(alpha: 0.9),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      color: Colors.white,
                                      size: isMobile ? 48 : 80,
                                    ),
                                    SizedBox(height: Branding.spacingM),
                                    Text(
                                      'Fotoğraf Yüklenemedi',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isMobile
                                            ? 16
                                            : isTablet
                                            ? 20
                                            : 24,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        // Gradient overlay
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: Branding.spacingL),

        // Navigation Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _projectImages.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentIndex == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? const Color(0xFF10B981)
                    : const Color(0xFF10B981).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),

        SizedBox(height: Branding.spacingM),
      ],
    );
  }
}

// Footer Widget
class _FooterWidget extends StatelessWidget {
  const _FooterWidget(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Responsive.responsivePadding(
        context,
        mobile: const EdgeInsets.all(16.0),
        tablet: const EdgeInsets.all(20.0),
        desktop: const EdgeInsets.all(24.0),
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF131B2E), // Dark blue-grey
      ),
      child: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileFooter(context),
        tablet: _buildTabletFooter(context),
        desktop: _buildDesktopFooter(context),
      ),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      children: [
        _buildMobileFooterLogo(),
        const SizedBox(height: 20),
        _buildMobileFooterLinks(),
        const SizedBox(height: 20),
        _buildMobileFooterContact(),
        const SizedBox(height: 20),
        _buildMobileFooterBottom(),
      ],
    );
  }

  Widget _buildTabletFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildTabletFooterLogo()),
            const SizedBox(width: 20),
            Expanded(flex: 1, child: _buildTabletFooterLinks()),
            const SizedBox(width: 20),
            Expanded(flex: 1, child: _buildTabletFooterContact()),
          ],
        ),
        const SizedBox(height: 24),
        _buildTabletFooterBottom(),
      ],
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: _buildFooterLogo()),
            const SizedBox(width: 32),
            Expanded(flex: 1, child: _buildFooterLinks()),
            const SizedBox(width: 32),
            Expanded(flex: 1, child: _buildFooterContact()),
          ],
        ),
        const SizedBox(height: 24),
        _buildFooterBottom(),
      ],
    );
  }

  Widget _buildMobileFooterLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo - Mobile'da ortalanmış
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                'ŞEBO',
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFE0E0E0),
                    width: 1.0,
                  ),
                ),
              ),
              child: const Text(
                'creative agency',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontWeight: FontWeight.w300,
                  fontSize: 9,
                  letterSpacing: 1.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Açıklama - Mobile'da küçük ve ortalanmış
        Text(
          'Yaratıcı ve yenilikçi çözümler sunan premium dijital ajans olarak, müşterilerimize en iyi hizmeti sunmayı hedefliyoruz.',
          textAlign: TextAlign.center,
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFB0B0B0),
            height: 1.4,
            fontSize: 10,
          ),
        ),

        const SizedBox(height: 16),

        // Sosyal medya - Mobile'da kompakt
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMobileSocialIcon(Icons.facebook, 'https://facebook.com'),
            const SizedBox(width: 8),
            _buildMobileSocialIcon(Icons.camera_alt, 'https://instagram.com'),
            const SizedBox(width: 8),
            _buildMobileSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: 8),
            _buildMobileSocialIcon(Icons.chat, 'https://twitter.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildTabletFooterLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 7.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: const Text(
                'ŞEBO',
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFE0E0E0),
                    width: 1.2,
                  ),
                ),
              ),
              child: const Text(
                'creative agency',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontWeight: FontWeight.w300,
                  fontSize: 11,
                  letterSpacing: 1.1,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Açıklama
        Text(
          'Yaratıcı ve yenilikçi çözümler sunan premium dijital ajans olarak, müşterilerimize en iyi hizmeti sunmayı hedefliyoruz.',
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFB0B0B0),
            height: 1.5,
            fontSize: 11,
          ),
        ),

        const SizedBox(height: 16),

        // Sosyal medya
        Row(
          children: [
            _buildTabletSocialIcon(Icons.facebook, 'https://facebook.com'),
            const SizedBox(width: 12),
            _buildTabletSocialIcon(Icons.camera_alt, 'https://instagram.com'),
            const SizedBox(width: 12),
            _buildTabletSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: 12),
            _buildTabletSocialIcon(Icons.chat, 'https://twitter.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: const Text(
                'ŞEBO',
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFFE0E0E0),
                    width: 1.0,
                  ),
                ),
              ),
              child: const Text(
                'creative agency',
                style: TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontWeight: FontWeight.w300,
                  fontSize: 10,
                  letterSpacing: 1.0,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Açıklama
        Text(
          'Yaratıcı ve yenilikçi çözümler sunan premium dijital ajans olarak, müşterilerimize en iyi hizmeti sunmayı hedefliyoruz.',
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFFB0B0B0),
            height: 1.4,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 16),

        // Sosyal medya
        Row(
          children: [
            _buildSocialIcon(Icons.facebook, 'https://facebook.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.camera_alt, 'https://instagram.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.business, 'https://linkedin.com'),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.chat, 'https://twitter.com'),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileSocialIcon(IconData icon, String url) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Icon(icon, color: const Color(0xFFE0E0E0), size: 14),
    );
  }

  Widget _buildTabletSocialIcon(IconData icon, String url) {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Icon(icon, color: const Color(0xFFE0E0E0), size: 16),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Icon(icon, color: const Color(0xFFE0E0E0), size: 16),
    );
  }

  Widget _buildMobileFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hızlı Linkler',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        _buildMobileFooterLink('Ana Sayfa'),
        _buildMobileFooterLink('Hakkımızda'),
        _buildMobileFooterLink('Projelerimiz'),
        _buildMobileFooterLink('Konferanslar'),
        _buildMobileFooterLink('İletişim'),
      ],
    );
  }

  Widget _buildTabletFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Linkler',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 14),
        _buildTabletFooterLink('Ana Sayfa'),
        _buildTabletFooterLink('Hakkımızda'),
        _buildTabletFooterLink('Projelerimiz'),
        _buildTabletFooterLink('Konferanslar'),
        _buildTabletFooterLink('İletişim'),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Linkler',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _buildFooterLink('Ana Sayfa'),
        _buildFooterLink('Hakkımızda'),
        _buildFooterLink('Projelerimiz'),
        _buildFooterLink('Konferanslar'),
        _buildFooterLink('İletişim'),
      ],
    );
  }

  Widget _buildMobileFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: _HoverableFooterLink(
        text: text,
        fontSize: 10,
        textAlign: TextAlign.center,
        onTap: () {
          switch (text) {
            case 'Ana Sayfa':
              NavigationService.goToHome();
              break;
            case 'Hakkımızda':
              NavigationService.goToAbout();
              break;
            case 'Projelerimiz':
              NavigationService.goToWorks();
              break;
            case 'Konferanslar':
              NavigationService.goToConferences();
              break;
            case 'İletişim':
              NavigationService.goToContact();
              break;
          }
        },
      ),
    );
  }

  Widget _buildTabletFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: _HoverableFooterLink(
        text: text,
        fontSize: 11,
        onTap: () {
          switch (text) {
            case 'Ana Sayfa':
              NavigationService.goToHome();
              break;
            case 'Hakkımızda':
              NavigationService.goToAbout();
              break;
            case 'Projelerimiz':
              NavigationService.goToWorks();
              break;
            case 'Konferanslar':
              NavigationService.goToConferences();
              break;
            case 'İletişim':
              NavigationService.goToContact();
              break;
          }
        },
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _HoverableFooterLink(
        text: text,
        fontSize: 12,
        onTap: () {
          switch (text) {
            case 'Ana Sayfa':
              NavigationService.goToHome();
              break;
            case 'Hakkımızda':
              NavigationService.goToAbout();
              break;
            case 'Projelerimiz':
              NavigationService.goToWorks();
              break;
            case 'Konferanslar':
              NavigationService.goToConferences();
              break;
            case 'İletişim':
              NavigationService.goToContact();
              break;
          }
        },
      ),
    );
  }

  Widget _buildMobileFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'İletişim',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        _buildMobileContactItem(Icons.email, 'info@ajanssebo.com'),
        _buildMobileContactItem(Icons.phone, '+90 (212) 123 45 67'),
        _buildMobileContactItem(Icons.location_on, 'İstanbul, Türkiye'),
      ],
    );
  }

  Widget _buildTabletFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İletişim',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 14),
        _buildTabletContactItem(Icons.email, 'info@ajanssebo.com'),
        _buildTabletContactItem(Icons.phone, '+90 (212) 123 45 67'),
        _buildTabletContactItem(Icons.location_on, 'İstanbul, Türkiye'),
      ],
    );
  }

  Widget _buildFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'İletişim',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFFE0E0E0),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem(Icons.email, 'info@ajanssebo.com'),
        _buildContactItem(Icons.phone, '+90 (212) 123 45 67'),
        _buildContactItem(Icons.location_on, 'İstanbul, Türkiye'),
      ],
    );
  }

  Widget _buildMobileContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFB0B0B0), size: 12),
          const SizedBox(width: 6),
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFFB0B0B0),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB0B0B0), size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFFB0B0B0),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFB0B0B0), size: 14),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFFB0B0B0),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileFooterBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Column(
        children: [
          Text(
            '© 2024 Şebo Agence. Tüm hakları saklıdır.',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 8,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Geliştirildi ❤️ ile',
            textAlign: TextAlign.center,
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletFooterBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2024 Şebo Agence. Tüm hakları saklıdır.',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 9,
            ),
          ),
          Text(
            'Geliştirildi ❤️ ile',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBottom() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF2A2A2A), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2024 Şebo Agence. Tüm hakları saklıdır.',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 10,
            ),
          ),
          Text(
            'Geliştirildi ❤️ ile',
            style: AppTypography.bodySmall.copyWith(
              color: const Color(0xFF808080),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// Hoverable Footer Link Widget
class _HoverableFooterLink extends StatefulWidget {
  final String text;
  final double fontSize;
  final TextAlign? textAlign;
  final VoidCallback onTap;

  const _HoverableFooterLink({
    required this.text,
    required this.fontSize,
    this.textAlign,
    required this.onTap,
  });

  @override
  State<_HoverableFooterLink> createState() => _HoverableFooterLinkState();
}

class _HoverableFooterLinkState extends State<_HoverableFooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Text(
            widget.text,
            textAlign: widget.textAlign,
            style: AppTypography.bodyMedium.copyWith(
              color: _isHovered ? Colors.white : const Color(0xFFB0B0B0),
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
