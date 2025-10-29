/// 🏢 CCI France-Turquie Event Detail Page - CCI France-Turquie Etkinlik Serisi detay sayfası
import 'package:flutter/material.dart';
import '../../core/theme/typography.dart';
import '../../core/utils/responsive.dart';

class CciFranceTurquieEventDetailPage extends StatelessWidget {
  const CciFranceTurquieEventDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2C2C2C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'CCI France-Turquie Etkinlik Serisi',
          style: AppTypography.h6.copyWith(
            color: const Color(0xFF2C2C2C),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Responsive.responsiveWidget(
        context,
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildEventInfo(context),
            const SizedBox(height: 20),
            _buildDescription(context),
            const SizedBox(height: 20),
            _buildPartners(context),
            const SizedBox(height: 20),
            _buildOrganizer(context),
            const SizedBox(height: 20),
            _buildGallery(context),
            const SizedBox(height: 20),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildEventInfo(context),
            const SizedBox(height: 24),
            _buildDescription(context),
            const SizedBox(height: 24),
            _buildPartners(context),
            const SizedBox(height: 24),
            _buildOrganizer(context),
            const SizedBox(height: 24),
            _buildGallery(context),
            const SizedBox(height: 24),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildEventInfo(context),
            const SizedBox(height: 32),
            _buildDescription(context),
            const SizedBox(height: 32),
            _buildPartners(context),
            const SizedBox(height: 32),
            _buildOrganizer(context),
            const SizedBox(height: 32),
            _buildGallery(context),
            const SizedBox(height: 32),
            _buildBackButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6B6B6B),
            const Color(0xFF4A4A4A),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etkinlik tipi
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Etkinlik',
              style: AppTypography.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Başlık
          Text(
            'CCI France-Turquie Etkinlik Serisi',
            style: AppTypography.h3.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: Responsive.responsiveValue(
                context,
                mobile: 20,
                tablet: 24,
                desktop: 28,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Tarih ve lokasyon
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.white.withValues(alpha: 0.8),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Ekim 2025',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 24),
              Icon(
                Icons.location_on,
                color: Colors.white.withValues(alpha: 0.8),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'İstanbul, Türkiye',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Etkinlik Bilgileri',
            style: AppTypography.h5.copyWith(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Tarih', 'Ekim 2025', Icons.calendar_today),
          const SizedBox(height: 12),
          _buildInfoRow('Lokasyon', 'İstanbul, Türkiye', Icons.location_on),
          const SizedBox(height: 12),
          _buildInfoRow('Tip', 'Etkinlik', Icons.event),
          const SizedBox(height: 12),
          _buildInfoRow('Durum', 'Tamamlandı', Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF6B6B6B),
          size: 16,
        ),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: AppTypography.bodyMedium.copyWith(
            color: const Color(0xFF6B6B6B),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Etkinlik Açıklaması',
            style: AppTypography.h5.copyWith(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Fransız Ticaret Odası CCI France-Turquie tarafından düzenlenen özel etkinlik serisi. Sebnem Berkol Yuceer\'in değerli desteğiyle organize edilen bu etkinlikte, iş dünyasından önemli isimler bir araya gelerek networking ve bilgi paylaşımı gerçekleştirdi.\n\nBu etkinlik serisinde, Türkiye ve Fransa arasındaki ticari ilişkilerin geliştirilmesi, yeni iş fırsatlarının değerlendirilmesi ve sektörel deneyimlerin paylaşılması amaçlandı. Katılımcılar, farklı sektörlerden profesyonellerle tanışma ve işbirliği fırsatları oluşturma şansı buldular.\n\nEtkinlik boyunca panel tartışmaları, sektörel sunumlar ve networking oturumları düzenlendi. Katılımcılar, Türk-Fransız iş dünyasının güncel durumu, gelecek fırsatları ve ortak projeler hakkında değerli bilgiler edindiler.',
            style: AppTypography.bodyMedium.copyWith(
              color: const Color(0xFF6B6B6B),
              height: 1.6,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartners(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ortaklar',
            style: AppTypography.h5.copyWith(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              'CCI France-Turquie',
              'Sebnem Berkol Yuceer',
              'İş Dünyası Temsilcileri',
              'Fransız Ticaret Odası',
            ].map((partner) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                ),
                child: Text(
                  partner,
                  style: AppTypography.bodySmall.copyWith(
                    color: const Color(0xFF6B6B6B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildOrganizer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Organizatör',
            style: AppTypography.h5.copyWith(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B6B6B).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.business,
                  color: const Color(0xFF6B6B6B),
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sebnem Berkol Yuceer',
                      style: AppTypography.h6.copyWith(
                        color: const Color(0xFF2C2C2C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'CCI France-Turquie Yönetim Kurulu Üyesi',
                      style: AppTypography.bodyMedium.copyWith(
                        color: const Color(0xFF6B6B6B),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'CCI France-Turquie\'nin değerli yönetim kurulu üyesi. Türk-Fransız ticari ilişkilerinin geliştirilmesi ve iş dünyası etkinliklerinin organize edilmesi konularında uzman.',
                      style: AppTypography.bodySmall.copyWith(
                        color: const Color(0xFF6B6B6B),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGallery(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B6B6B).withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Galeri',
            style: AppTypography.h5.copyWith(
              color: const Color(0xFF2C2C2C),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        color: const Color(0xFF6B6B6B),
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fotoğraf ${index + 1}',
                        style: AppTypography.bodySmall.copyWith(
                          color: const Color(0xFF6B6B6B),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xFF6B6B6B), const Color(0xFF4A4A4A)],
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6B6B6B).withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.arrow_back, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                'Geri Dön',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
