import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'analytics_providers.dart';
import 'analytics_manager.dart';

/// 📊 Analytics Widgets
/// Analytics yönetimi için özel widget'lar

/// 📊 Analytics Dashboard Widget
class AnalyticsDashboard extends ConsumerWidget {
  const AnalyticsDashboard({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsState = ref.watch(analyticsStateProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics),
                const SizedBox(width: 8),
                Text(
                  'Analytics Dashboard',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            if (analyticsState.isInitialized) ...[
              _buildStatusCard(context, 'Analytics', 'Aktif', Colors.green),
              _buildStatusCard(context, 'Debug Mode', analyticsState.isDebugMode ? 'Açık' : 'Kapalı', 
                  analyticsState.isDebugMode ? Colors.orange : Colors.grey),
              
              const SizedBox(height: 16),
              
              if (analyticsState.report != null)
                _buildReportContent(context, analyticsState.report!)
              else
                _buildGenerateReportButton(context, ref),
            ] else ...[
              _buildInitializeButton(context, ref),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusCard(BuildContext context, String label, String value, Color color) {
    return Card(
      color: color.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInitializeButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          await ref.read(analyticsStateProvider.notifier).initialize(debugMode: true);
        },
        icon: const Icon(Icons.play_arrow),
        label: const Text('Analytics\'i Başlat'),
      ),
    );
  }
  
  Widget _buildGenerateReportButton(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          ref.read(analyticsStateProvider.notifier).generateReport();
        },
        icon: const Icon(Icons.assessment),
        label: const Text('Rapor Oluştur'),
      ),
    );
  }
  
  Widget _buildReportContent(BuildContext context, AnalyticsReport report) {
    return Column(
      children: [
        _buildReportMetric(context, 'Toplam Event', '${report.totalEvents}'),
        _buildReportMetric(context, 'En Popüler Kategori', report.topCategory),
        _buildReportMetric(context, 'En Popüler Sayfa', report.topPage),
        _buildReportMetric(context, 'En Popüler Buton', report.topButton),
        _buildReportMetric(context, 'Hata Sayısı', '${report.errorCount}'),
      ],
    );
  }
  
  Widget _buildReportMetric(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

/// 🎯 Analytics Events Widget
class AnalyticsEventsWidget extends ConsumerWidget {
  const AnalyticsEventsWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(analyticsEventProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.event),
                const SizedBox(width: 8),
                Text(
                  'Analytics Events',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Text('${events.length} events'),
              ],
            ),
            const SizedBox(height: 16),
            
            if (events.isEmpty)
              const Center(
                child: Text('Henüz event yok'),
              )
            else
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return _buildEventItem(context, event);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEventItem(BuildContext context, AnalyticsEvent event) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Icon(_getEventIcon(event.name)),
        title: Text(event.name),
        subtitle: Text('${event.category} - ${event.action}'),
        trailing: Text(
          _formatTime(event.timestamp),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        onTap: () {
          _showEventDetails(context, event);
        },
      ),
    );
  }
  
  IconData _getEventIcon(String eventName) {
    switch (eventName) {
      case 'page_view':
        return Icons.visibility;
      case 'button_click':
        return Icons.touch_app;
      case 'form_submit':
        return Icons.send;
      case 'api_call':
        return Icons.api;
      case 'error':
        return Icons.error;
      case 'user_interaction':
        return Icons.person;
      default:
        return Icons.event;
    }
  }
  
  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Şimdi';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}dk önce';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}sa önce';
    } else {
      return '${difference.inDays}gün önce';
    }
  }
  
  void _showEventDetails(BuildContext context, AnalyticsEvent event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kategori: ${event.category}'),
            Text('Aksiyon: ${event.action}'),
            if (event.label != null) Text('Etiket: ${event.label}'),
            if (event.value != null) Text('Değer: ${event.value}'),
            Text('Zaman: ${event.timestamp}'),
            if (event.parameters.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text('Parametreler:', style: TextStyle(fontWeight: FontWeight.bold)),
              ...event.parameters.entries.map((entry) => 
                Text('${entry.key}: ${entry.value}')),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }
}

/// 📱 Analytics Settings Widget
class AnalyticsSettingsWidget extends ConsumerWidget {
  const AnalyticsSettingsWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsState = ref.watch(analyticsStateProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics Ayarları',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Analytics etkinleştir/devre dışı bırak
            SwitchListTile(
              title: const Text('Analytics Etkin'),
              subtitle: const Text('Analytics verilerini topla'),
              value: analyticsState.isEnabled,
              onChanged: (value) {
                ref.read(analyticsStateProvider.notifier).setEnabled(value);
              },
            ),
            
            // Debug modu
            SwitchListTile(
              title: const Text('Debug Modu'),
              subtitle: const Text('Debug bilgilerini göster'),
              value: analyticsState.isDebugMode,
              onChanged: (value) {
                ref.read(analyticsStateProvider.notifier).setDebugMode(value);
              },
            ),
            
            const SizedBox(height: 16),
            
            // Yönetim butonları
            _buildManagementButtons(context, ref),
          ],
        ),
      ),
    );
  }
  
  Widget _buildManagementButtons(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              ref.read(analyticsStateProvider.notifier).generateReport();
            },
            icon: const Icon(Icons.assessment),
            label: const Text('Rapor Oluştur'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              ref.read(analyticsStateProvider.notifier).clearEvents();
            },
            icon: const Icon(Icons.clear_all),
            label: const Text('Event\'leri Temizle'),
          ),
        ),
      ],
    );
  }
}

/// 🎯 Analytics Tracking Widget
class AnalyticsTrackingWidget extends ConsumerWidget {
  final Widget child;
  final String? pageName;
  final Map<String, dynamic>? parameters;
  
  const AnalyticsTrackingWidget({
    super.key,
    required this.child,
    this.pageName,
    this.parameters,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Widget mount edildiğinde sayfa ziyaret takibi
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageName != null) {
        ref.read(analyticsTrackingProvider).trackPageView(pageName!, parameters: parameters);
      }
    });
    
    return child;
  }
}

/// 📊 Analytics Test Widget
class AnalyticsTestWidget extends ConsumerWidget {
  const AnalyticsTestWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsTracking = ref.read(analyticsTrackingProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics Test',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Test butonları
            _buildTestButton(
              context,
              'Sayfa Ziyaret Test',
              () => analyticsTracking.trackPageView('test_page'),
            ),
            _buildTestButton(
              context,
              'Buton Tıklama Test',
              () => analyticsTracking.trackButtonClick('test_button'),
            ),
            _buildTestButton(
              context,
              'Form Gönderim Test',
              () => analyticsTracking.trackFormSubmit('test_form'),
            ),
            _buildTestButton(
              context,
              'Hata Test',
              () => analyticsTracking.trackError('test_error', 'Test error message'),
            ),
            _buildTestButton(
              context,
              'Özel Event Test',
              () => analyticsTracking.trackCustomEvent('test_custom_event'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTestButton(BuildContext context, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(label),
        ),
      ),
    );
  }
}
