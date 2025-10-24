// 📱 Usage Examples
// Loading States & UI Feedback kullanım örnekleri

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../index.dart';

/// 🎯 Usage Examples
/// Loading States & UI Feedback kullanım örnekleri

/// 📱 Loading States Kullanım Örnekleri
class LoadingStatesExamples extends ConsumerWidget {
  const LoadingStatesExamples({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loading States Examples')),
      body: Column(
        children: [
          // Global Loading Button
          ElevatedButton(
            onPressed: () {
              LoadingStateManager.setGlobalLoading(ref, true);
              Future.delayed(const Duration(seconds: 2), () {
                LoadingStateManager.setGlobalLoading(ref, false);
              });
            },
            child: const Text('Global Loading Test'),
          ),

          // Feature Loading Button
          ElevatedButton(
            onPressed: () {
              LoadingStateManager.setFeatureLoading(ref, 'projects', true);
              Future.delayed(const Duration(seconds: 2), () {
                LoadingStateManager.setFeatureLoading(ref, 'projects', false);
              });
            },
            child: const Text('Feature Loading Test'),
          ),

          // Form Loading Button
          ElevatedButton(
            onPressed: () {
              LoadingStateManager.setFormLoading(ref, 'contact', true);
              Future.delayed(const Duration(seconds: 2), () {
                LoadingStateManager.setFormLoading(ref, 'contact', false);
              });
            },
            child: const Text('Form Loading Test'),
          ),

          // Loading Button Example
          const LoadingButton(
            text: 'Submit',
            loadingText: 'Submitting...',
            form: 'contact',
          ),
        ],
      ),
    );
  }
}

/// 📱 Feedback Kullanım Örnekleri
class FeedbackExamples extends ConsumerWidget {
  const FeedbackExamples({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback Examples')),
      body: Column(
        children: [
          // Success Feedback
          ElevatedButton(
            onPressed: () {
              FeedbackManager.showSuccess(
                ref,
                'Başarılı!',
                'İşlem başarıyla tamamlandı.',
              );
            },
            child: const Text('Success Feedback'),
          ),

          // Error Feedback
          ElevatedButton(
            onPressed: () {
              FeedbackManager.showError(
                ref,
                'Hata!',
                'Bir hata oluştu, lütfen tekrar deneyin.',
              );
            },
            child: const Text('Error Feedback'),
          ),

          // Warning Feedback
          ElevatedButton(
            onPressed: () {
              FeedbackManager.showWarning(
                ref,
                'Uyarı!',
                'Bu işlem geri alınamaz.',
              );
            },
            child: const Text('Warning Feedback'),
          ),

          // Info Feedback
          ElevatedButton(
            onPressed: () {
              FeedbackManager.showInfo(
                ref,
                'Bilgi',
                'Yeni özellik eklendi.',
              );
            },
            child: const Text('Info Feedback'),
          ),

          // Snackbar Examples
          ElevatedButton(
            onPressed: () {
              SnackbarFeedback.showSuccess(context, 'Snackbar Success!');
            },
            child: const Text('Snackbar Success'),
          ),

          // Dialog Examples
          ElevatedButton(
            onPressed: () {
              DialogFeedback.showSuccess(
                context,
                'Dialog Success',
                'Bu bir başarı dialog\'udur.',
              );
            },
            child: const Text('Dialog Success'),
          ),
        ],
      ),
    );
  }
}

/// 📱 Animation Kullanım Örnekleri
class AnimationExamples extends StatelessWidget {
  const AnimationExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Examples')),
      body: Column(
        children: [
          // Fade Animation
          const FadeAnimation(
            child: Card(
              child: ListTile(
                title: Text('Fade Animation'),
                subtitle: Text('Bu kart fade animasyonu ile görünür'),
              ),
            ),
          ),

          // Slide Animation
          const SlideAnimation(
            child: Card(
              child: ListTile(
                title: Text('Slide Animation'),
                subtitle: Text('Bu kart slide animasyonu ile görünür'),
              ),
            ),
          ),

          // Scale Animation
          const ScaleAnimation(
            child: Card(
              child: ListTile(
                title: Text('Scale Animation'),
                subtitle: Text('Bu kart scale animasyonu ile görünür'),
              ),
            ),
          ),

          // Loading Animation
          const Center(
            child: LoadingAnimation(
              size: 48,
              color: Colors.blue,
            ),
          ),

          // Pulse Animation
          const PulseAnimation(
            child: Card(
              child: ListTile(
                title: Text('Pulse Animation'),
                subtitle: Text('Bu kart pulse animasyonu ile görünür'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 📱 Complete Example
class CompleteExample extends ConsumerWidget {
  const CompleteExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlobalLoadingOverlay(
      child: FeedbackOverlay(
        child: Scaffold(
          appBar: AppBar(title: const Text('Complete Example')),
          body: Column(
            children: [
              // Loading States
              const Text('Loading States:', style: TextStyle(fontSize: 18)),
              ElevatedButton(
                onPressed: () {
                  LoadingStateManager.setGlobalLoading(ref, true);
                  Future.delayed(const Duration(seconds: 2), () {
                    LoadingStateManager.setGlobalLoading(ref, false);
                    FeedbackManager.showSuccess(
                      ref,
                      'Başarılı!',
                      'Loading tamamlandı.',
                    );
                  });
                },
                child: const Text('Test Loading + Feedback'),
              ),

              // Animations
              const Text('Animations:', style: TextStyle(fontSize: 18)),
              const FadeAnimation(
                child: Card(
                  child: ListTile(
                    title: Text('Animated Card'),
                    subtitle: Text('Bu kart animasyonlu'),
                  ),
                ),
              ),

              // Loading Button
              const LoadingButton(
                text: 'Submit Form',
                loadingText: 'Submitting...',
                form: 'contact',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
