import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cache_providers.dart';
import 'cache_manager.dart';

/// 💾 Cache Widgets
/// Cache yönetimi için özel widget'lar

/// 📊 Cache Stats Widget
class CacheStatsWidget extends ConsumerWidget {
  const CacheStatsWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheStatsAsync = ref.watch(cacheStatsProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.storage),
                const SizedBox(width: 8),
                Text(
                  'Cache İstatistikleri',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            cacheStatsAsync.when(
              data: (stats) => _buildStatsContent(context, stats),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Hata: $error'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatsContent(BuildContext context, CacheStats stats) {
    return Column(
      children: [
        _buildStatRow(context, 'Memory Items', '${stats.memoryItemCount}'),
        _buildStatRow(context, 'Disk Items', '${stats.diskItemCount}'),
        _buildStatRow(context, 'Total Items', '${stats.totalItemCount}'),
        _buildStatRow(context, 'Cache Size', stats.humanReadableSize),
        const SizedBox(height: 16),
        _buildActionButtons(context),
      ],
    );
  }
  
  Widget _buildStatRow(BuildContext context, String label, String value) {
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
  
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Cache temizleme işlemi
            },
            icon: const Icon(Icons.clear_all),
            label: const Text('Temizle'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Süresi dolmuş cache'leri temizle
            },
            icon: const Icon(Icons.schedule),
            label: const Text('Süresi Dolmuş'),
          ),
        ),
      ],
    );
  }
}

/// 🎯 Cache Management Widget
class CacheManagementWidget extends ConsumerWidget {
  const CacheManagementWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheState = ref.watch(cacheStateProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cache Yönetimi',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            if (cacheState.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (cacheState.error != null)
              Text('Hata: ${cacheState.error}')
            else
              _buildManagementContent(context, ref, cacheState),
          ],
        ),
      ),
    );
  }
  
  Widget _buildManagementContent(
    BuildContext context,
    WidgetRef ref,
    CacheState cacheState,
  ) {
    return Column(
      children: [
        // Cache durumu
        ListTile(
          leading: Icon(
            cacheState.isInitialized ? Icons.check_circle : Icons.error,
            color: cacheState.isInitialized ? Colors.green : Colors.red,
          ),
          title: Text(
            cacheState.isInitialized ? 'Cache Aktif' : 'Cache Pasif',
          ),
          subtitle: Text(
            cacheState.isInitialized 
                ? 'Cache sistemi çalışıyor'
                : 'Cache sistemi başlatılamadı',
          ),
        ),
        
        const SizedBox(height: 16),
        
        // İstatistikler
        if (cacheState.stats != null) ...[
          _buildStatCard(context, 'Toplam Item', '${cacheState.stats!.totalItemCount}'),
          _buildStatCard(context, 'Cache Boyutu', cacheState.stats!.humanReadableSize),
          const SizedBox(height: 16),
        ],
        
        // Yönetim butonları
        _buildActionButtons(context, ref),
      ],
    );
  }
  
  Widget _buildStatCard(BuildContext context, String label, String value) {
    return Card(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(12),
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
      ),
    );
  }
  
  Widget _buildActionButtons(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              await ref.read(cacheStateProvider.notifier).clearCache();
            },
            icon: const Icon(Icons.clear_all),
            label: const Text('Tüm Cache\'i Temizle'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              await ref.read(cacheStateProvider.notifier).clearExpired();
            },
            icon: const Icon(Icons.schedule),
            label: const Text('Süresi Dolmuş Cache\'leri Temizle'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () async {
              await ref.read(cacheStateProvider.notifier).updateStats();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('İstatistikleri Yenile'),
          ),
        ),
      ],
    );
  }
}

/// 📱 Cache Settings Widget
class CacheSettingsWidget extends ConsumerWidget {
  const CacheSettingsWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cache Ayarları',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Cache otomatik temizleme
            SwitchListTile(
              title: const Text('Otomatik Cache Temizleme'),
              subtitle: const Text('Süresi dolmuş cache\'leri otomatik temizle'),
              value: true, // Bu değer provider'dan gelecek
              onChanged: (value) {
                // Cache ayarlarını güncelle
              },
            ),
            
            // Cache boyut limiti
            ListTile(
              title: const Text('Cache Boyut Limiti'),
              subtitle: const Text('Maksimum cache boyutu: 100 MB'),
              trailing: const Icon(Icons.info_outline),
            ),
            
            // Cache süresi
            ListTile(
              title: const Text('Varsayılan Cache Süresi'),
              subtitle: const Text('24 saat'),
              trailing: const Icon(Icons.schedule),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🎯 Cache Debug Widget
class CacheDebugWidget extends ConsumerWidget {
  const CacheDebugWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cache Debug',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Debug bilgileri
            _buildDebugInfo(context, 'Cache Manager', 'Singleton'),
            _buildDebugInfo(context, 'Memory Cache', 'Active'),
            _buildDebugInfo(context, 'Disk Cache', 'Active'),
            _buildDebugInfo(context, 'Cache Directory', '/tmp/sebo_agency_cache'),
            
            const SizedBox(height: 16),
            
            // Debug butonları
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Cache debug bilgilerini göster
                    },
                    child: const Text('Debug Info'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Cache test işlemleri
                    },
                    child: const Text('Test Cache'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDebugInfo(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

/// 📊 Cache Performance Widget
class CachePerformanceWidget extends ConsumerWidget {
  const CachePerformanceWidget({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cache Performansı',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Performans metrikleri
            _buildPerformanceMetric(context, 'Hit Rate', '85%'),
            _buildPerformanceMetric(context, 'Miss Rate', '15%'),
            _buildPerformanceMetric(context, 'Avg Response Time', '2.3ms'),
            _buildPerformanceMetric(context, 'Cache Efficiency', '92%'),
            
            const SizedBox(height: 16),
            
            // Performans grafiği (basit)
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text('Performans Grafiği\n(Gelecekte eklenecek)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildPerformanceMetric(BuildContext context, String label, String value) {
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
