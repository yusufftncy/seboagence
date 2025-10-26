/// ⚡ Simple Loading Indicator Widget
///
/// Bu widget, sayfa geçişlerinde basit yükleme göstergesi gösterir.
library;

import 'package:flutter/material.dart';
import '../../core/theme/branding.dart';

class SimpleLoadingIndicator extends StatefulWidget {
  final String? message;
  final Color? color;

  const SimpleLoadingIndicator({super.key, this.message, this.color});

  @override
  State<SimpleLoadingIndicator> createState() => _SimpleLoadingIndicatorState();
}

class _SimpleLoadingIndicatorState extends State<SimpleLoadingIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: const Color(0xFF131B2E),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 20.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dönen yükleme göstergesi
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value * 2 * 3.14159,
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: widget.color ?? Branding.primary,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Icon(
                        Icons.refresh,
                        color: Branding.white,
                        size: 24.0,
                      ),
                    ),
                  );
                },
              ),

              if (widget.message != null) ...[
                const SizedBox(height: 16.0),
                Text(
                  widget.message!,
                  style: const TextStyle(
                    color: Branding.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Sayfa geçişi için overlay loading
class PageTransitionLoading extends StatelessWidget {
  final String? message;

  const PageTransitionLoading({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SimpleLoadingIndicator(
        message: message ?? 'Yükleniyor...',
        color: Branding.primary,
      ),
    );
  }
}
